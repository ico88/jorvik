from datetime import datetime, timedelta

from django.shortcuts import redirect, get_object_or_404
from django.template import Context
from django.template.loader import get_template

from anagrafica.models import Persona
from anagrafica.permessi.applicazioni import DIRETTORE_CORSO
from anagrafica.permessi.costanti import GESTIONE_CORSI_SEDE, GESTIONE_CORSO, ERRORE_PERMESSI, COMPLETO, MODIFICA
from autenticazione.funzioni import pagina_privata, pagina_pubblica
from base.errori import ci_siamo_quasi, errore_generico, messaggio_generico
from formazione.elenchi import ElencoPartecipantiCorsiBase
from formazione.forms import ModuloCreazioneCorsoBase, ModuloModificaLezione, ModuloModificaCorsoBase
from formazione.models import CorsoBase, AssenzaCorsoBase, LezioneCorsoBase, PartecipazioneCorsoBase
from django.utils import timezone

@pagina_privata
def formazione(request, me):
    contesto = {
        "sedi": me.oggetti_permesso(GESTIONE_CORSI_SEDE),
        "corsi": me.oggetti_permesso(GESTIONE_CORSO),
    }
    return 'formazione.html', contesto


@pagina_privata
def formazione_corsi_base_elenco(request, me):
    contesto = {
        "corsi": me.oggetti_permesso(GESTIONE_CORSO),
        "puo_pianificare": me.ha_permesso(GESTIONE_CORSI_SEDE),
    }
    return 'formazione_corsi_base_elenco.html', contesto


@pagina_privata
def formazione_corsi_base_domanda(request, me):
    contesto = {
        "sedi": me.oggetti_permesso(GESTIONE_CORSI_SEDE),
    }
    return 'formazione_corsi_base_domanda.html', contesto


@pagina_privata
def formazione_corsi_base_nuovo(request, me):
    modulo = ModuloCreazioneCorsoBase(request.POST or None, initial={"data_inizio":
                                                                     datetime.now() + timedelta(days=14)})
    modulo.fields['sede'].queryset = me.oggetti_permesso(GESTIONE_CORSI_SEDE)

    if modulo.is_valid():
        corso = CorsoBase.nuovo(
            anno=modulo.cleaned_data['data_inizio'].year,
            sede=modulo.cleaned_data['sede'],
            data_inizio=modulo.cleaned_data['data_inizio'],
            data_esame=modulo.cleaned_data['data_inizio'],
        )

        if modulo.cleaned_data['locazione'] == modulo.PRESSO_SEDE:
            corso.locazione = corso.sede.locazione
            corso.save()

        request.session['corso_base_creato'] = corso.pk

        return redirect(corso.url_direttori)

    contesto = {
        "modulo": modulo
    }
    return 'formazione_corsi_base_nuovo.html', contesto


@pagina_privata
def formazione_corsi_base_direttori(request, me, pk):
    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, COMPLETO):
        return redirect(ERRORE_PERMESSI)

    continua_url = corso.url

    if 'corso_base_creato' in request.session and int(request.session['corso_base_creato']) == int(pk):
        continua_url = "/formazione/corsi-base/%d/fine/" % (int(pk),)
        del request.session['corso_base_creato']

    contesto = {
        "delega": DIRETTORE_CORSO,
        "corso": corso,
        "continua_url": continua_url
    }

    return 'formazione_corsi_base_direttori.html', contesto


@pagina_privata
def formazione_corsi_base_fine(request, me, pk):
    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, COMPLETO):
        return redirect(ERRORE_PERMESSI)

    if me in corso.delegati_attuali():  # Se sono direttore, continuo.
        redirect(corso.url)

    contesto = {
        "corso": corso,
    }
    return 'formazione_corsi_base_fine.html', contesto


@pagina_pubblica
def aspirante_corso_base_informazioni(request, me=None, pk=None):

    corso = get_object_or_404(CorsoBase, pk=pk)
    puo_modificare = me and me.permessi_almeno(corso, MODIFICA)
    puoi_partecipare = corso.persona(me) if me else None

    contesto = {
        "corso": corso,
        "puo_modificare": puo_modificare,
        "puoi_partecipare": puoi_partecipare,
    }
    return 'aspirante_corso_base_scheda_informazioni.html', contesto


