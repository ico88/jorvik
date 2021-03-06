import os
from django.contrib.contenttypes.fields import GenericRelation, GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.core import urlresolvers
from django.core.exceptions import ObjectDoesNotExist
from django.db import models
from django.db.models import Q
from django.forms import forms
from mptt.models import MPTTModel, TreeForeignKey
from anagrafica.permessi.applicazioni import PERMESSI_NOMI
from anagrafica.permessi.costanti import MODIFICA
from anagrafica.permessi.incarichi import INCARICHI, INCARICHI_TIPO_DICT
from anagrafica.validators import crea_validatore_dimensione_file, valida_dimensione_file_10mb
from base.forms import ModuloMotivoNegazione
from base.notifiche import NOTIFICA_NON_INVIARE, NOTIFICA_INVIA
from base.stringhe import GeneratoreNomeFile, genera_uuid_casuale
from base.tratti import ConMarcaTemporale
from datetime import datetime, timezone, timedelta

from base.utils import concept, iterabile


class ModelloSemplice(models.Model):
    """
    Questa classe astratta rappresenta un Modello generico.
    """

    class Meta:
        abstract = True

    def url_admin(self):
        content_type = ContentType.objects.get_for_model(self.__class__)
        return urlresolvers.reverse("admin:%s_%s_change" % (content_type.app_label, content_type.model), args=(self.id,))

    def queryset_modello(self):
        """
        Ritorna un queryset contenente solo il modello specificato.
        :return: QuerySet<{Mio tipo}>
        """
        return self.__class__.objects.filter(pk=self.pk)

    @classmethod
    def stringa_modello(cls):
        """
        Ritorna stringa del tipo "app_label.ModelName"
        :return:
        """
        return "%s.%s" % (
            cls._meta.app_label,
            cls._meta.object_name
        )


class ModelloAlbero(MPTTModel, ModelloSemplice):
    """
    Rappresenta un modello parte di un albero gerarchico.
    Nota bene: Per motivi tecnici, questo aggiunge anche un NOME.
    """

    class Meta:
        abstract = True

    class MPTTMeta:
        order_insertion_by = ['nome']
        parent_attr = 'genitore'

    nome = models.CharField(max_length=64, unique=False, db_index=True)
    genitore = TreeForeignKey('self', null=True, blank=True, related_name='figli')

    def ottieni_superiori(self, includimi=False):
        return self.get_ancestors(include_self=includimi)

    def ottieni_figli(self):
        return self.get_children()

    def ottieni_discendenti(self, includimi=False):
        return self.get_descendants(include_self=includimi)

    def ottieni_fratelli(self, includimi=False):
        return self.get_siblings(include_self=includimi)

    def ottieni_numero_figli(self, includimi=False):
        n = self.get_descendant_count()
        if includimi:
            n += 1
        return n

    def figlio_di(self, altro, includimi=True):
        return self.is_descendant_of(altro, include_self=includimi)


