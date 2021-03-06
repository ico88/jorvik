import datetime
import json
import random
from django.core.paginator import Paginator
from django.db.models import Sum, Q
from django.shortcuts import redirect, get_object_or_404
from django.utils import timezone
from anagrafica.costanti import REGIONALE
from anagrafica.forms import ModuloNuovoProvvedimento
from anagrafica.models import Appartenenza, Persona, Estensione, ProvvedimentoDisciplinare, Sede, Dimissione, Riserva
from anagrafica.permessi.applicazioni import PRESIDENTE
from anagrafica.permessi.costanti import GESTIONE_SOCI, ELENCHI_SOCI , ERRORE_PERMESSI, MODIFICA, EMISSIONE_TESSERINI
from autenticazione.forms import ModuloCreazioneUtenza
from autenticazione.funzioni import pagina_privata, pagina_pubblica
from base.errori import errore_generico, errore_nessuna_appartenenza, messaggio_generico
from base.files import Excel, FoglioExcel
from base.notifiche import NOTIFICA_INVIA
from base.utils import poco_fa, testo_euro, oggi
from posta.models import Messaggio
from posta.utils import imposta_destinatari_e_scrivi_messaggio
from ufficio_soci.elenchi import ElencoSociAlGiorno, ElencoSostenitori, ElencoVolontari, ElencoOrdinari, \
    ElencoElettoratoAlGiorno, ElencoQuote, ElencoPerTitoli, ElencoDipendenti, ElencoDimessi, ElencoTrasferiti, \
    ElencoVolontariGiovani, ElencoEstesi, ElencoInRiserva, ElencoIVCM, ElencoTesseriniSenzaFototessera, \
    ElencoTesseriniRichiesti, ElencoTesseriniDaRichiedere
from ufficio_soci.forms import ModuloCreazioneEstensione, ModuloAggiungiPersona, ModuloReclamaAppartenenza, \
    ModuloReclamaQuota, ModuloReclama, ModuloCreazioneDimissioni, ModuloVerificaTesserino, ModuloElencoRicevute, \
    ModuloCreazioneRiserva, ModuloCreazioneTrasferimento, ModuloQuotaVolontario, ModuloNuovaRicevuta, ModuloFiltraEmissioneTesserini, \
    ModuloLavoraTesserini, ModuloScaricaTesserini
from ufficio_soci.models import Quota, Tesseramento, Tesserino


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us(request, me):
    """
    Ritorna la home page per la gestione dei soci.
    """

    sedi = me.oggetti_permesso(GESTIONE_SOCI)

    persone = Persona.objects.filter(
        Appartenenza.query_attuale(sede__in=sedi).via("appartenenze")
    )
    attivi = Persona.objects.filter(
        Appartenenza.query_attuale(sede__in=sedi, membro=Appartenenza.VOLONTARIO).via("appartenenze")
    )

    contesto = {
        "sedi": sedi,
        "persone": persone,
        "attivi": attivi,
    }

    return 'us.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_aggiungi(request, me):

    modulo_persona = ModuloAggiungiPersona(request.POST or None)

    if modulo_persona.is_valid():
        persona = modulo_persona.save()
        return redirect("/us/reclama/%d/" % (persona.pk,))

    contesto = {
        "modulo_persona": modulo_persona
    }
    return 'us_aggiungi.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_reclama(request, me):
    """
    Mostra il modulo per reclamare una persona.
    """

    modulo = ModuloReclama(request.POST or None)

    if modulo.is_valid():

        try:
            p = Persona.objects.get(codice_fiscale=modulo.cleaned_data['codice_fiscale'])

            sedi = []
            ss = me.oggetti_permesso(GESTIONE_SOCI)
            for s in ss:  # Per ogni sede di mia competenza
                if p.reclamabile_in_sede(s):  # Posso reclamare?
                    sedi += [s]  # Aggiungi a elenco sedi

            if sedi:
                return redirect("/us/reclama/%d/" % (p.pk,))

            else:
                modulo.add_error('codice_fiscale', "Non puoi reclamare questa persona "
                                                   "in nessuna delle tue Sedi. Potrebbe "
                                                   "essere già appartenente a qualche "
                                                   "Comitato. ")

        except Persona.DoesNotExist:
            modulo.add_error('codice_fiscale', "Nessuna Persona registrata in Gaia "
                                               "con questo codice fiscale.")

    contesto = {
        "modulo": modulo
    }

    return 'us_reclama.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_reclama_persona(request, me, persona_pk):

    persona = get_object_or_404(Persona, pk=persona_pk)

    sedi = []
    ss = me.oggetti_permesso(GESTIONE_SOCI)
    for s in ss:  # Per ogni sede di mia competenza
        if persona.reclamabile_in_sede(s):  # Posso reclamare?
            sedi += [s]  # Aggiungi a elenco sedi

    if not sedi:  # Se non posso reclamarlo in nessuna sede
        return errore_generico(request, me, titolo="Impossibile reclamare appartenenza",
                               messaggio="Questa persona non può essere reclamata in "
                                         "nessuna delle sedi di tua competenza. ",
                               torna_titolo="Torna indietro",
                               torna_url="/us/reclama/")

    sedi_qs = Sede.objects.filter(pk__in=[x.pk for x in sedi])

    modulo_appartenenza = ModuloReclamaAppartenenza(request.POST or None, sedi=sedi_qs, prefix="app")
    modulo_appartenenza.fields['membro'].choices = ((k, v) for k, v in dict(Appartenenza.MEMBRO).items()
                                                    if k in Appartenenza.MEMBRO_RECLAMABILE)
    modulo_quota = ModuloReclamaQuota(request.POST or None, prefix="quota")

    if modulo_appartenenza.is_valid():
        if modulo_quota.is_valid():

            continua = True
            if modulo_quota.cleaned_data['registra_quota'] == modulo_quota.SI:
                if not Tesseramento.aperto_anno(
                    modulo_quota.cleaned_data['data_versamento'].year
                ):
                    modulo_quota.add_error('data_versamento', "Spiacente, non è possibile registrare quote "
                                                              "per l'anno selezionato. ")
                    continua = False

                if modulo_quota.cleaned_data['importo_totale'] <= 1:
                    modulo_quota.add_error('importo_totale', "Importo obbligatorio. Se non vuoi salvare la quota ora, "
                                                             "seleziona 'No' su 'Registra Quota'.")
                    continua = False

            vecchia_appartenenza = Appartenenza.query_attuale(persona=persona,
                                                              membro=Appartenenza.ORDINARIO).first()
            if vecchia_appartenenza:  # Se ordinario presso il regionale.
                if modulo_appartenenza.cleaned_data['inizio'] < vecchia_appartenenza.inizio:
                    modulo_appartenenza.add_error('inizio', "La persona non era socio ordinario CRI alla "
                                                            "data selezionata. Inserisci la data corretta di "
                                                            "cambio appartenenza.")
                    continua = False

            # Controllo eta' minima socio
            if modulo_appartenenza.cleaned_data.get('membro') in Appartenenza.MEMBRO_SOCIO \
                    and persona.eta < Persona.ETA_MINIMA_SOCIO:
                modulo_appartenenza.add_error('membro', "I soci di questo tipo devono avere almeno "
                                                        "%d anni. " % Persona.ETA_MINIMA_SOCIO)
                continua = False

            if continua:

                app = modulo_appartenenza.save(commit=False)
                app.persona = persona
                app.save()

                if vecchia_appartenenza:  # Termina app. ordinario
                    vecchia_appartenenza.fine = app.inizio
                    vecchia_appartenenza.save()

                q = modulo_quota.cleaned_data

                if q.get('registra_quota') == modulo_quota.SI:
                    quota = Quota.nuova(
                        appartenenza=app,
                        data_versamento=q.get('data_versamento'),
                        registrato_da=me,
                        importo=q.get('importo_totale'),
                        causale="Iscrizione %s anno %d" % (
                            app.get_membro_display(),
                            q.get('data_versamento').year,
                        ),
                        tipo=Quota.QUOTA_SOCIO,
                        invia_notifica=True
                    )

                return redirect(persona.url)

    contesto = {
        "modulo_appartenenza": modulo_appartenenza,
        "modulo_quota": modulo_quota,
        "persona": persona,
    }

    return 'us_reclama_persona.html', contesto



