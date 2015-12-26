from django.db import models

from base.models import ModelloSemplice, ConAutorizzazioni
from base.tratti import ConMarcaTemporale


class ConTipoDonazione(models.Model):
    class Meta:
        abstract = True

    DONAZIONE_SANGUE = 'S'
    DONAZIONE = (
        (DONAZIONE_SANGUE, "Donazione di Sangue"),
    )
    donazione = models.CharField(max_length=1, choices=DONAZIONE, default=DONAZIONE_SANGUE, db_index=True,)


class Donatore(ModelloSemplice, ConMarcaTemporale):

    persona = models.OneToOneField('anagrafica.Persona', related_name='donatore',)

    GRUPPO_0 = '0'
    GRUPPO_A = 'A'
    GRUPPO_B = 'B'
    GRUPPO_AB = 'AB'
    GRUPPO = (
        (GRUPPO_0, 'Gruppo 0'),
        (GRUPPO_A, 'Gruppo A'),
        (GRUPPO_B, 'Gruppo B'),
        (GRUPPO_AB, 'Gruppo AB'),
    )
    gruppo_sanguigno = models.CharField(max_length=3, choices=GRUPPO, db_index=True)

    RH_POS = 'P'
    RH_NEG = 'N'
    FATTORE_RH = (
        (RH_POS, 'Positivo'),
        (RH_NEG, 'Negativo'),
    )
    fattore_rh = models.CharField(max_length=2, choices=FATTORE_RH, db_index=True, blank=False, null=True)

    FANOTIPO_RH = (
        'CCDee',
        'ccDEE',
        'CcDee',
        'ccDEe',
        'ccDee',
        'CCDEE',
        'CCDEe',
        'CcDEE',
        'CcDEe',
        'Ccddee',
        'CCddee',
        'ccddEe',
        'ccddEE',
        'ccddee',
        'CcddEe',
    )
    FANOTIPO_RH_OPZIONI = ((x, x) for x in FANOTIPO_RH)
    fanotipo_rh = models.CharField(max_length=8, choices=FANOTIPO_RH_OPZIONI, db_index=True, blank=True, null=True)

    KELL = (
        'K+k+',
        'K+k-',
        'K-k+',
        'Kp(a+b+)',
        'Kp(a-b+)',
    )
    KELL_OPZIONI = ((x, x) for x in KELL)
    kell = models.CharField(max_length=16, choices=KELL_OPZIONI, blank=True, null=True)

    codice_sit = models.CharField(max_length=32, db_index=True, blank=True, null=True,)
    sede_sit = models.ForeignKey('sangue.Sede', null=True, blank=True)

    class Meta:
        verbose_name = "Donatore di Sangue"
        verbose_name_plural = "Donatori di Sangue"

    def __str__(self):
        return "Profilo Donatore %s" % (self.persona.nome_completo, )


class Sede(ModelloSemplice):

    citta = models.CharField(max_length=32)
    provincia = models.CharField(max_length=32)
    regione = models.CharField(max_length=32)

    nome = models.CharField(max_length=255)

    class Meta:
        verbose_name = "Sede di Donazione Sangue"
        verbose_name_plural = "Sedi di Donazione Sangue"
        ordering = ['regione', 'provincia', 'citta', 'nome',]

    def __str__(self):
        return "%s - %s - %s: %s" % (
            self.regione, self.provincia,
            self.citta, self.nome
        )


class Merito(ModelloSemplice, ConMarcaTemporale, ConTipoDonazione):

    persona = models.ForeignKey('anagrafica.Persona', related_name='meriti_donazioni')

    MERITO = (
        1, 10, 20, 40
    )
    MERITO_OPZIONI = ((str(x), str(x)) for x in MERITO)
    merito = models.CharField(choices=MERITO_OPZIONI, default=str(1), max_length=8)


class Donazione(ModelloSemplice, ConMarcaTemporale, ConAutorizzazioni):

    DONAZIONE_DIFFERITA = 'DD'
    DONAZIONE_SANGUE_INTERO = 'SI'
    DONAZIONE_PLASMAFERESI = 'PL'
    DONAZIONE_PLASMAPIASTRINOAFERESI = 'PP'
    DONAZIONE_PIASTRINOAFERESI = 'PI'
    DONAZIONE_ERITROPLASMAFERESI = 'EP'
    DONAZIONE_DOPPI_GLOBULI_ROSSI = '2R'
    DONAZIONE_DOPPIE_PIASTRINE = '2P'
    DONAZIONE_GLOBULI_ROSSI_E_PIASTRINE = 'RP'
    DONAZIONE_MIDOLLO_OSSEO = 'MO'
    TIPO = (
        (DONAZIONE_DIFFERITA, "Donazione Differita"),
        (DONAZIONE_SANGUE_INTERO, "Sangue Intero"),
        (DONAZIONE_PLASMAFERESI, "Plasmaferesi"),
        (DONAZIONE_PLASMAPIASTRINOAFERESI, "PlasmaPiastrinoaferesi"),
        (DONAZIONE_PIASTRINOAFERESI, "Piastrinoaferesi"),
        (DONAZIONE_ERITROPLASMAFERESI, "EritroPlasmaferesi"),
        (DONAZIONE_DOPPI_GLOBULI_ROSSI, "Doppi Globuli Rossi"),
        (DONAZIONE_DOPPIE_PIASTRINE, "Doppie Piastrine"),
        (DONAZIONE_GLOBULI_ROSSI_E_PIASTRINE, "Globuli Rossi e Piastrine"),
        (DONAZIONE_MIDOLLO_OSSEO, "Midollo Osseo"),
    )
    tipo = models.CharField(max_length=2, choices=TIPO, db_index=True)

    persona = models.ForeignKey('anagrafica.Persona', related_name='donazioni_sangue')
    data = models.DateField()
    sede = models.ForeignKey(Sede, related_name='donazioni_sangue', blank=False, null=True)

    RICHIESTA_NOME = "conferma donazione sangue"

    def autorizzazione_nega_modulo(self):
        # Nessun modulo per la negazione dell'autorizzazione.
        return None