class Autorizzazione(ModelloSemplice, ConMarcaTemporale):
    """
    Rappresenta una richiesta di autorizzazione relativa ad un oggetto generico.
    Utilizzare tramite il tratto ConAutorizzazioni ed i suoi metodi.
    """

    class Meta:
        verbose_name_plural = "Autorizzazioni"
        app_label = "base"
        index_together = [
            ['necessaria', 'progressivo'],
            ['necessaria', 'concessa'],
            ['destinatario_ruolo', 'destinatario_oggetto_tipo',],
            ['necessaria', 'destinatario_ruolo', 'destinatario_oggetto_tipo', 'destinatario_oggetto_id'],
            ['destinatario_ruolo', 'destinatario_oggetto_tipo', 'destinatario_oggetto_id'],
            ['destinatario_oggetto_tipo', 'destinatario_oggetto_id'],
            ['necessaria', 'destinatario_oggetto_tipo', 'destinatario_oggetto_id'],
            ['necessaria', 'destinatario_ruolo', 'destinatario_oggetto_tipo', 'destinatario_oggetto_id'],
        ]

    richiedente = models.ForeignKey("anagrafica.Persona", db_index=True, related_name="autorizzazioni_richieste", on_delete=models.CASCADE)
    firmatario = models.ForeignKey("anagrafica.Persona", db_index=True, blank=True, null=True, default=None,
                                   related_name="autorizzazioni_firmate", on_delete=models.SET_NULL)
    concessa = models.NullBooleanField("Esito", db_index=True, blank=True, null=True, default=None)
    motivo_negazione = models.CharField(blank=True, null=True, max_length=512)

    oggetto_tipo = models.ForeignKey(ContentType, db_index=True, related_name="autcomeoggetto", on_delete=models.SET_NULL, null=True)
    oggetto_id = models.PositiveIntegerField(db_index=True)
    oggetto = GenericForeignKey('oggetto_tipo', 'oggetto_id')

    necessaria = models.BooleanField("Necessaria", db_index=True, default=True)
    progressivo = models.PositiveSmallIntegerField("Progressivo contesto", default=1)

    destinatario_ruolo = models.CharField(max_length=16, choices=INCARICHI, db_index=True)
    destinatario_oggetto_tipo = models.ForeignKey(ContentType, db_index=True, related_name="autcomedestinatari", null=True, on_delete=models.SET_NULL)
    destinatario_oggetto_id = models.PositiveIntegerField(db_index=True)
    destinatario_oggetto = GenericForeignKey('destinatario_oggetto_tipo', 'destinatario_oggetto_id')

    def firma(self, firmatario, concedi=True, modulo=None, motivo=None):
        """
        Firma l'autorizzazione.
        :param firmatario: Il firmatario.
        :param concedi: L'esito, vero per concedere, falso per negare.
        :param modulo: Se modulo necessario, un modulo valido.
        :return:
        """
        # Controlla che il modulo fornito, se presente, sia valido
        if modulo and not modulo.is_valid():
            raise ValueError("Il modulo richiesto per l'accettazione non e' stato completato correttamente.")

        self.concessa = concedi
        self.firmatario = firmatario
        self.necessaria = False
        self.save()

        # Se ha negato, allora avvisa subito della negazione.
        # Nessuna altra firma e' piu' necessaria.
        if not concedi:
            self.oggetto.confermata = False
            self.oggetto.save()
            self.oggetto.autorizzazione_negata(modulo=modulo)
            if 'motivo' in modulo.cleaned_data:
                self.motivo_negazione = modulo.cleaned_data['motivo']
                self.save()
            self.oggetto.autorizzazioni_set().update(necessaria=False)
            if self.oggetto.INVIA_NOTIFICA_NEGATA:
                self.notifica_negata()
            return

        # Questa concessa, di questo progressivo non e' piu' necessaria
        # alcuna auutorizzazione.
        self.oggetto.autorizzazioni_set().filter(progressivo=self.progressivo).update(necessaria=False)

        # Se questa autorizzazione e' concessa, ed e' l'ultima.
        if self.oggetto.autorizzazioni_set().filter(necessaria=True).count() == 0:
            self.oggetto.confermata = True
            self.oggetto.save()
            self.oggetto.autorizzazione_concessa(modulo=modulo)
            if self.oggetto.INVIA_NOTIFICA_CONCESSA:
                self.notifica_concessa()

    def concedi(self, firmatario, modulo=None):
        self.firma(firmatario, True, modulo=modulo)

    def nega(self, firmatario, modulo=None):
        self.firma(firmatario, False, modulo=modulo)

    @property
    def template_path(self):
        """
        Ritorna il nome del template dell'autorizzazione.
        """
        return 'base_autorizzazioni_inc_%s_%s.html' % (
            self.oggetto._meta.app_label.lower(),
            self.oggetto._meta.object_name.lower()
        )

    def notifica_richiesta(self, persona):
        from anagrafica.models import Delega, Persona
        from posta.models import Messaggio

        if not persona:
            return  # Nessun destinatario, nessuna e-mail.

        Messaggio.costruisci_e_invia(
            oggetto="Richiesta di %s da %s" % (self.oggetto.RICHIESTA_NOME, self.richiedente.nome_completo,),
            modello="email_autorizzazione_richiesta.html",
            corpo={
                "richiesta": self,
            },
            mittente=self.richiedente,
            destinatari=[persona],
        )

    def notifica_concessa(self):
        from posta.models import Messaggio
        Messaggio.costruisci_e_invia(
            oggetto="Richiesta di %s APPROVATA" % (self.oggetto.RICHIESTA_NOME,),
            modello="email_autorizzazione_concessa.html",
            corpo={
                "richiesta": self,
            },
            mittente=self.firmatario,
            destinatari=[self.richiedente]
        )

    def notifica_negata(self):
        from posta.models import Messaggio
        Messaggio.costruisci_e_invia(
            oggetto="Richiesta di %s RESPINTA" % (self.oggetto.RICHIESTA_NOME,),
            modello="email_autorizzazione_negata.html",
            corpo={
                "richiesta": self,
            },
            mittente=self.firmatario,
            destinatari=[self.richiedente]
        )