@pagina_privata
def us_dimissioni(request, me, pk):

    modulo = ModuloCreazioneDimissioni(request.POST or None)
    persona = get_object_or_404(Persona, pk=pk)

    if not me.permessi_almeno(persona, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    if modulo.is_valid():
        dim = modulo.save(commit=False)
        dim.richiedente = me
        dim.persona = persona
        dim.sede = dim.persona.sede_riferimento()
        dim.appartenenza = persona.appartenenze_attuali().first()
        if modulo.cleaned_data['trasforma_in_sostenitore']:
            app = Appartenenza(precedente=dim.appartenenza, persona=dim.persona, sede=dim.persona.sede_riferimento(),
                               inizio=datetime.date.today(),
                               membro=Appartenenza.SOSTENITORE)
            app.save()
        dim.save()
        dim.applica()
        return messaggio_generico(request, me, titolo="Dimissioni registrate",
                                      messaggio="Le dimissioni sono"
                                                "state registrate con successo",
                                      torna_titolo="Vai allo storico appartenenze",
                                      torna_url=persona.url_profilo_appartenenze)

    contesto = {
        "modulo": modulo,
        "persona": persona,
    }

    return 'us_dimissioni.html', contesto




@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_estensione(request, me):
    """
    Vista per la creazione di una nuova estensione da ufficio soci.
    """

    sedi = me.oggetti_permesso(GESTIONE_SOCI)            # es. per controllare che il volontario
                                                         # sia appartente attualmente
                                                         #     ad una delle sedi che gestisco io
    modulo = ModuloCreazioneEstensione(request.POST or None)

    if modulo.is_valid():
        est = modulo.save(commit=False)
        if not est.persona.sede_riferimento():
            return errore_nessuna_appartenenza(request, me)
        if not me.permessi_almeno(est.persona, MODIFICA):
            return redirect(ERRORE_PERMESSI)
        if est.destinazione in est.persona.sedi_attuali():
            modulo.add_error('destinazione', 'Il volontario è già appartenente a questa sede.')
        elif est.destinazione in [x.destinazione for x in me.estensioni_attuali_e_in_attesa()]:
            modulo.add_error('destinazione', 'Il volontario ha già una richiesta di estensione a questa sede.')
        else:
            est.richiedente = me
            est.save()
            est.richiedi()
            return messaggio_generico(request, me, titolo="Estensione richiesta",
                                      messaggio="L'estensione è stata"
                                                "registrata con successo",
                                      torna_titolo="Registra nuova estensione",
                                      torna_url="/us/estensione/")
    contesto = {
        "sedi": sedi,
        "modulo": modulo,
    }

    return 'us_estensione.html', contesto

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_trasferimento(request, me):
    """
    Vista per la creazione di una nuova estensione da ufficio soci.
    """

    sedi = me.oggetti_permesso(GESTIONE_SOCI)            # es. per controllare che il volontario sia appartente attualmente
                                                         #     ad una delle sedi che gestisco io

    modulo = ModuloCreazioneTrasferimento(request.POST or None)

    if modulo.is_valid():
        trasf = modulo.save(commit=False)
        if not trasf.persona.sede_riferimento():
            return errore_nessuna_appartenenza(request, me)
        if not me.permessi_almeno(trasf.persona, MODIFICA):
            return redirect(ERRORE_PERMESSI)
        if trasf.destinazione in trasf.persona.sedi_attuali():
            modulo.add_error('destinazione', 'Il volontario è già appartenente a questa sede.')
        #elif trasf.destinazione.comitato != trasf.persona.sede_riferimento().comitato and True:##che in realta' e' il discriminatore delle elezioni
        #   return errore_generico(request, me, messaggio="Non puoi richiedere un trasferimento tra comitati durante il periodo elettorale", torna_url="/us/trasferimento/")
        elif trasf.persona.trasferimento:
            return errore_generico(request, me, messaggio="Il Volontario non può avere piú di una richiesta di trasferimento alla volta", torna_url="/us/trasferimento/")
        else:
            trasf.richiedente = me
            trasf.save()
            if me.sede_riferimento().comitato == trasf.destinazione.comitato:
                trasf.esegui()

                Messaggio.costruisci_e_invia(
                    oggetto="Richiesta di trasferimento",
                    modello="email_richiesta_trasferimento_cc.html",
                    corpo={
                        "trasferimento": trasf,
                    },
                    mittente=None,
                    destinatari=[
                        trasf.destinazione.presidente()
                    ]
                )

                return messaggio_generico(request, me, titolo="Trasferimento effettuato",
                                      messaggio="Il trasferimento è stato automaticamente effettuato in quanto il "
                                                "la destinazione e' un'unita' territoriale "
                                                "appartenente al suo comitato",
                                      torna_titolo="Richiedi nuovo trasferimento",
                                      torna_url="/us/trasferimento/")
            else:
                trasf.richiedi()

                Messaggio.costruisci_e_invia(
                    oggetto="Richiesta di trasferimento",
                    modello="email_richiesta_trasferimento_cc.html",
                    corpo={
                        "trasferimento": trasf,
                    },
                    mittente=None,
                    destinatari=[
                        trasf.destinazione.presidente()
                    ]
                )

                return messaggio_generico(request, me, titolo="Trasferimento richiesto",
                                      messaggio="Il trasferimento è stato richiesto, ora dovrai accettare la richiesta!",
                                      torna_titolo="Richiedi nuovo trasferimento",
                                      torna_url="/us/trasferimento/")

    contesto = {
        "sedi": sedi,
        "modulo": modulo,
    }

    return 'us_trasferimento.html', contesto

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_estensioni(request, me):
    sedi = me.oggetti_permesso(GESTIONE_SOCI)
    estensioni = Estensione.filter(destinazione__in=(sedi))

    contesto = {
        'estensioni': estensioni,
    }

    return 'us_estensioni.html', contesto

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_estensione_termina(request, me, pk):
    appartenenza = get_object_or_404(Appartenenza, pk=pk)
    if me.permessi_almeno(appartenenza, MODIFICA):
        return redirect(ERRORE_PERMESSI)
    else:
        appartenenza.fine = poco_fa()
        appartenenza.terminazione = Appartenenza.FINE_ESTENSIONE
        appartenenza.save()
        return messaggio_generico(request, me, titolo="Estensione terminata",
                                      messaggio="L'estensione è stata"
                                                "terminata con successo",
                                      torna_titolo="Registra nuova estensione",
                                      torna_url="/us/estensione/")

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_riserva_termina(request, me, pk):
    riserva = get_object_or_404(Riserva, pk=pk)
    if not me.permessi_almeno(riserva.persona, MODIFICA):
        return redirect(ERRORE_PERMESSI)
    else:
        riserva.termina()
        return messaggio_generico(request, me, titolo="Riserva terminata",
                                      messaggio="La riserva è stata"
                                                "terminata con successo",
                                      torna_titolo="Registra nuova riserva",
                                      torna_url="/us/riserva/")


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_provvedimento(request, me):

    modulo = ModuloNuovoProvvedimento(request.POST or None)
    modulo.fields['sede'].queryset=me.oggetti_permesso(GESTIONE_SOCI)
    if modulo.is_valid():
        if not me.permessi_almeno(modulo.cleaned_data['persona'], MODIFICA):
            modulo.add_error('persona', "Non puoi registrare provvedimenti per questo Volontario!")
        else:
            provvedimento = modulo.save()
            provvedimento.registrato_da = me
            provvedimento.esegui()
            return messaggio_generico(request, me, titolo="Provvedimento inserito",
                                      messaggio="Il provvedimento è stato inserito con successo",
                                      torna_titolo="Inserisci nuovo provvedimento",
                                      torna_url="/us/provvedimento/")

    contesto = {
        "modulo": modulo,
    }

    return "us_provvedimento.html", contesto



@pagina_privata
def us_elenco(request, me, elenco_id=None, pagina=1):

    pagina = int(pagina)
    if pagina < 0:
        pagina = 1

    try:  # Prova a ottenere l'elenco dalla sessione.
        elenco = request.session["elenco_%s" % (elenco_id,)]

    except KeyError:  # Se l'elenco non e' piu' in sessione, potrebbe essere scaduto.
        return errore_generico(request, me, titolo="Sessione scaduta",
                               messaggio="Ricarica la pagina.",
                               torna_url=request.path, torna_titolo="Riprova")

    if elenco.modulo():  # Se l'elenco richiede un modulo

        try:  # Prova a recuperare il modulo riempito
            modulo = elenco.modulo()(request.session["elenco_modulo_%s" % (elenco_id,)])

        except KeyError:  # Se fallisce, il modulo non e' stato ancora compilato
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))

        if not modulo.is_valid():  # Se il modulo non e' valido, qualcosa e' andato storto
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))  # Prova nuovamente?

        elenco.modulo_riempito = modulo  # Imposta il modulo

    if request.POST:  # Cambiato il termine di ricerca?
        # Memorizza il nuovo termine
        request.session["elenco_filtra_%s" % (elenco_id,)] = request.POST['filtra']
        # Torna alla prima pagina
        return redirect("/us/elenco/%s/%d/" % (elenco_id, 1))

    # Eventuale termine di ricerca
    filtra = request.session.get("elenco_filtra_%s" % (elenco_id,), default="")

    pagina_precedente = "/us/elenco/%s/%d/" % (elenco_id, pagina-1)
    pagina_successiva = "/us/elenco/%s/%d/" % (elenco_id, pagina+1)
    download_url = "/us/elenco/%s/download/" % (elenco_id,)
    messaggio_url = "/us/elenco/%s/messaggio/" % (elenco_id,)

    risultati = elenco.ordina(elenco.risultati())
    if filtra:  # Se keyword specificata, filtra i risultati
        risultati = elenco.filtra(risultati, filtra)

    p = Paginator(risultati, 15)  # Pagina (num risultati per pagina)
    pg = p.page(pagina)

    contesto = {
        'pagina': pagina,
        'pagine': p.num_pages,
        'totale': p.count,
        'risultati': pg.object_list,
        'ha_precedente': pg.has_previous(),
        'ha_successivo': pg.has_next(),
        'pagina_precedente': pagina_precedente,
        'pagina_successiva': pagina_successiva,
        'elenco_id': elenco_id,
        'download_url': download_url,
        'messaggio_url': messaggio_url,
        'filtra': filtra,
    }
    contesto.update(**elenco.kwargs)

    return elenco.template(), contesto