@pagina_privata
def aspirante_corso_base_iscriviti(request, me=None, pk=None):

    corso = get_object_or_404(CorsoBase, pk=pk)
    puoi_partecipare = corso.persona(me)
    if not puoi_partecipare in corso.PUOI_ISCRIVERTI:
        return errore_generico(request, me, titolo="Non puoi partecipare a questo corso",
                               messaggio="Siamo spiacenti, ma non sembra che tu possa partecipare "
                                         "a questo corso per qualche motivo. ",
                               torna_titolo="Torna al corso",
                               torna_url=corso.url)

    p = PartecipazioneCorsoBase(persona=me, corso=corso)
    p.save()
    p.richiedi()
    return messaggio_generico(request, me, titolo="Sei iscritto al corso base",
                              messaggio="Complimenti! Abbiamo inoltrato la tua richiesta al direttore "
                                        "del corso, che ti contatterà appena possibile.",
                              torna_titolo="Torna al corso",
                              torna_url=corso.url)


@pagina_privata
def aspirante_corso_base_ritirati(request, me=None, pk=None):

    corso = get_object_or_404(CorsoBase, pk=pk)
    puoi_partecipare = corso.persona(me)
    if not puoi_partecipare == corso.SEI_ISCRITTO_PUOI_RITIRARTI:
        return errore_generico(request, me, titolo="Non puoi ritirarti da questo corso",
                               messaggio="Siamo spiacenti, ma non sembra che tu possa ritirarti "
                                         "da questo corso per qualche motivo. ",
                               torna_titolo="Torna al corso",
                               torna_url=corso.url)

    p = PartecipazioneCorsoBase.con_esito_pending(corso=corso, persona=me).first()
    p.ritira()

    return messaggio_generico(request, me, titolo="Ti sei ritirato dal corso",
                              messaggio="Siamo spiacenti che hai deciso di ritirarti da questo corso. "
                                        "La tua partecipazione è stata ritirata correttamente. "
                                        "Non esitare a iscriverti a questo o un altro corso, nel caso cambiassi idea.",
                              torna_titolo="Torna alla pagina del corso",
                              torna_url=corso.url)


@pagina_privata
def aspirante_corso_base_mappa(request, me, pk):

    corso = get_object_or_404(CorsoBase, pk=pk)
    puo_modificare = me.permessi_almeno(corso, MODIFICA)
    contesto = {
        "corso": corso,
        "puo_modificare": puo_modificare
    }
    return 'aspirante_corso_base_scheda_mappa.html', contesto


@pagina_privata
def aspirante_corso_base_lezioni(request, me, pk):

    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    partecipanti = Persona.objects.filter(partecipazioni_corsi__in=corso.partecipazioni_confermate())
    lezioni = corso.lezioni.all()
    moduli = []
    partecipanti_lezioni = []
    for lezione in lezioni:
        modulo = ModuloModificaLezione(request.POST if request.POST and request.POST['azione'] == 'salva' else None,
                                         instance=lezione,
                                         prefix="%s" % (lezione.pk,))
        if request.POST and request.POST['azione'] == 'salva' and modulo.is_valid():
            modulo.save()

        moduli += [modulo]
        partecipanti_lezione = partecipanti.exclude(assenze_corsi_base__lezione=lezione).order_by('nome', 'cognome')

        if request.POST and request.POST['azione'] == 'salva':
            for partecipante in partecipanti:
                if ("%s" % (partecipante.pk,)) in request.POST.getlist('presenze-%s' % (lezione.pk,)):
                    # Se presente, rimuovi ogni assenza.
                    print("Presente %s" % (partecipante,))
                    AssenzaCorsoBase.objects.filter(lezione=lezione, persona=partecipante).delete()
                else:
                    # Assicurati che sia segnato come assente.
                    if not AssenzaCorsoBase.objects.filter(lezione=lezione, persona=partecipante).exists():
                        a = AssenzaCorsoBase(lezione=lezione, persona=partecipante, registrata_da=me)
                        a.save()

        partecipanti_lezioni += [partecipanti_lezione]

    if request.POST and request.POST['azione'] == 'nuova':
        modulo_nuova_lezione = ModuloModificaLezione(request.POST, prefix="nuova")
        if modulo_nuova_lezione.is_valid():
            lezione = modulo_nuova_lezione.save(commit=False)
            lezione.corso = corso
            lezione.save()
            return redirect("%s#%d" % (corso.url_lezioni, lezione.pk,))
    else:
        modulo_nuova_lezione = ModuloModificaLezione(prefix="nuova", initial={
            "inizio": timezone.now(),
            "fine": timezone.now() + timedelta(hours=2)
        })


    lezioni = zip(lezioni, moduli, partecipanti_lezioni)

    contesto = {
        "corso": corso,
        "puo_modificare": True,
        "lezioni": lezioni,
        "partecipanti": partecipanti,
        "modulo_nuova_lezione": modulo_nuova_lezione,
    }
    return 'aspirante_corso_base_scheda_lezioni.html', contesto