class Log(ModelloSemplice, ConMarcaTemporale):

    MODIFICA = 'M'
    CREAZIONE = 'C'
    ELIMINAZIONE = 'E'
    AZIONE = (
        ('M', 'Modifica'),
        ('C', 'Creazione'),
        ('E', 'Eliminazione'),
    )

    persona = models.ForeignKey('anagrafica.Persona', related_name='azioni_recenti', on_delete=models.SET_NULL, null=True)
    azione = models.CharField(choices=AZIONE, max_length=1)

    oggetto_repr = models.CharField(max_length=1024, blank=True, null=True)
    oggetto_app_label = models.CharField(max_length=1024, blank=True, null=True, db_index=True)
    oggetto_model = models.CharField(max_length=1024, blank=True, null=True, db_index=True)
    oggetto_pk = models.IntegerField(blank=True, null=True, db_index=True)

    oggetto_campo = models.CharField(max_length=64, db_index=True, blank=True, null=True)
    valore_precedente = models.CharField(max_length=4096, blank=True, null=True)
    valore_successivo = models.CharField(max_length=4096, blank=True, null=True)

    @classmethod
    def _scomponi(cls, i):
        c = ContentType.objects.get_for_model(i)
        return c.app_label, c.model, i.pk

    @classmethod
    def modifica(cls, persona, oggetto, campo, valore_precedente="", valore_successivo=""):
        app_label, model, pk = cls._scomponi(oggetto)
        l = Log(
            persona=persona, azione=cls.MODIFICA,
            oggetto_repr=str(oggetto), oggetto_app_label=app_label,
            oggetto_model=model, oggetto_pk=pk, oggetto_campo=campo,
            valore_precedente=valore_precedente, valore_successivo=valore_successivo
        )
        l.save()
        return l

    @classmethod
    def crea(cls, persona, oggetto):
        app_label, model, pk = cls._scomponi(oggetto)
        l = Log(
            persona=persona, azione=cls.CREAZIONE,
            oggetto_repr=str(oggetto), oggetto_app_label=app_label,
            oggetto_model=model, oggetto_pk=pk,
        )
        l.save()
        return l

    @classmethod
    def registra_modifiche(cls, autore, modelform):
        """
        Dato un model form, registra le modifiche effettuate
        """

        righe = 0
        try:
            originale = modelform.instance.__class__.objects.get(pk=modelform.instance.pk)

        except:
            return righe

        if modelform.instance:
            # Modifica
            for campo, valore_successivo in modelform.cleaned_data.items():

                try:
                    valore_precedente = getattr(originale, campo)

                except AttributeError:
                    # Valore non esistente
                    continue

                if valore_precedente == valore_successivo:
                    continue  # Questo non e' stato modificato

                righe += 1
                cls.modifica(
                    autore, modelform.instance, campo,
                    valore_precedente, valore_successivo
                )

        else:
            # Creazione
            pass

        return righe