@pagina_privata
def us_elenco_modulo(request, me, elenco_id):

    try:  # Prova a ottenere l'elenco dalla sessione.
        elenco = request.session["elenco_%s" % (elenco_id,)]

    except KeyError:  # Se l'elenco non e' piu' in sessione, potrebbe essere scaduto.
        raise ValueError("Elenco non presente in sessione.")

    if not elenco.modulo():  # No modulo? Vai all'elenco
        return redirect("/us/elenco/%s/1/" % (elenco_id,))

    modulo = elenco.modulo()(request.POST or None)

    if request.POST and modulo.is_valid():  # Modulo ok
        request.session["elenco_modulo_%s" % (elenco_id,)] = request.POST            # Salva modulo in sessione
        return redirect("/us/elenco/%s/1/" % (elenco_id,))                           # Redirigi alla prima pagina

    contesto = {
        "modulo": modulo
    }

    return 'us_elenchi_inc_modulo.html', contesto


@pagina_privata
def us_elenco_download(request, me, elenco_id):

    try:  # Prova a ottenere l'elenco dalla sessione.
        elenco = request.session["elenco_%s" % (elenco_id,)]

    except KeyError:  # Se l'elenco non e' piu' in sessione, potrebbe essere scaduto.
        raise ValueError("Elenco non presente in sessione.")

    if elenco.modulo():  # Se l'elenco richiede un modulo

        try:  # Prova a recuperare il modulo riempito
            modulo = elenco.modulo()(request.session["elenco_modulo_%s" % (elenco_id,)])

        except KeyError:  # Se fallisce, il modulo non e' stato ancora compilato
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))

        if not modulo.is_valid():  # Se il modulo non e' valido, qualcosa e' andato storto
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))  # Prova nuovamente?

        elenco.modulo_riempito = modulo  # Imposta il modulo

    FOGLIO_DEFAULT = "Foglio 1"

    fogli_multipli = True
    if 'foglio_singolo' in request.GET:
        fogli_multipli = False

    # Ottiene elenco
    persone = elenco.ordina(elenco.risultati())

    # Crea nuovo excel
    excel = Excel(oggetto=me)

    # Ottiene intestazione e funzioni colonne
    intestazione = [x[0] for x in elenco.excel_colonne()]
    colonne = [x[1] for x in elenco.excel_colonne()]
    if not fogli_multipli:
        intestazione += ["Elenco"]

    fogli = {}

    def __semplifica_nome(nome):
        return nome\
            .replace("/", "")\
            .replace(": ", "-")\
            .replace("Comitato ", "")\
            .replace("Locale ", "")\
            .replace("Provinciale ", "")\
            .replace("Di ", "")\
            .replace("di ", "")\
            .replace("Della ", "")\
            .replace("Dell'", "")\
            .replace("Del ", "")

    for persona in persone:
        foglio = __semplifica_nome(elenco.excel_foglio(persona))[:31] if fogli_multipli else FOGLIO_DEFAULT
        foglio_key = foglio.lower().strip()
        if foglio_key not in [x.lower() for x in fogli.keys()]:
            fogli.update({
                foglio_key: FoglioExcel(foglio, intestazione)
            })

        persona_colonne = [y if y is not None else "" for y in [x(persona) for x in colonne]]
        if not fogli_multipli:
            persona_colonne += [elenco.excel_foglio(persona)]

        fogli[foglio_key].aggiungi_riga(
            *persona_colonne
        )

    excel.fogli = fogli.values()
    excel.genera_e_salva("Elenco.xlsx")

    return redirect(excel.download_url)


