# coding=utf-8

TERRITORIALE = 'T'
LOCALE = 'L'
PROVINCIALE = 'P'
REGIONALE = 'R'
NAZIONALE = 'N'
ESTENSIONE = (
    (TERRITORIALE, 'Unità Territoriale'),
    (LOCALE, 'Sede Locale'),
    (PROVINCIALE, 'Sede Provinciale'),
    (REGIONALE, 'Sede Regionale'),
    (NAZIONALE, 'Sede Nazionale')
)

# Ad uso di comparazione
ESTENSIONE_MINORE = {
    TERRITORIALE: [],
    LOCALE: [TERRITORIALE],
    PROVINCIALE: [LOCALE, TERRITORIALE],
    REGIONALE: [PROVINCIALE, LOCALE, TERRITORIALE],
    NAZIONALE: [REGIONALE, PROVINCIALE, LOCALE, TERRITORIALE]
}