class ConAutorizzazioni(models.Model):
    """
    Aggiunge la possibilita' di aggiungere le funzionalita'
    di autorizzazione ad un ogetto.
    """

    class Meta:
        abstract = True

    autorizzazioni = GenericRelation(
        Autorizzazione,
        content_type_field='oggetto_tipo',
        object_id_field='oggetto_id'
    )

    def delete(self):
        """
        Cancella tutte le autorizzazioni prima di cancellare.
        """
        self.autorizzazioni.all().delete()
        super(ConAutorizzazioni, self).delete()

    confermata = models.BooleanField("Confermata", default=True, db_index=True)
    ritirata = models.BooleanField("Ritirata", default=False, db_index=True)

    ESITO_OK = "Confermato"
    ESITO_NO = "Negato"
    ESITO_RITIRATA = "Ritirata"
    ESITO_PENDING = "In attesa"

    # Sovrascrivimi! Invia notifiche e-mail?
    INVIA_NOTIFICHE = True

    INVIA_NOTIFICA_CONCESSA = INVIA_NOTIFICHE
    INVIA_NOTIFICA_NEGATA = INVIA_NOTIFICHE

    # Sovrascrivimi!
    RICHIESTA_NOME = "autorizzazione"

    @classmethod
    @concept
    def con_esito(cls, esito, **kwargs):
        """
        Ottiene QuerySet degli oggetti con esito selezionato.
        :param esito: L'esito: (*ConAutorizzazioni.ESITO_OK, .ESITO_NO, .ESITO_PENDING, .ESITO_RITIRATA).
        :return: QuerySet filtrato.
        """
        if esito == cls.ESITO_OK:
            return Q(confermata=True, ritirata=False, **kwargs)

        elif esito == cls.ESITO_RITIRATA:
            return Q(ritirata=True, **kwargs)

        elif esito == cls.ESITO_PENDING:
            # Confermata = False, ma almeno una autorizzazione e nessuna negata
            tipo = ContentType.objects.get_for_model(cls)
            return Q(
                        Q(confermata=False, ritirata=False,
                          pk__in=Autorizzazione.objects.filter(oggetto_tipo__pk=tipo.id).values_list('oggetto_id', flat=True)),
                        ~Q(
                          pk__in=Autorizzazione.objects.filter(oggetto_tipo__pk=tipo.id, concessa=False).values_list('oggetto_id', flat=True)
                        ),
                        **kwargs
                    )

        else:  # ESITO_NO
            tipo = ContentType.objects.get_for_model(cls)
            return Q(
                        Q(
                            # Confermata = False, ma non pendente
                            confermata=False,
                        ),
                        ~Q(pk__in=cls.con_esito(cls.ESITO_PENDING)),
                        **kwargs
                   )

    @classmethod
    def con_esito_ok(cls, **kwargs):
        """
        Ottiene un QuerySet per tutti gli oggetti con esito ESITO_OK.
        :return:
        """
        return cls.con_esito(cls.ESITO_OK, **kwargs)

    @classmethod
    def con_esito_ritirata(cls, **kwargs):
        """
        Ottiene un QuerySet per tutti gli oggetti con esito ESITO_RITIRATA.
        :return:
        """
        return cls.con_esito(cls.ESITO_RITIRATA, **kwargs)

    @classmethod
    def con_esito_pending(cls, **kwargs):
        """
        Ottiene un QuerySet per tutti gli oggetti con esito ESITO_PENDING.
        :return:
        """
        return cls.con_esito(cls.ESITO_PENDING, **kwargs)

    @classmethod
    def con_esito_no(cls, **kwargs):
        """
        Ottiene un QuerySet per tutti gli oggetti con esito ESITO_NO.
        :return:
        """
        return cls.con_esito(cls.ESITO_NO, **kwargs)

    @property
    def esito(self):
        """
        Ottiene l'esito. (*ConAutorizzazioni.ESITO_OK, .ESITO_NO, .ESITO_PENDING, .ESITO_RITIRATA).
        :return:
        """
        if self.confermata:  # Se confermata, okay
            return self.ESITO_OK

        elif self.ritirata:  # Ritirata?
            return self.ESITO_RITIRATA

        elif self.autorizzazioni.filter(concessa=False).exists():  # Altrimenti, se almeno una negazione, esito negativo
            return self.ESITO_NO

        elif not self.autorizzazioni.exists():  # Se non vi e' nessuna richiesta, allora e' negata d'ufficio
            return self.ESITO_NO

        else:  # Se non confermata e nessun esito negativo, ancora pendente
            return self.ESITO_PENDING

    @property
    def autorizzazioni_negate(self):
        return self.autorizzazioni.filter(concessa=False)

    @property
    def autorizzazioni(self):
        return self.autorizzazioni_set()

    def autorizzazioni_set(self):
        """
        Ottiene il queryset delle autorizzazioni associate.
        :return: Queryset.
        """
        tipo = ContentType.objects.get_for_model(self)
        return Autorizzazione.objects.filter(oggetto_tipo__pk=tipo.id, oggetto_id=self.id)

    def autorizzazione_richiedi_sede_riferimento(self, richiedente, incarico, invia_notifiche=[],
                                                 invia_notifica_presidente=False, invia_notifica_ufficio_soci=False,
                                                 forza_sede_riferimento=None, **kwargs):
        """
        Richiede una autorizzazione per l'oggetto attuale nel caso di incarico relativo
         alla sede di riferimento della Persona.

        Se la persona non ha sede di riferimento, ritorna False.
        Se la persona ha sede di riferimetno e tutto va bene, ritorna True.
        :param richiedente: La persona richiedente. Deve essere MEMBRO_DIRETTO attuale da qualche parte.
        :param incarico: Incarico necessario per la firma.
        :param invia_notifica: Inviare una notifica?
        :param kwargs: Aventuali argomenti aggiuntivi per autorizzazione.
        :return: False se persona non ha sede di riferimento, True altrimenti.
        """
        if forza_sede_riferimento:
            sede_riferimento = forza_sede_riferimento
        else:
            sede_riferimento = richiedente.sede_riferimento()
            if not sede_riferimento:
                return False

        if invia_notifica_presidente:
            presidente = sede_riferimento.presidente()
            invia_notifiche = list(invia_notifiche) + ([presidente] if presidente else [])

        if invia_notifica_ufficio_soci:
            ufficio_soci = list(sede_riferimento.delegati_ufficio_soci())
            invia_notifiche = list(invia_notifiche) + ufficio_soci

        self.autorizzazione_richiedi(richiedente, (incarico, sede_riferimento), invia_notifiche=invia_notifiche, **kwargs)
        return True

    def autorizzazione_richiedi(self, richiedente, destinatario, invia_notifiche=None, **kwargs):
        """
        Richiede una autorizzazione per l'oggetto attuale

        :param richiedente: Colui che inoltra la richiesta.
        :param destinatario: Gli incarichi che deve firmare l'autorizzazione, in forma
                      (INCARICO, OGGETTO). Puo' anche essere tupla ((INCARICO, Ogg1), (INCARICO, Ogg2), ...)
        :param invia_notifiche: Il ruolo che deve ricevere notifica della richiesta di autorizzazione,
                      (DELEGATIPO, OGGETTO). Puo' anche essere tupla ((DELEGATIPO, Ogg1), (DELEGATIPO, Ogg2), ...)
        :param kwargs:
        :return:
        """

        try:  # Cerca l'autorizzazione per questo oggetto con progressivo maggiore
            ultima = self.autorizzazioni_set().latest('progressivo')
            # Se esiste, calcola il prossimo progressivo per l'oggetto
            prossimo_progressivo = ultima.progressivo + 1

        except ObjectDoesNotExist:  # Se non esiste, ricomincia
            prossimo_progressivo = 1

        # Mi aspetto piu' destinatari. Se solo uno,
        # lo rendo tupla cosi' da poterci comunque ciclare.
        if type(destinatario[0]) is not tuple:
            destinatario = (destinatario, )

        # Per ogni destinatario aspettato
        for i in destinatario:

            (ruolo, oggetto) = i

            if ruolo not in INCARICHI_TIPO_DICT:
                raise ValueError("Il ruolo che si richiede firmi questa autorizzazione non esiste.")

            if oggetto.__class__.stringa_modello() != INCARICHI_TIPO_DICT[ruolo]:
                raise ValueError("L'oggetto specificato non e' valido per il ruolo che si richiede firmi "
                                 "l'autorizzazione.")

            # print("Richiesta autorizzazione a %s presso %s" % (ruolo, oggetto,))

            r = Autorizzazione(
                richiedente=richiedente,
                destinatario_ruolo=ruolo,
                destinatario_oggetto=oggetto,
                progressivo=prossimo_progressivo,
                oggetto=self,
                **kwargs
            )
            r.save()

            if invia_notifiche:

                if not iterabile(invia_notifiche):
                    invia_notifiche = [invia_notifiche]

                for persona in invia_notifiche:  # Per ogni person aa cui inviare notifica
                    if persona.autorizzazioni().filter(pk=r.pk).exists():
                        # Assicurati che la persona abbia autorizzazione
                        # ed eventualmente notifica la richiesta in arrivo.
                        r.notifica_richiesta(persona)

                        # print("Richiesta aut. %d notificata a %s come richiesto." % (r.pk, persona,))

                    else:
                        print("Richiesta aut. %d NON notificata a %s perché la persona non sembra "
                              "possa accedere alla notifica." % (r.pk, persona,))

        # Rimuovi eventuale stato di confermata
        self.confermata = False
        self.save()

        # Evita cache per esito
        self.refresh_from_db()

    def autorizzazioni_ritira(self):
        """
        Ritira le autorizzazioni pendenti ed imposta lo stato a ritirato.
        :return:
        """
        self.ritirata = True
        self.save()

        # Non diventa piu' necessaria alcuna autorizzazione tra quelle richieste
        self.autorizzazioni.update(necessaria=False)

    def autorizzazione_concessa(self, modulo=None):
        """
        Sovrascrivimi! Ascoltatore per concessione autorizzazione.
        """
        pass

    def autorizzazione_negata(self, modulo=None):
        """
        Sovrascrivimi! Ascoltatore per negazione autorizzazione.
        """
        pass

    def autorizzazione_concedi_modulo(self):
        """
        Sovrascrivimi! Ritorna la classe del modulo per la conferma.
        """
        return None

    def autorizzazione_nega_modulo(self):
        """
        Sovrascrivimi! Ritorna la classe del modulo per la negazione.
        """
        return ModuloMotivoNegazione