@pagina_privata
def us_elenco_messaggio(request, me, elenco_id):

    try:  # Prova a ottenere l'elenco dalla sessione.
        elenco = request.session["elenco_%s" % (elenco_id,)]

    except KeyError:  # Se l'elenco non e' piu' in sessione, potrebbe essere scaduto.
        raise ValueError("Elenco non presente in sessione.")

    if elenco.modulo():  # Se l'elenco richiede un modulo

        try:  # Prova a recuperare il modulo riempito
            modulo = elenco.modulo()(request.session["elenco_modulo_%s" % (elenco_id,)])

        except KeyError:  # Se fallisce, il modulo non e' stato ancora compilato
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))

        if not modulo.is_valid():  # Se il modulo non e' valido, qualcosa e' andato storto
            return redirect("/us/elenco/%s/modulo/" % (elenco_id,))  # Prova nuovamente?

        elenco.modulo_riempito = modulo  # Imposta il modulo

    persone = elenco.ordina(elenco.risultati())
    return imposta_destinatari_e_scrivi_messaggio(request, persone)


@pagina_privata(permessi=(ELENCHI_SOCI,))
def us_elenchi(request, me, elenco_tipo):

    tipi_elenco = {
        "volontari": (ElencoVolontari, "Elenco dei Volontari"),
        "giovani": (ElencoVolontariGiovani, "Elenco dei Volontari Giovani"),
        "ivcm": (ElencoIVCM, "Elenco IV e CM"),
        "dimessi": (ElencoDimessi, "Elenco Dimessi"),
        "riserva": (ElencoInRiserva, "Elenco Volontari in Riserva"),
        "trasferiti": (ElencoTrasferiti, "Elenco Trasferiti"),
        "dipendenti": (ElencoDipendenti, "Elenco dei Dipendenti"),
        "ordinari": (ElencoOrdinari, "Elenco dei Soci Ordinari"),
        "estesi": (ElencoEstesi, "Elenco dei Volontari Estesi/In Estensione"),
        "soci": (ElencoSociAlGiorno, "Elenco dei Soci"),
        "sostenitori": (ElencoSostenitori, "Elenco dei Sostenitori"),
        "elettorato": (ElencoElettoratoAlGiorno, "Elenco Elettorato", "us_elenco_inc_elettorato.html"),
        "titoli": (ElencoPerTitoli, "Ricerca dei soci per titoli"),
    }

    if elenco_tipo not in tipi_elenco:
        return redirect("/us/")

    elenco_nome = tipi_elenco[elenco_tipo][1]
    elenco_template = tipi_elenco[elenco_tipo][2] if len(tipi_elenco[elenco_tipo]) > 2 else None

    if request.POST:  # Ho selezionato delle sedi. Elabora elenco.

        sedi = me.oggetti_permesso(ELENCHI_SOCI).filter(pk__in=request.POST.getlist('sedi'))
        elenco = tipi_elenco[elenco_tipo][0](sedi)

        return 'us_elenco_generico.html', {
            "elenco": elenco,
            "elenco_nome": elenco_nome,
            "elenco_template": elenco_template,
        }

    else:  # Devo selezionare delle Sedi.

        sedi = me.oggetti_permesso(ELENCHI_SOCI)

        return 'us_elenco_sede.html', {
            "sedi": sedi,
            "elenco_nome": elenco_nome,
            "elenco_template": elenco_template,
        }



