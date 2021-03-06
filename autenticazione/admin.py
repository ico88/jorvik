from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from autenticazione.forms import ModuloModificaUtenza, ModuloCreazioneUtenza
from autenticazione.models import Utenza

__author__ = 'alfioemanuele'


@admin.register(Utenza)
class AdminUtenza(UserAdmin):
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Permessi', {'fields': ('is_active', 'is_staff', 'is_superuser',
                                 'groups', 'user_permissions')}),
        ('Utenza', {'fields': ('persona',)}),
        ('Date importanti', {'fields': ('last_login', )}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'password1', 'password2')
        }),
    )
    form = ModuloModificaUtenza
    add_form = ModuloCreazioneUtenza
    list_display = ('persona', 'email', 'ultimo_accesso', 'is_active', 'is_staff')
    search_fields = ('=id', 'email', 'persona__nome', 'persona__cognome', 'persona__codice_fiscale',)
    ordering = ('email',)
    raw_id_fields = ('persona', )

    # Permette login come utente
    change_form_template = 'loginas/change_form.html'