class ConScadenzaPulizia(models.Model):
    """
    Aggiunge un attributo DateTimeField scadenza.
    """

    class Meta:
        abstract = True

    scadenza = models.DateTimeField("Scadenza", null=True, blank=True, db_index=True, default=None)

    @property
    def scaduto(self):
        """
        Controlla se l'oggetto e' gia' scaduto o meno.

        :return:
        """
        if not self.scadenza:
            return False
        return self.scadenza < datetime.now()

    @classmethod
    def scaduti(cls):
        """
        Ottiene il queryset di oggetti scaduti (per la cancellazione?)
        :return:
        """
        return cls.objects.exclude(scadenza__isnull=True).filter(scadenza__lte=datetime.now())

    @classmethod
    def pulisci(cls):
        """
        Cancella gli elementi scaduti.
        :return: Il numero di elementi cancellati.
        """
        n = cls.scaduti().count()
        for x in cls.scaduti():
            x.delete()
        return n


class Token(ModelloSemplice, ConMarcaTemporale):
    persona = models.ForeignKey('anagrafica.Persona', related_name='tokens', on_delete=models.CASCADE)
    codice = models.CharField(max_length=128, unique=True, db_index=True, null=False)
    redirect = models.CharField(max_length=128, db_index=True, null=True)
    valido_ore = models.IntegerField(default=24)

    def valido(self):
        from django.utils import timezone
        return timezone.now() <= (self.creazione + timedelta(hours=self.valido_ore))

    @classmethod
    def genera(cls, persona, redirect="/", valido_ore=24):
        """
        Genera un codice per una data persona.
        :param persona:
        :param valido_ore:
        :return:
        """
        codice = genera_uuid_casuale()
        t = cls(
            persona=persona,
            codice=codice,
            valido_ore=valido_ore,
            redirect=redirect,
        )
        t.save()
        return codice

    @property
    def url(self):
        return "/token-sicuro/%s/" % (self.codice,)

    @classmethod
    def verifica(cls, token, redirect=True):
        """
        Verifica se un token e' valido per una data persona.

        """
        try:
            token = cls.objects.get(codice=token)
            if token.valido():
                return token.persona, token.redirect
            else:
                return False
        except cls.DoesNotExist:
            return False