@pagina_privata
def aspirante_corso_base_lezioni_cancella(request, me, pk, lezione_pk):

    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    lezione = get_object_or_404(LezioneCorsoBase, pk=lezione_pk)
    if lezione.corso != corso:
        return redirect(ERRORE_PERMESSI)

    lezione.delete()
    return redirect(corso.url_lezioni)

@pagina_privata
def aspirante_corso_base_modifica(request, me, pk):

    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    modulo = ModuloModificaCorsoBase(request.POST or None, instance=corso)
    if modulo.is_valid():
        modulo.save()

    contesto = {
        "corso": corso,
        "puo_modificare": True,
        "modulo": modulo,
    }
    return 'aspirante_corso_base_scheda_modifica.html', contesto


@pagina_privata
def aspirante_corso_base_attiva(request, me, pk):
    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)
    if corso.stato != corso.PREPARAZIONE:
        return messaggio_generico(request, me, titolo="Il corso è già attivo",
                                  messaggio="Non puoi attivare un corso già attivo",
                                  torna_titolo="Torna al Corso",
                                  torna_url=corso.url)
    if not corso.attivabile():
        return errore_generico(request, me, titolo="Impossibile attivare questo corso",
                               messaggio="Non sono soddisfatti tutti i criteri di attivazione. "
                                         "Torna alla pagina del corso e verifica che tutti i "
                                         "criteri siano stati soddisfatti prima di attivare un "
                                         "nuovo corso.",
                               torna_titolo="Torna al Corso",
                               torna_url=corso.url)

    corpo = {"corso": corso, "persona": me}
    testo = get_template("email_aspirante_corso_inc_testo.html").render(Context(corpo))

    if request.POST:
        corso.attiva()
        return messaggio_generico(request, me, titolo="Corso attivato con successo",
                                  messaggio="A breve tutti gli aspiranti nelle vicinanze verranno informati "
                                            "dell'attivazione di questo corso base.",
                                  torna_titolo="Torna al Corso",
                                  torna_url=corso.url)

    contesto = {
        "corso": corso,
        "puo_modificare": True,
        "testo": testo,
    }
    return 'aspirante_corso_base_scheda_attiva.html', contesto


@pagina_privata
def aspirante_corso_base_iscritti(request, me, pk):

    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    elenco = ElencoPartecipantiCorsiBase(corso.queryset_modello())
    in_attesa = corso.partecipazioni_in_attesa()
    contesto = {
        "corso": corso,
        "puo_modificare": True,
        "elenco": elenco,
        "in_attesa": in_attesa,
    }
    return 'aspirante_corso_base_scheda_iscritti.html', contesto


@pagina_privata
def aspirante_corso_base_report(request, me, pk):
    corso = get_object_or_404(CorsoBase, pk=pk)
    if not me.permessi_almeno(corso, MODIFICA):
        return redirect(ERRORE_PERMESSI)

    return ci_siamo_quasi(request, me)


@pagina_privata
def aspirante_home(request, me):
    if not hasattr(me, 'aspirante'):
        redirect(ERRORE_PERMESSI)

    contesto = {}
    return 'aspirante_home.html', contesto


@pagina_privata
def aspirante_corsi_base(request, me):
    if not hasattr(me, 'aspirante'):
        redirect(ERRORE_PERMESSI)

    contesto = {
        "corsi": me.aspirante.corsi(),
    }
    return 'aspirante_corsi_base.html', contesto


@pagina_privata
def aspirante_sedi(request, me):
    if not hasattr(me, 'aspirante'):
        redirect(ERRORE_PERMESSI)

    contesto = {
        "sedi": me.aspirante.sedi(),
    }
    return 'aspirante_sedi.html', contesto


@pagina_privata
def aspirante_impostazioni(request, me):
    if not hasattr(me, 'aspirante'):
        redirect(ERRORE_PERMESSI)

    contesto = {}
    return 'aspirante_impostazioni.html', contesto