@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_elenco_soci(request, me):

    elenco = ElencoSociAlGiorno(me.oggetti_permesso(GESTIONE_SOCI))

    contesto = {
        "elenco_nome": "Elenco dei Soci",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_riserva(request, me):
    modulo = ModuloCreazioneRiserva(request.POST or None)

    if modulo.is_valid():
        if not modulo.cleaned_data['persona'].appartenenze_attuali() or not modulo.cleaned_data['persona'].sede_riferimento():
            return errore_generico(titolo="Errore", messaggio="Si è verificato un errore generico.", request=request)
        if not me.permessi_almeno(modulo.cleaned_data['persona'], MODIFICA):
            modulo.add_error('persona', "Non puoi registrare riserve per questo Volontario!")
        else:
            riserva = modulo.save(commit=False)
            riserva.appartenenza = riserva.persona.appartenenze_attuali().first()
            riserva.save()
            riserva.richiedi()
            return messaggio_generico(request, me, titolo="Riserva registrata",
                                      messaggio="La riserva è stato registrata con successo",
                                      torna_titolo="Inserisci nuova riserva",
                                      torna_url="/us/riserva/")

    contesto = {
        "modulo": modulo,
    }

    return "us_riserva.html", contesto

@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_elenco_sostenitori(request, me):

    elenco = ElencoSostenitori(me.oggetti_permesso(GESTIONE_SOCI))

    contesto = {
        "elenco_nome": "Elenco dei Sostenitori",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_elenco_volontari(request, me):

    elenco = ElencoVolontari(me.oggetti_permesso(GESTIONE_SOCI))

    contesto = {
        "elenco_nome": "Elenco dei Volontari Attivi",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_elenco_ordinari(request, me):

    elenco = ElencoOrdinari(me.oggetti_permesso(GESTIONE_SOCI))

    contesto = {
        "elenco_nome": "Elenco dei Soci Ordinari",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_elenco_elettorato(request, me):

    elenco = ElencoElettoratoAlGiorno(me.oggetti_permesso(GESTIONE_SOCI))

    contesto = {
        "elenco_nome": "Elenco Elettorato",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_quote(request, me):

    elenco = ElencoQuote(me.oggetti_permesso(GESTIONE_SOCI))
    contesto = {
        "elenco_nome": "Elenco Quote",
        "elenco": elenco
    }

    return 'us_elenco_generico.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_quote_nuova(request, me):

    sedi = me.oggetti_permesso(GESTIONE_SOCI)

    questo_anno = poco_fa().year

    modulo = None
    appena_registrata = Quota.objects.get(pk=request.GET['appena_registrata']) \
        if 'appena_registrata' in request.GET else None

    if Tesseramento.aperto_anno(questo_anno):
        tesseramento = Tesseramento.objects.get(anno=questo_anno)
        dati_iniziali = {
            "importo": tesseramento.quota_attivo,
            "data_versamento": poco_fa(),
        }
        modulo = ModuloQuotaVolontario(request.POST or None, initial=dati_iniziali)

    if modulo and modulo.is_valid():

        volontario = modulo.cleaned_data['volontario']
        importo = modulo.cleaned_data['importo']
        data_versamento = modulo.cleaned_data['data_versamento']

        if importo < tesseramento.quota_attivo:
            modulo.add_error('importo', 'L\'importo minimo per il %d e\' di EUR %s.' % (
                questo_anno, testo_euro(tesseramento.quota_attivo)
            ))

        elif data_versamento.year != questo_anno or data_versamento > oggi():
            modulo.add_error('data_versamento', 'La data di versamento deve essere nel %d e '
                                                'non può essere nel futuro.' % questo_anno)


        elif tesseramento.pagante(volontario, attivi=True, ordinari=False):
            modulo.add_error('volontario', 'Questo volontario ha già pagato la Quota '
                                           'associativa per l\'anno %d' % questo_anno)


        elif not tesseramento.non_pagante(volontario, attivi=True, ordinari=False):
            modulo.add_error('volontario', 'Questo volontario non è passibile al pagamento '
                                           'della Quota associativa come Volontario presso '
                                           'una delle tue Sedi, per l\'anno %d.' % questo_anno)

        else:

            appartenenza = volontario.appartenenze_attuali(al_giorno=data_versamento, membro=Appartenenza.VOLONTARIO).first()
            comitato = appartenenza.sede.comitato if appartenenza else None

            if appartenenza.sede not in sedi:
                modulo.add_error('volontario', 'Questo Volontario non è appartenente a una Sede di tua competenza.')

            elif not appartenenza:
                modulo.add_error('data_versamento', 'In questa data, il Volontario non risulta appartenente '
                                                    'alla Sede.')

            elif not comitato.locazione:
                return errore_generico(request, me, titolo="Necessario impostare indirizzo del Comitato",
                                       messaggio="Per poter rilasciare ricevute, è necessario impostare un indirizzo "
                                                 "per la Sede del Comitato di %s. Il Presidente può gestire i dati "
                                                 "della Sede dalla sezione 'Sedi'." % comitato.nome_completo)

            elif not comitato.codice_fiscale:
                return errore_generico(request, me, titolo="Necessario impostare codice fiscale del Comitato",
                                       messaggio="Per poter rilasciare ricevute, è necessario impostare un "
                                                 "codice fiscale per la Sede del Comitato di %s. Il Presidente può "
                                                 "gestire i dati della Sede dalla sezione 'Sedi'." % comitato.nome_completo)

            else:
                # OK, paga quota!
                ricevuta = Quota.nuova(
                    appartenenza=appartenenza,
                    data_versamento=data_versamento,
                    registrato_da=me,
                    importo=importo,
                    causale="Rinnovo Quota Associativa %d" % (questo_anno,),
                    tipo=Quota.QUOTA_SOCIO,
                    invia_notifica=True
                )
                return redirect("/us/quote/nuova/?appena_registrata=%d" % (ricevuta.pk,))

    ultime_quote = Quota.objects.filter(registrato_da=me, tipo=Quota.QUOTA_SOCIO).order_by('-creazione')[:15]

    contesto = {
        "modulo": modulo,
        "ultime_quote": ultime_quote,
        "anno": questo_anno,
        "appena_registrata": appena_registrata,
    }
    return 'us_quote_nuova.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_ricevute_nuova(request, me):

    sedi = me.oggetti_permesso(GESTIONE_SOCI)

    questo_anno = poco_fa().year

    appena_registrata = Quota.objects.get(pk=request.GET['appena_registrata']) \
        if 'appena_registrata' in request.GET else None

    modulo = ModuloNuovaRicevuta(request.POST or None)

    if modulo.is_valid():

        persona = modulo.cleaned_data['persona']
        tipo_ricevuta = modulo.cleaned_data['tipo_ricevuta']
        causale = modulo.cleaned_data['causale']
        importo = modulo.cleaned_data['importo']
        data_versamento = modulo.cleaned_data['data_versamento']

        appartenenza = persona.appartenenze_attuali(al_giorno=data_versamento,
                                                    sede__in=sedi).first()

        partecipazione_corso = persona.partecipazione_corso_base()

        comitato = appartenenza.sede.comitato if appartenenza else partecipazione_corso.corso.sede.comitato

        if not comitato:
            modulo.add_error('data_versamento', 'In questa data, la persona non risulta appartenente '
                                                'come Volontario o Sostenitore per alla Sede o '
                                                'partecipante confermato ad un corso base attivo.')

        elif tipo_ricevuta == Quota.QUOTA_SOSTENITORE and (not appartenenza or appartenenza.membro != Appartenenza.SOSTENITORE):
            modulo.add_error('persona', 'Questa persona non è registrata come Sostenitore CRI '
                                        'della Sede. Non è quindi possibile registrare la Ricevuta '
                                        'come Sostenitore CRI.')

        elif not comitato.locazione:
            return errore_generico(request, me, titolo="Necessario impostare indirizzo del Comitato",
                                   messaggio="Per poter rilasciare ricevute, è necessario impostare un indirizzo "
                                             "per la Sede del Comitato di %s. Il Presidente può gestire i dati "
                                             "della Sede dalla sezione 'Sedi'." % comitato.nome_completo)

        elif not comitato.codice_fiscale:
            return errore_generico(request, me, titolo="Necessario impostare codice fiscale del Comitato",
                                   messaggio="Per poter rilasciare ricevute, è necessario impostare un "
                                             "codice fiscale per la Sede del Comitato di %s. Il Presidente può "
                                             "gestire i dati della Sede dalla sezione 'Sedi'." % comitato.nome_completo)

        else:
            # OK, paga quota!
            ricevuta = Quota.nuova(
                appartenenza=appartenenza,
                corso_comitato=comitato,
                corso_persona=persona,
                data_versamento=data_versamento,
                registrato_da=me,
                importo=importo,
                causale=causale,
                tipo=tipo_ricevuta,
                invia_notifica=True
            )
            return redirect("/us/ricevute/nuova/?appena_registrata=%d" % (ricevuta.pk,))

    ultime_quote = Quota.objects.filter(
        registrato_da=me, tipo__in=[Quota.RICEVUTA, Quota.QUOTA_SOSTENITORE]
    ).order_by('-creazione')[:15]

    contesto = {
        "modulo": modulo,
        "ultime_quote": ultime_quote,
        "anno": questo_anno,
        "appena_registrata": appena_registrata,
    }
    return 'us_ricevute_nuova.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_ricevute(request, me):

    modulo = ModuloElencoRicevute(request.POST or (request.GET or None))

    tipi = [x[0] for x in Quota.TIPO]
    anno = Tesseramento.ultimo_anno()
    if modulo.is_valid():
        tipi = modulo.cleaned_data.get('tipi_ricevute')
        anno = modulo.cleaned_data.get('anno')

    dict_tipi = dict(Quota.TIPO)
    tipi_testo = [dict_tipi[t] for t in tipi]

    sedi = me.oggetti_permesso(GESTIONE_SOCI)
    ricevute = Quota.objects.filter(
        Q(Q(sede__in=sedi) | Q(appartenenza__sede__in=sedi)),
        anno=anno,
        tipo__in=tipi,
    ).order_by('progressivo')

    non_annullate = ricevute.filter(stato=Quota.REGISTRATA)
    importo = non_annullate.aggregate(Sum('importo'))['importo__sum'] or 0.0
    importo_extra = non_annullate.aggregate(Sum('importo_extra'))['importo_extra__sum'] or 0.0
    importo_totale = importo + importo_extra

    contesto = {
        "modulo": modulo,
        "anno": anno,
        "ricevute": ricevute,
        "tipi_testo": tipi_testo,
        "importo_totale": importo_totale,
    }

    return 'us_ricevute.html', contesto


@pagina_privata(permessi=(GESTIONE_SOCI,))
def us_ricevute_annulla(request, me, pk):
    ricevuta = get_object_or_404(Quota, pk=pk)

    if ricevuta.sede not in me.oggetti_permesso(GESTIONE_SOCI):
        return redirect(ERRORE_PERMESSI)

    if ricevuta.stato == ricevuta.REGISTRATA:
        ricevuta.annulla(annullato_da=me, invia_notifica=True)

    return redirect("/us/ricevute/?anno=%d&tipi_ricevute=%s" % (ricevuta.anno, ricevuta.tipo,))


@pagina_pubblica
def verifica_tesserino(request, me=None):

    modulo = ModuloVerificaTesserino(request.POST or None)
    ricerca = False
    lettera_numero = 0
    lettera = "?"
    tesserino = None
    if modulo.is_valid():
        ricerca = True
        try:
            tesserino = Tesserino.objects.get(codice=modulo.cleaned_data['numero_tessera'])
            cognome = tesserino.persona.cognome
            lettera_numero = random.randint(0, len(cognome))
            lettera = cognome[lettera_numero].upper()
            lettera_numero += 1

        except Tesserino.DoesNotExist:
            tesserino = None

    contesto = {
        "modulo": modulo,
        "tesserino": tesserino,
        "lettera_numero": lettera_numero,
        "lettera": lettera,
        "ricerca": ricerca,
    }
    return 'informazioni_verifica_tesserino.html', contesto


@pagina_privata
def us_tesserini(request, me):
    return redirect("/us/tesserini/da-richiedere/")


@pagina_privata
def us_tesserini_da_richiedere(request, me):
    """
    Mostra l'elenco dei volontari che hanno i requisiti per la
     richiesta del tesserino ma non hanno una richiesta di tesserino,
     con link per effettuare la richiesta.
    """
    sedi = me.oggetti_permesso(GESTIONE_SOCI)
    elenco = ElencoTesseriniDaRichiedere(sedi)
    contesto = {
        "elenco": elenco
    }
    return "us_tesserini_da_richiedere.html", contesto


@pagina_privata
def us_tesserini_senza_fototessera(request, me):
    """
    Mostra l'elenco dei volontari che non hanno ancora
     una fototessera caricata.
    """
    sedi = me.oggetti_permesso(GESTIONE_SOCI)
    elenco = ElencoTesseriniSenzaFototessera(sedi)
    contesto = {
        "elenco": elenco
    }
    return "us_tesserini_senza_fototessera.html", contesto


@pagina_privata
def us_tesserini_richiesti(request, me):
    """
    Mostra un elenco di tutti i volontari con un tesserino richiesto,
     con un link a maggiori informazioni.
    """
    sedi = me.oggetti_permesso(GESTIONE_SOCI)
    elenco = ElencoTesseriniRichiesti(sedi)
    contesto = {
        "elenco": elenco
    }
    return "us_tesserini_richiesti.html", contesto


@pagina_privata
def us_tesserini_richiedi(request, me, persona_pk=None):
    """
    Effettua la richiesta di tesserino per il volontario.
    """
    persona = get_object_or_404(Persona, pk=persona_pk)

    if not me.permessi_almeno(persona, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    torna = {
        "torna_url": request.GET.get("next", default="/us/tesserini/"),
        "torna_titolo": "Torna indietro",
    }

    sede = persona.sede_riferimento(membro=Appartenenza.MEMBRO_TESSERINO)
    if not sede:
        return errore_generico(request, me, titolo="La persona non è un volontario",
                               messaggio="È solo possibile richiedere un tesserino per "
                                         "i volontari.", **torna)

    if sede not in me.oggetti_permesso(GESTIONE_SOCI):
        return redirect(ERRORE_PERMESSI)

    if not persona.fototessera_attuale():
        return errore_generico(request, me, titolo="Nessuna fototessera",
                               messaggio="È solo possibile richiedere un tesserino per "
                                         "i volontari in possesso di una fototessera "
                                         "confermata su Gaia.", **torna)

    if persona.tesserini.filter(stato_richiesta__in=(Tesserino.RICHIESTO, Tesserino.ACCETTATO)).exists():
        return errore_generico(request, me, titolo="Tesserino già richiesto",
                               messaggio="Una richiesta è già stata inoltrata per "
                                         "il volontario selezionato.", **torna)

    comitato = sede.comitato
    if not comitato.locazione:
        return errore_generico(request, me, titolo="Il Comitato non ha un indirizzo",
                               messaggio="La sede di appartenenza del volontario (%s) non ha "
                                         "un indirizzo impostato. Questo è necessario, in quanto "
                                         "viene stampato sul retro del tesserino. Il Presidente "
                                         "può impostare l'indirizzo della Sede dalla sezione "
                                         "'Sedi'." % (comitato,),
                               **torna)

    regionale = comitato.superiore(estensione=REGIONALE)
    if not regionale:
        raise ValueError("%s non ha un comitato regionale." % (comitato,))

    # Crea la richiesta di tesserino
    tesserino = Tesserino(
        persona=persona,
        emesso_da=regionale,
        tipo_richiesta=Tesserino.RILASCIO,
        stato_richiesta=Tesserino.RICHIESTO,
        richiesto_da=me
    )
    tesserino.save()

    # Manda l'email al volontario
    Messaggio.costruisci_e_invia(
        oggetto="Richiesta Tesserino inoltrata",
        modello="posta_richiesta_tesserino.html",
        corpo={
            "persona": persona,
            "tesserino": tesserino,
        },
        mittente=me,
        destinatari=[persona]
    )

    # Mostra un messaggio
    return messaggio_generico(request, me, titolo="Richiesta inoltrata",
                              messaggio="La richiesta di stampa è stata inoltrata correttamente alla Sede di "
                                        "emissione (%s) per il Volontario %s." % (
                                  tesserino.emesso_da, persona.nome_completo,
                              ), **torna)


@pagina_privata
def us_tesserini_emissione(request, me):
    sedi = me.oggetti_permesso(EMISSIONE_TESSERINI)

    tesserini = Tesserino.objects.none()

    modulo = ModuloFiltraEmissioneTesserini(request.POST or None)
    modulo_compilato = True if request.POST else False

    if modulo.is_valid():
        stato_emissione = modulo.cleaned_data['stato_emissione']
        stato_emissione_q = Q(stato_emissione__in=stato_emissione)
        if '' in stato_emissione:
            stato_emissione_q |= Q(stato_emissione__isnull=True)

        tesserini = Tesserino.objects.filter(
            Q(
                Q(persona__codice_fiscale__icontains=modulo.cleaned_data['cerca']) |
                Q(codice__icontains=modulo.cleaned_data['cerca'])
            ),
            stato_emissione_q,
            emesso_da__in=sedi,
            tipo_richiesta__in=modulo.cleaned_data['tipo_richiesta'],
            stato_richiesta__in=modulo.cleaned_data['stato_richiesta']
        ).order_by(modulo.cleaned_data['ordine'])

    contesto = {
        "tesserini": tesserini,
        "modulo": modulo,
        "modulo_compilato": modulo_compilato
    }
    return "us_tesserini_emissione.html", contesto


@pagina_privata
def us_tesserini_emissione_processa(request, me):

    sedi = me.oggetti_permesso(EMISSIONE_TESSERINI)

    if not request.POST:  # Qui si arriva tramite POST.
        return redirect("/us/tesserini/emissione/")

    if 'tesserini' in request.POST:
        tesserini_pk = [int(x) for x in request.POST.getlist('tesserini')]
        azione = request.POST.get('azione', default='')
        request.session['tesserini'] = tesserini_pk
        request.session['tesserini_azione'] = azione

    else:
        tesserini_pk = request.session.get('tesserini', default=[])
        azione = request.session.get('tesserini_azione', default="scarica")

    assert azione in ['scarica', 'lavora', 'scarica_e_lavora']

    # Ottengo tutti i tesserini
    tesserini = Tesserino.objects.filter(
        pk__in=tesserini_pk, emesso_da__in=sedi
    ).prefetch_related('persona')

    fine = False

    da_lavorare = azione in ['lavora', 'scarica_e_lavora']
    da_scaricare = azione in ['scarica', 'scarica_e_lavora']

    modulo = None

    if not tesserini.exists():
        return errore_generico(request, me, titolo="Nessuna richiesta selezionata",
                               messaggio="Devi selezionare una o più richieste che intendi "
                                         "processare. ",
                               torna_titolo="Indietro", torna_url="/us/tesserini/emissione/")

    if da_lavorare:
        modulo = ModuloLavoraTesserini(request.POST if 'tesserini' not in request.POST else None)
        if modulo.is_valid():

            stato_richiesta = modulo.cleaned_data['stato_richiesta']
            stato_emissione = modulo.cleaned_data['stato_emissione']
            motivo_rifiutato = modulo.cleaned_data['motivo_rifiutato']

            tesserini.update(stato_richiesta=stato_richiesta,
                             stato_emissione=stato_emissione,
                             motivo_rifiutato=motivo_rifiutato,
                             data_conferma=poco_fa())

            # Attiva i tesserini o disattiva come appropriato
            valido = (stato_emissione and stato_richiesta == Tesserino.ACCETTATO)

            # Assicurati che i tesserini abbiano un codice prima di attivarli
            if stato_richiesta == Tesserino.ACCETTATO:
                tesserini_senza_codice = tesserini.filter(Tesserino.query_senza_codice().q)
                for x in tesserini_senza_codice:
                    x.assicura_presenza_codice()

            tesserini.update(valido=valido)

            fine = True

    else:
        modulo = ModuloScaricaTesserini(request.POST if 'tesserini' not in request.POST else None)
        if modulo.is_valid():
            fine = True

    if fine:  # Quando elaborati i tesserini
        if da_scaricare:
            return redirect("/us/tesserini/emissione/scarica/")

        else:
            return messaggio_generico(request, me, titolo="%d tesserini processati" % tesserini.count(),
                                      messaggio="I tesserini sono stati processati con successo.",
                                      torna_titolo="Indietro",
                                      torna_url="/us/tesserini/emissione/")

    contesto = {
        "tesserini": tesserini,
        "modulo": modulo,
        "da_scaricare": da_scaricare,
        "da_lavorare": da_lavorare,
    }
    return "us_tesserini_emissione_processa.html", contesto


@pagina_privata
def us_tesserini_emissione_scarica(request, me):
    sedi = me.oggetti_permesso(EMISSIONE_TESSERINI)
    tesserini_pk = request.session.get('tesserini', default=[])
    tesserini = Tesserino.objects.filter(
        pk__in=tesserini_pk, emesso_da__in=sedi
    ).prefetch_related('persona')

    if not tesserini.exists():
        return redirect("/us/tesserini/emissione/")

    tesserini_link = []
    for tesserino in tesserini:
        tesserini_link += [tesserino.url_pdf_token(me)]

    contesto = {
        "tesserini": tesserini,
        "tesserini_secondi": 3,
        "tesserini_link_json": json.dumps(tesserini_link),
        "tesserini_link": tesserini_link,
    }

    return "us_tesserini_emissione_scarica.html", contesto