class Allegato(ConMarcaTemporale, ConScadenzaPulizia, ModelloSemplice):
    """
    Rappresenta un allegato generico in database, con potenziale scadenza.
    """

    class Meta:
        verbose_name_plural = "Allegati"

    oggetto_tipo = models.ForeignKey(ContentType, db_index=True, blank=True, null=True, related_name="allegato_come_oggetto", on_delete=models.SET_NULL)
    oggetto_id = models.PositiveIntegerField(db_index=True, blank=True, null=True)
    oggetto = GenericForeignKey('oggetto_tipo', 'oggetto_id')
    file = models.FileField("File", upload_to=GeneratoreNomeFile('allegati/'),
                            validators=[valida_dimensione_file_10mb])
    nome = models.CharField("Nome file", max_length=255, default="File", blank=False, null=False)

    @property
    def download_url(self):
        """
        Ritorna l'URL per il download del file.
        """
        return self.file.url

    def prepara_cartelle(self, file_path, path_include_file=True):
        """
        Crea ricorsivamente le directory per la creazione di un file.
        Se path_include_file non specificato o True, il primo parametro aspettato e' il path completo
        al nuovo file. Altrimenti, solo il percorso da creare e' aspettato.
        """
        if path_include_file:
            path = os.path.dirname(file_path)
        else:
            path = file_path

        if os.path.isdir(path):
            return True

        try:
            os.makedirs(path)
        except OSError as e:
            if e.errno == 17:
                # Dir already exists. No biggie.
                pass

        return True

    def delete(self, *args, **kwargs):
        self.file.delete()
        super(Allegato, self).delete(*args, **kwargs)


class ConAllegati(models.Model):
    """
    Aggiunge la possibilita' di allegare file all'oggetto, anche con scadenza.
    """

    allegati = GenericRelation(
        Allegato,
        content_type_field='oggetto_tipo',
        object_id_field='oggetto_id'
    )

    class Meta:
        abstract = True


class ConVecchioID(models.Model):
    """
    Aggiunge un vecchio_id opzionale usato per retro-compatibilita.
    """

    class Meta:
        abstract = True

    vecchio_id = models.IntegerField(default=None, null=True, blank=True, db_index=True)
