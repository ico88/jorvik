PGDMP                         t            test_jorvik    9.5.1    9.5.1 @   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    618485    test_jorvik    DATABASE     }   CREATE DATABASE test_jorvik WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE test_jorvik;
             alfioemanuele    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    7            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    7                        3079    12623    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    618486    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false    7            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    2            �            1259    619955    anagrafica_appartenenza    TABLE       CREATE TABLE anagrafica_appartenenza (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    membro character varying(2) NOT NULL,
    terminazione character varying(1),
    persona_id integer NOT NULL,
    precedente_id integer,
    sede_id integer NOT NULL,
    vecchia_sede_id integer
);
 +   DROP TABLE public.anagrafica_appartenenza;
       public         alfioemanuele    false    7            �            1259    619953    anagrafica_appartenenza_id_seq    SEQUENCE     �   CREATE SEQUENCE anagrafica_appartenenza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.anagrafica_appartenenza_id_seq;
       public       alfioemanuele    false    7    213            �           0    0    anagrafica_appartenenza_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE anagrafica_appartenenza_id_seq OWNED BY anagrafica_appartenenza.id;
            public       alfioemanuele    false    212            �            1259    619963    anagrafica_delega    TABLE     �  CREATE TABLE anagrafica_delega (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    tipo character varying(2) NOT NULL,
    oggetto_id integer NOT NULL,
    firmatario_id integer,
    oggetto_tipo_id integer,
    persona_id integer NOT NULL,
    CONSTRAINT anagrafica_delega_oggetto_id_check CHECK ((oggetto_id >= 0))
);
 %   DROP TABLE public.anagrafica_delega;
       public         alfioemanuele    false    7            �            1259    619961    anagrafica_delega_id_seq    SEQUENCE     z   CREATE SEQUENCE anagrafica_delega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.anagrafica_delega_id_seq;
       public       alfioemanuele    false    215    7            �           0    0    anagrafica_delega_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE anagrafica_delega_id_seq OWNED BY anagrafica_delega.id;
            public       alfioemanuele    false    214            �            1259    619972    anagrafica_dimissione    TABLE     }  CREATE TABLE anagrafica_dimissione (
    id integer NOT NULL,
    motivo character varying(3) NOT NULL,
    info character varying(512) NOT NULL,
    appartenenza_id integer NOT NULL,
    persona_id integer NOT NULL,
    richiedente_id integer,
    sede_id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL
);
 )   DROP TABLE public.anagrafica_dimissione;
       public         alfioemanuele    false    7            �            1259    619970    anagrafica_dimissione_id_seq    SEQUENCE     ~   CREATE SEQUENCE anagrafica_dimissione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.anagrafica_dimissione_id_seq;
       public       alfioemanuele    false    7    217            �           0    0    anagrafica_dimissione_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE anagrafica_dimissione_id_seq OWNED BY anagrafica_dimissione.id;
            public       alfioemanuele    false    216            �            1259    619983    anagrafica_documento    TABLE       CREATE TABLE anagrafica_documento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    tipo character varying(1) NOT NULL,
    file character varying(100) NOT NULL,
    persona_id integer NOT NULL
);
 (   DROP TABLE public.anagrafica_documento;
       public         alfioemanuele    false    7            �            1259    619981    anagrafica_documento_id_seq    SEQUENCE     }   CREATE SEQUENCE anagrafica_documento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.anagrafica_documento_id_seq;
       public       alfioemanuele    false    7    219            �           0    0    anagrafica_documento_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE anagrafica_documento_id_seq OWNED BY anagrafica_documento.id;
            public       alfioemanuele    false    218            �            1259    619991    anagrafica_estensione    TABLE     �  CREATE TABLE anagrafica_estensione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    protocollo_numero character varying(512),
    protocollo_data date,
    motivo character varying(4096),
    appartenenza_id integer,
    destinazione_id integer NOT NULL,
    persona_id integer NOT NULL,
    richiedente_id integer
);
 )   DROP TABLE public.anagrafica_estensione;
       public         alfioemanuele    false    7            �            1259    619989    anagrafica_estensione_id_seq    SEQUENCE     ~   CREATE SEQUENCE anagrafica_estensione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.anagrafica_estensione_id_seq;
       public       alfioemanuele    false    7    221            �           0    0    anagrafica_estensione_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE anagrafica_estensione_id_seq OWNED BY anagrafica_estensione.id;
            public       alfioemanuele    false    220            �            1259    620002    anagrafica_fototessera    TABLE     4  CREATE TABLE anagrafica_fototessera (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    file character varying(100) NOT NULL,
    persona_id integer NOT NULL
);
 *   DROP TABLE public.anagrafica_fototessera;
       public         alfioemanuele    false    7            �            1259    620000    anagrafica_fototessera_id_seq    SEQUENCE        CREATE SEQUENCE anagrafica_fototessera_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.anagrafica_fototessera_id_seq;
       public       alfioemanuele    false    223    7            �           0    0    anagrafica_fototessera_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE anagrafica_fototessera_id_seq OWNED BY anagrafica_fototessera.id;
            public       alfioemanuele    false    222            �            1259    620010    anagrafica_persona    TABLE     d  CREATE TABLE anagrafica_persona (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    vecchio_id integer,
    nome character varying(64) NOT NULL,
    cognome character varying(64) NOT NULL,
    codice_fiscale character varying(16) NOT NULL,
    data_nascita date,
    genere character varying(1) NOT NULL,
    stato character varying(1) NOT NULL,
    comune_nascita character varying(64) NOT NULL,
    provincia_nascita character varying(2) NOT NULL,
    stato_nascita character varying(2) NOT NULL,
    indirizzo_residenza character varying(512),
    comune_residenza character varying(64),
    provincia_residenza character varying(2),
    stato_residenza character varying(2) NOT NULL,
    cap_residenza character varying(16),
    email_contatto character varying(255) NOT NULL,
    note text,
    avatar character varying(100),
    privacy_contatti smallint NOT NULL,
    privacy_curriculum smallint NOT NULL,
    privacy_deleghe smallint NOT NULL,
    cm boolean NOT NULL,
    conoscenza character varying(2),
    iv boolean NOT NULL
);
 &   DROP TABLE public.anagrafica_persona;
       public         alfioemanuele    false    7            �            1259    620008    anagrafica_persona_id_seq    SEQUENCE     {   CREATE SEQUENCE anagrafica_persona_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.anagrafica_persona_id_seq;
       public       alfioemanuele    false    225    7            �           0    0    anagrafica_persona_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE anagrafica_persona_id_seq OWNED BY anagrafica_persona.id;
            public       alfioemanuele    false    224            �            1259    620032 $   anagrafica_provvedimentodisciplinare    TABLE       CREATE TABLE anagrafica_provvedimentodisciplinare (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    protocollo_data date,
    protocollo_numero character varying(512),
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    motivazione character varying(500) NOT NULL,
    tipo character varying(1) NOT NULL,
    persona_id integer NOT NULL,
    sede_id integer NOT NULL,
    registrato_da_id integer
);
 8   DROP TABLE public.anagrafica_provvedimentodisciplinare;
       public         alfioemanuele    false    7            �            1259    620030 +   anagrafica_provvedimentodisciplinare_id_seq    SEQUENCE     �   CREATE SEQUENCE anagrafica_provvedimentodisciplinare_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.anagrafica_provvedimentodisciplinare_id_seq;
       public       alfioemanuele    false    7    227            �           0    0 +   anagrafica_provvedimentodisciplinare_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE anagrafica_provvedimentodisciplinare_id_seq OWNED BY anagrafica_provvedimentodisciplinare.id;
            public       alfioemanuele    false    226            �            1259    620043    anagrafica_riserva    TABLE     �  CREATE TABLE anagrafica_riserva (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    appartenenza_id integer NOT NULL,
    motivo character varying(4096) NOT NULL,
    persona_id integer NOT NULL,
    protocollo_data date,
    protocollo_numero character varying(512)
);
 &   DROP TABLE public.anagrafica_riserva;
       public         alfioemanuele    false    7            �            1259    620041    anagrafica_riserva_id_seq    SEQUENCE     {   CREATE SEQUENCE anagrafica_riserva_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.anagrafica_riserva_id_seq;
       public       alfioemanuele    false    7    229            �           0    0    anagrafica_riserva_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE anagrafica_riserva_id_seq OWNED BY anagrafica_riserva.id;
            public       alfioemanuele    false    228            �            1259    620051    anagrafica_sede    TABLE     �  CREATE TABLE anagrafica_sede (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    nome character varying(64) NOT NULL,
    vecchio_id integer,
    estensione character varying(1) NOT NULL,
    tipo character varying(1) NOT NULL,
    telefono character varying(64) NOT NULL,
    fax character varying(64) NOT NULL,
    email character varying(64) NOT NULL,
    codice_fiscale character varying(32) NOT NULL,
    partita_iva character varying(32) NOT NULL,
    attiva boolean NOT NULL,
    slug character varying(50) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    genitore_id integer,
    locazione_id integer,
    pec character varying(64) NOT NULL,
    iban character varying(32) NOT NULL,
    sito_web character varying(200) NOT NULL,
    CONSTRAINT anagrafica_sede_level_check CHECK ((level >= 0)),
    CONSTRAINT anagrafica_sede_lft_check CHECK ((lft >= 0)),
    CONSTRAINT anagrafica_sede_rght_check CHECK ((rght >= 0)),
    CONSTRAINT anagrafica_sede_tree_id_check CHECK ((tree_id >= 0))
);
 #   DROP TABLE public.anagrafica_sede;
       public         alfioemanuele    false    7            �            1259    620049    anagrafica_sede_id_seq    SEQUENCE     x   CREATE SEQUENCE anagrafica_sede_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.anagrafica_sede_id_seq;
       public       alfioemanuele    false    231    7            �           0    0    anagrafica_sede_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE anagrafica_sede_id_seq OWNED BY anagrafica_sede.id;
            public       alfioemanuele    false    230            �            1259    620063    anagrafica_telefono    TABLE       CREATE TABLE anagrafica_telefono (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    numero character varying(16) NOT NULL,
    servizio boolean NOT NULL,
    persona_id integer NOT NULL
);
 '   DROP TABLE public.anagrafica_telefono;
       public         alfioemanuele    false    7            �            1259    620061    anagrafica_telefono_id_seq    SEQUENCE     |   CREATE SEQUENCE anagrafica_telefono_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.anagrafica_telefono_id_seq;
       public       alfioemanuele    false    233    7            �           0    0    anagrafica_telefono_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE anagrafica_telefono_id_seq OWNED BY anagrafica_telefono.id;
            public       alfioemanuele    false    232            �            1259    620071    anagrafica_trasferimento    TABLE     �  CREATE TABLE anagrafica_trasferimento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    protocollo_numero character varying(16),
    protocollo_data date,
    motivo character varying(2048),
    appartenenza_id integer,
    destinazione_id integer NOT NULL,
    persona_id integer NOT NULL,
    richiedente_id integer
);
 ,   DROP TABLE public.anagrafica_trasferimento;
       public         alfioemanuele    false    7            �            1259    620069    anagrafica_trasferimento_id_seq    SEQUENCE     �   CREATE SEQUENCE anagrafica_trasferimento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.anagrafica_trasferimento_id_seq;
       public       alfioemanuele    false    7    235            �           0    0    anagrafica_trasferimento_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE anagrafica_trasferimento_id_seq OWNED BY anagrafica_trasferimento.id;
            public       alfioemanuele    false    234            �            1259    621082    attivita_area    TABLE     	  CREATE TABLE attivita_area (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    nome character varying(256) NOT NULL,
    obiettivo smallint NOT NULL,
    sede_id integer NOT NULL
);
 !   DROP TABLE public.attivita_area;
       public         alfioemanuele    false    7            �            1259    621080    attivita_area_id_seq    SEQUENCE     v   CREATE SEQUENCE attivita_area_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.attivita_area_id_seq;
       public       alfioemanuele    false    255    7            �           0    0    attivita_area_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE attivita_area_id_seq OWNED BY attivita_area.id;
            public       alfioemanuele    false    254                       1259    621090    attivita_attivita    TABLE     �  CREATE TABLE attivita_attivita (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    vecchio_id integer,
    nome character varying(255) NOT NULL,
    stato character varying(1) NOT NULL,
    apertura character varying(1) NOT NULL,
    descrizione text NOT NULL,
    area_id integer,
    estensione_id integer,
    locazione_id integer,
    sede_id integer NOT NULL,
    centrale_operativa character varying(1)
);
 %   DROP TABLE public.attivita_attivita;
       public         alfioemanuele    false    7                        1259    621088    attivita_attivita_id_seq    SEQUENCE     z   CREATE SEQUENCE attivita_attivita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.attivita_attivita_id_seq;
       public       alfioemanuele    false    7    257            �           0    0    attivita_attivita_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE attivita_attivita_id_seq OWNED BY attivita_attivita.id;
            public       alfioemanuele    false    256                       1259    621101    attivita_partecipazione    TABLE     |  CREATE TABLE attivita_partecipazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    stato character varying(1) NOT NULL,
    persona_id integer NOT NULL,
    turno_id integer NOT NULL,
    centrale_operativa boolean NOT NULL
);
 +   DROP TABLE public.attivita_partecipazione;
       public         alfioemanuele    false    7                       1259    621099    attivita_partecipazione_id_seq    SEQUENCE     �   CREATE SEQUENCE attivita_partecipazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.attivita_partecipazione_id_seq;
       public       alfioemanuele    false    7    259            �           0    0    attivita_partecipazione_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE attivita_partecipazione_id_seq OWNED BY attivita_partecipazione.id;
            public       alfioemanuele    false    258                       1259    621109    attivita_turno    TABLE     �  CREATE TABLE attivita_turno (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    nome character varying(128) NOT NULL,
    prenotazione timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    minimo smallint NOT NULL,
    massimo smallint,
    attivita_id integer NOT NULL
);
 "   DROP TABLE public.attivita_turno;
       public         alfioemanuele    false    7                       1259    621107    attivita_turno_id_seq    SEQUENCE     w   CREATE SEQUENCE attivita_turno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.attivita_turno_id_seq;
       public       alfioemanuele    false    7    261            �           0    0    attivita_turno_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE attivita_turno_id_seq OWNED BY attivita_turno.id;
            public       alfioemanuele    false    260            �            1259    620196    autenticazione_utenza    TABLE     �  CREATE TABLE autenticazione_utenza (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    email character varying(254) NOT NULL,
    ultimo_accesso timestamp with time zone,
    ultimo_consenso timestamp with time zone,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    persona_id integer
);
 )   DROP TABLE public.autenticazione_utenza;
       public         alfioemanuele    false    7            �            1259    620208    autenticazione_utenza_groups    TABLE     �   CREATE TABLE autenticazione_utenza_groups (
    id integer NOT NULL,
    utenza_id integer NOT NULL,
    group_id integer NOT NULL
);
 0   DROP TABLE public.autenticazione_utenza_groups;
       public         alfioemanuele    false    7            �            1259    620206 #   autenticazione_utenza_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE autenticazione_utenza_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.autenticazione_utenza_groups_id_seq;
       public       alfioemanuele    false    239    7            �           0    0 #   autenticazione_utenza_groups_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE autenticazione_utenza_groups_id_seq OWNED BY autenticazione_utenza_groups.id;
            public       alfioemanuele    false    238            �            1259    620194    autenticazione_utenza_id_seq    SEQUENCE     ~   CREATE SEQUENCE autenticazione_utenza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.autenticazione_utenza_id_seq;
       public       alfioemanuele    false    7    237            �           0    0    autenticazione_utenza_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE autenticazione_utenza_id_seq OWNED BY autenticazione_utenza.id;
            public       alfioemanuele    false    236            �            1259    620216 &   autenticazione_utenza_user_permissions    TABLE     �   CREATE TABLE autenticazione_utenza_user_permissions (
    id integer NOT NULL,
    utenza_id integer NOT NULL,
    permission_id integer NOT NULL
);
 :   DROP TABLE public.autenticazione_utenza_user_permissions;
       public         alfioemanuele    false    7            �            1259    620214 -   autenticazione_utenza_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE autenticazione_utenza_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.autenticazione_utenza_user_permissions_id_seq;
       public       alfioemanuele    false    7    241            �           0    0 -   autenticazione_utenza_user_permissions_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE autenticazione_utenza_user_permissions_id_seq OWNED BY autenticazione_utenza_user_permissions.id;
            public       alfioemanuele    false    240            �            1259    619914 
   auth_group    TABLE     ^   CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);
    DROP TABLE public.auth_group;
       public         alfioemanuele    false    7            �            1259    619912    auth_group_id_seq    SEQUENCE     s   CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public       alfioemanuele    false    209    7            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;
            public       alfioemanuele    false    208            �            1259    619924    auth_group_permissions    TABLE     �   CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         alfioemanuele    false    7            �            1259    619922    auth_group_permissions_id_seq    SEQUENCE        CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public       alfioemanuele    false    211    7            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;
            public       alfioemanuele    false    210            �            1259    619906    auth_permission    TABLE     �   CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         alfioemanuele    false    7            �            1259    619904    auth_permission_id_seq    SEQUENCE     x   CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public       alfioemanuele    false    207    7            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;
            public       alfioemanuele    false    206            �            1259    620285    base_allegato    TABLE     �  CREATE TABLE base_allegato (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    oggetto_id integer,
    file character varying(100) NOT NULL,
    nome character varying(255) NOT NULL,
    oggetto_tipo_id integer,
    scadenza timestamp with time zone,
    CONSTRAINT base_allegato_oggetto_id_check CHECK ((oggetto_id >= 0))
);
 !   DROP TABLE public.base_allegato;
       public         alfioemanuele    false    7            �            1259    620283    base_allegato_id_seq    SEQUENCE     v   CREATE SEQUENCE base_allegato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.base_allegato_id_seq;
       public       alfioemanuele    false    245    7            �           0    0    base_allegato_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE base_allegato_id_seq OWNED BY base_allegato.id;
            public       alfioemanuele    false    244            �            1259    620294    base_autorizzazione    TABLE     C  CREATE TABLE base_autorizzazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    concessa boolean,
    motivo_negazione character varying(512),
    oggetto_id integer NOT NULL,
    necessaria boolean NOT NULL,
    progressivo smallint NOT NULL,
    destinatario_ruolo character varying(16) NOT NULL,
    destinatario_oggetto_id integer NOT NULL,
    destinatario_oggetto_tipo_id integer,
    firmatario_id integer,
    oggetto_tipo_id integer,
    richiedente_id integer NOT NULL,
    CONSTRAINT base_autorizzazione_destinatario_oggetto_id_check CHECK ((destinatario_oggetto_id >= 0)),
    CONSTRAINT base_autorizzazione_oggetto_id_check CHECK ((oggetto_id >= 0)),
    CONSTRAINT base_autorizzazione_progressivo_check CHECK ((progressivo >= 0))
);
 '   DROP TABLE public.base_autorizzazione;
       public         alfioemanuele    false    7            �            1259    620292    base_autorizzazione_id_seq    SEQUENCE     |   CREATE SEQUENCE base_autorizzazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.base_autorizzazione_id_seq;
       public       alfioemanuele    false    247    7            �           0    0    base_autorizzazione_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE base_autorizzazione_id_seq OWNED BY base_autorizzazione.id;
            public       alfioemanuele    false    246            �            1259    620308    base_locazione    TABLE     !  CREATE TABLE base_locazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    indirizzo character varying(255) NOT NULL,
    geo geography(Point,4326) NOT NULL,
    via character varying(64) NOT NULL,
    civico character varying(16) NOT NULL,
    comune character varying(64) NOT NULL,
    provincia character varying(64) NOT NULL,
    regione character varying(64) NOT NULL,
    cap character varying(32) NOT NULL,
    stato character varying(2) NOT NULL
);
 "   DROP TABLE public.base_locazione;
       public         alfioemanuele    false    7    2    2    7    2    7    2    7    2    7    2    7    2    7    7    2    7            �            1259    620306    base_locazione_id_seq    SEQUENCE     w   CREATE SEQUENCE base_locazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.base_locazione_id_seq;
       public       alfioemanuele    false    249    7            �           0    0    base_locazione_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE base_locazione_id_seq OWNED BY base_locazione.id;
            public       alfioemanuele    false    248            �            1259    620322    base_log    TABLE        CREATE TABLE base_log (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    azione character varying(1) NOT NULL,
    oggetto_repr character varying(1024),
    oggetto_app_label character varying(1024),
    oggetto_model character varying(1024),
    oggetto_pk integer,
    oggetto_campo character varying(64),
    valore_precedente character varying(4096),
    valore_successivo character varying(4096),
    persona_id integer
);
    DROP TABLE public.base_log;
       public         alfioemanuele    false    7            �            1259    620320    base_log_id_seq    SEQUENCE     q   CREATE SEQUENCE base_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.base_log_id_seq;
       public       alfioemanuele    false    251    7            �           0    0    base_log_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE base_log_id_seq OWNED BY base_log.id;
            public       alfioemanuele    false    250            �            1259    620333 
   base_token    TABLE     0  CREATE TABLE base_token (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    codice character varying(128) NOT NULL,
    persona_id integer NOT NULL,
    redirect character varying(128),
    valido_ore integer NOT NULL
);
    DROP TABLE public.base_token;
       public         alfioemanuele    false    7            �            1259    620331    base_token_id_seq    SEQUENCE     s   CREATE SEQUENCE base_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.base_token_id_seq;
       public       alfioemanuele    false    253    7            �           0    0    base_token_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE base_token_id_seq OWNED BY base_token.id;
            public       alfioemanuele    false    252                       1259    621309    centrale_operativa_reperibilita    TABLE     U  CREATE TABLE centrale_operativa_reperibilita (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    attivazione time without time zone NOT NULL,
    persona_id integer NOT NULL
);
 3   DROP TABLE public.centrale_operativa_reperibilita;
       public         alfioemanuele    false    7                       1259    621307 &   centrale_operativa_reperibilita_id_seq    SEQUENCE     �   CREATE SEQUENCE centrale_operativa_reperibilita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.centrale_operativa_reperibilita_id_seq;
       public       alfioemanuele    false    7    263            �           0    0 &   centrale_operativa_reperibilita_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE centrale_operativa_reperibilita_id_seq OWNED BY centrale_operativa_reperibilita.id;
            public       alfioemanuele    false    262            	           1259    621317    centrale_operativa_turno    TABLE     y  CREATE TABLE centrale_operativa_turno (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    montato_data timestamp with time zone,
    smontato_data timestamp with time zone,
    montato_da_id integer,
    persona_id integer NOT NULL,
    smontato_da_id integer,
    turno_id integer NOT NULL
);
 ,   DROP TABLE public.centrale_operativa_turno;
       public         alfioemanuele    false    7                       1259    621315    centrale_operativa_turno_id_seq    SEQUENCE     �   CREATE SEQUENCE centrale_operativa_turno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.centrale_operativa_turno_id_seq;
       public       alfioemanuele    false    265    7            �           0    0    centrale_operativa_turno_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE centrale_operativa_turno_id_seq OWNED BY centrale_operativa_turno.id;
            public       alfioemanuele    false    264                       1259    621362    curriculum_titolo    TABLE     �  CREATE TABLE curriculum_titolo (
    id integer NOT NULL,
    vecchio_id integer,
    tipo character varying(2) NOT NULL,
    richiede_conferma boolean NOT NULL,
    richiede_data_ottenimento boolean NOT NULL,
    richiede_luogo_ottenimento boolean NOT NULL,
    richiede_data_scadenza boolean NOT NULL,
    richiede_codice boolean NOT NULL,
    inseribile_in_autonomia boolean NOT NULL,
    nome character varying(255) NOT NULL
);
 %   DROP TABLE public.curriculum_titolo;
       public         alfioemanuele    false    7            
           1259    621360    curriculum_titolo_id_seq    SEQUENCE     z   CREATE SEQUENCE curriculum_titolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.curriculum_titolo_id_seq;
       public       alfioemanuele    false    267    7            �           0    0    curriculum_titolo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE curriculum_titolo_id_seq OWNED BY curriculum_titolo.id;
            public       alfioemanuele    false    266                       1259    621370    curriculum_titolopersonale    TABLE       CREATE TABLE curriculum_titolopersonale (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    data_ottenimento date,
    luogo_ottenimento character varying(255),
    data_scadenza date,
    codice character varying(128),
    codice_corso character varying(128),
    certificato boolean NOT NULL,
    certificato_da_id integer,
    persona_id integer NOT NULL,
    titolo_id integer NOT NULL
);
 .   DROP TABLE public.curriculum_titolopersonale;
       public         alfioemanuele    false    7                       1259    621368 !   curriculum_titolopersonale_id_seq    SEQUENCE     �   CREATE SEQUENCE curriculum_titolopersonale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.curriculum_titolopersonale_id_seq;
       public       alfioemanuele    false    269    7            �           0    0 !   curriculum_titolopersonale_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE curriculum_titolopersonale_id_seq OWNED BY curriculum_titolopersonale.id;
            public       alfioemanuele    false    268            �            1259    620260    django_admin_log    TABLE     �  CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         alfioemanuele    false    7            �            1259    620258    django_admin_log_id_seq    SEQUENCE     y   CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public       alfioemanuele    false    243    7            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;
            public       alfioemanuele    false    242            �            1259    619896    django_content_type    TABLE     �   CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         alfioemanuele    false    7            �            1259    619894    django_content_type_id_seq    SEQUENCE     |   CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public       alfioemanuele    false    205    7            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;
            public       alfioemanuele    false    204                       1259    621418    django_cron_cronjoblog    TABLE     0  CREATE TABLE django_cron_cronjoblog (
    id integer NOT NULL,
    code character varying(64) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    is_success boolean NOT NULL,
    message text NOT NULL,
    ran_at_time time without time zone
);
 *   DROP TABLE public.django_cron_cronjoblog;
       public         alfioemanuele    false    7                       1259    621416    django_cron_cronjoblog_id_seq    SEQUENCE        CREATE SEQUENCE django_cron_cronjoblog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.django_cron_cronjoblog_id_seq;
       public       alfioemanuele    false    7    271                        0    0    django_cron_cronjoblog_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE django_cron_cronjoblog_id_seq OWNED BY django_cron_cronjoblog.id;
            public       alfioemanuele    false    270            �            1259    619854    django_migrations    TABLE     �   CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         alfioemanuele    false    7            �            1259    619852    django_migrations_id_seq    SEQUENCE     z   CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public       alfioemanuele    false    7    198                       0    0    django_migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;
            public       alfioemanuele    false    197            *           1259    621875    django_session    TABLE     �   CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         alfioemanuele    false    7            ,           1259    621887    django_site    TABLE     �   CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.django_site;
       public         alfioemanuele    false    7            +           1259    621885    django_site_id_seq    SEQUENCE     t   CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.django_site_id_seq;
       public       alfioemanuele    false    300    7                       0    0    django_site_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;
            public       alfioemanuele    false    299                       1259    621437    formazione_aspirante    TABLE     �   CREATE TABLE formazione_aspirante (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    raggio double precision,
    locazione_id integer,
    persona_id integer NOT NULL
);
 (   DROP TABLE public.formazione_aspirante;
       public         alfioemanuele    false    7                       1259    621435    formazione_aspirante_id_seq    SEQUENCE     }   CREATE SEQUENCE formazione_aspirante_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.formazione_aspirante_id_seq;
       public       alfioemanuele    false    7    273                       0    0    formazione_aspirante_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE formazione_aspirante_id_seq OWNED BY formazione_aspirante.id;
            public       alfioemanuele    false    272                       1259    621447    formazione_assenzacorsobase    TABLE       CREATE TABLE formazione_assenzacorsobase (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    lezione_id integer NOT NULL,
    persona_id integer NOT NULL,
    registrata_da_id integer
);
 /   DROP TABLE public.formazione_assenzacorsobase;
       public         alfioemanuele    false    7                       1259    621445 "   formazione_assenzacorsobase_id_seq    SEQUENCE     �   CREATE SEQUENCE formazione_assenzacorsobase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.formazione_assenzacorsobase_id_seq;
       public       alfioemanuele    false    275    7                       0    0 "   formazione_assenzacorsobase_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE formazione_assenzacorsobase_id_seq OWNED BY formazione_assenzacorsobase.id;
            public       alfioemanuele    false    274                       1259    621455    formazione_corsobase    TABLE     h  CREATE TABLE formazione_corsobase (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    stato character varying(1) NOT NULL,
    data_inizio timestamp with time zone NOT NULL,
    data_esame timestamp with time zone NOT NULL,
    progressivo smallint NOT NULL,
    anno smallint NOT NULL,
    descrizione text,
    locazione_id integer,
    sede_id integer NOT NULL,
    vecchio_id integer,
    data_attivazione date,
    data_convocazione date,
    op_attivazione character varying(255),
    op_convocazione character varying(255)
);
 (   DROP TABLE public.formazione_corsobase;
       public         alfioemanuele    false    7                       1259    621453    formazione_corsobase_id_seq    SEQUENCE     }   CREATE SEQUENCE formazione_corsobase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.formazione_corsobase_id_seq;
       public       alfioemanuele    false    7    277                       0    0    formazione_corsobase_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE formazione_corsobase_id_seq OWNED BY formazione_corsobase.id;
            public       alfioemanuele    false    276                       1259    621466    formazione_lezionecorsobase    TABLE     H  CREATE TABLE formazione_lezionecorsobase (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    nome character varying(128) NOT NULL,
    corso_id integer NOT NULL
);
 /   DROP TABLE public.formazione_lezionecorsobase;
       public         alfioemanuele    false    7                       1259    621464 "   formazione_lezionecorsobase_id_seq    SEQUENCE     �   CREATE SEQUENCE formazione_lezionecorsobase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.formazione_lezionecorsobase_id_seq;
       public       alfioemanuele    false    7    279                       0    0 "   formazione_lezionecorsobase_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE formazione_lezionecorsobase_id_seq OWNED BY formazione_lezionecorsobase.id;
            public       alfioemanuele    false    278                       1259    621474 "   formazione_partecipazionecorsobase    TABLE     �  CREATE TABLE formazione_partecipazionecorsobase (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    esito_esame character varying(2),
    ammissione character varying(2),
    motivo_non_ammissione character varying(1025),
    esito_parte_1 character varying(1),
    argomento_parte_1 character varying(1024),
    esito_parte_2 character varying(1),
    argomento_parte_2 character varying(1024),
    extra_1 boolean NOT NULL,
    extra_2 boolean NOT NULL,
    corso_id integer NOT NULL,
    persona_id integer NOT NULL,
    destinazione_id integer
);
 6   DROP TABLE public.formazione_partecipazionecorsobase;
       public         alfioemanuele    false    7                       1259    621472 )   formazione_partecipazionecorsobase_id_seq    SEQUENCE     �   CREATE SEQUENCE formazione_partecipazionecorsobase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.formazione_partecipazionecorsobase_id_seq;
       public       alfioemanuele    false    281    7                       0    0 )   formazione_partecipazionecorsobase_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE formazione_partecipazionecorsobase_id_seq OWNED BY formazione_partecipazionecorsobase.id;
            public       alfioemanuele    false    280                       1259    621638    gruppi_appartenenza    TABLE       CREATE TABLE gruppi_appartenenza (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    motivo_negazione character varying(512),
    gruppo_id integer NOT NULL,
    negato_da_id integer,
    persona_id integer NOT NULL
);
 '   DROP TABLE public.gruppi_appartenenza;
       public         alfioemanuele    false    7                       1259    621636    gruppi_appartenenza_id_seq    SEQUENCE     |   CREATE SEQUENCE gruppi_appartenenza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.gruppi_appartenenza_id_seq;
       public       alfioemanuele    false    283    7                       0    0    gruppi_appartenenza_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE gruppi_appartenenza_id_seq OWNED BY gruppi_appartenenza.id;
            public       alfioemanuele    false    282                       1259    621649    gruppi_gruppo    TABLE     d  CREATE TABLE gruppi_gruppo (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    estensione character varying(1) NOT NULL,
    nome character varying(255) NOT NULL,
    obiettivo integer NOT NULL,
    area_id integer,
    attivita_id integer,
    sede_id integer NOT NULL
);
 !   DROP TABLE public.gruppi_gruppo;
       public         alfioemanuele    false    7                       1259    621647    gruppi_gruppo_id_seq    SEQUENCE     v   CREATE SEQUENCE gruppi_gruppo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.gruppi_gruppo_id_seq;
       public       alfioemanuele    false    7    285            	           0    0    gruppi_gruppo_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE gruppi_gruppo_id_seq OWNED BY gruppi_gruppo.id;
            public       alfioemanuele    false    284            �            1259    619873    patenti_elemento    TABLE     �   CREATE TABLE patenti_elemento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL
);
 $   DROP TABLE public.patenti_elemento;
       public         alfioemanuele    false    7            �            1259    619871    patenti_elemento_id_seq    SEQUENCE     y   CREATE SEQUENCE patenti_elemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.patenti_elemento_id_seq;
       public       alfioemanuele    false    7    202            
           0    0    patenti_elemento_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE patenti_elemento_id_seq OWNED BY patenti_elemento.id;
            public       alfioemanuele    false    201            �            1259    619865    patenti_patente    TABLE     �   CREATE TABLE patenti_patente (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    tipo character varying(2) NOT NULL
);
 #   DROP TABLE public.patenti_patente;
       public         alfioemanuele    false    7            �            1259    619863    patenti_patente_id_seq    SEQUENCE     x   CREATE SEQUENCE patenti_patente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.patenti_patente_id_seq;
       public       alfioemanuele    false    200    7                       0    0    patenti_patente_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE patenti_patente_id_seq OWNED BY patenti_patente.id;
            public       alfioemanuele    false    199                       1259    621719    posta_destinatario    TABLE     I  CREATE TABLE posta_destinatario (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inviato boolean NOT NULL,
    tentativo timestamp with time zone,
    errore character varying(256),
    messaggio_id integer NOT NULL,
    persona_id integer
);
 &   DROP TABLE public.posta_destinatario;
       public         alfioemanuele    false    7                       1259    621717    posta_destinatario_id_seq    SEQUENCE     {   CREATE SEQUENCE posta_destinatario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.posta_destinatario_id_seq;
       public       alfioemanuele    false    7    287                       0    0    posta_destinatario_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE posta_destinatario_id_seq OWNED BY posta_destinatario.id;
            public       alfioemanuele    false    286            !           1259    621727    posta_messaggio    TABLE     s  CREATE TABLE posta_messaggio (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    oggetto character varying(256) NOT NULL,
    corpo text NOT NULL,
    ultimo_tentativo timestamp with time zone,
    terminato timestamp with time zone,
    mittente_id integer,
    rispondi_a_id integer
);
 #   DROP TABLE public.posta_messaggio;
       public         alfioemanuele    false    7                        1259    621725    posta_messaggio_id_seq    SEQUENCE     x   CREATE SEQUENCE posta_messaggio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.posta_messaggio_id_seq;
       public       alfioemanuele    false    289    7                       0    0    posta_messaggio_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE posta_messaggio_id_seq OWNED BY posta_messaggio.id;
            public       alfioemanuele    false    288            #           1259    621781    sangue_donatore    TABLE     �  CREATE TABLE sangue_donatore (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    gruppo_sanguigno character varying(3) NOT NULL,
    fattore_rh character varying(2),
    fanotipo_rh character varying(8),
    kell character varying(16),
    codice_sit character varying(32),
    persona_id integer NOT NULL,
    sede_sit_id integer
);
 #   DROP TABLE public.sangue_donatore;
       public         alfioemanuele    false    7            "           1259    621779    sangue_donatore_id_seq    SEQUENCE     x   CREATE SEQUENCE sangue_donatore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.sangue_donatore_id_seq;
       public       alfioemanuele    false    7    291                       0    0    sangue_donatore_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE sangue_donatore_id_seq OWNED BY sangue_donatore.id;
            public       alfioemanuele    false    290            %           1259    621791    sangue_donazione    TABLE     Y  CREATE TABLE sangue_donazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    confermata boolean NOT NULL,
    ritirata boolean NOT NULL,
    tipo character varying(2) NOT NULL,
    data date NOT NULL,
    persona_id integer NOT NULL,
    sede_id integer
);
 $   DROP TABLE public.sangue_donazione;
       public         alfioemanuele    false    7            $           1259    621789    sangue_donazione_id_seq    SEQUENCE     y   CREATE SEQUENCE sangue_donazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sangue_donazione_id_seq;
       public       alfioemanuele    false    7    293                       0    0    sangue_donazione_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE sangue_donazione_id_seq OWNED BY sangue_donazione.id;
            public       alfioemanuele    false    292            '           1259    621799    sangue_merito    TABLE       CREATE TABLE sangue_merito (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    donazione character varying(1) NOT NULL,
    merito character varying(8) NOT NULL,
    persona_id integer NOT NULL
);
 !   DROP TABLE public.sangue_merito;
       public         alfioemanuele    false    7            &           1259    621797    sangue_merito_id_seq    SEQUENCE     v   CREATE SEQUENCE sangue_merito_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.sangue_merito_id_seq;
       public       alfioemanuele    false    295    7                       0    0    sangue_merito_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE sangue_merito_id_seq OWNED BY sangue_merito.id;
            public       alfioemanuele    false    294            )           1259    621807    sangue_sede    TABLE     �   CREATE TABLE sangue_sede (
    id integer NOT NULL,
    citta character varying(32) NOT NULL,
    provincia character varying(32) NOT NULL,
    regione character varying(32) NOT NULL,
    nome character varying(255) NOT NULL
);
    DROP TABLE public.sangue_sede;
       public         alfioemanuele    false    7            (           1259    621805    sangue_sede_id_seq    SEQUENCE     t   CREATE SEQUENCE sangue_sede_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sangue_sede_id_seq;
       public       alfioemanuele    false    297    7                       0    0    sangue_sede_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE sangue_sede_id_seq OWNED BY sangue_sede.id;
            public       alfioemanuele    false    296            .           1259    621898    social_commento    TABLE     g  CREATE TABLE social_commento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    commento text NOT NULL,
    oggetto_id integer NOT NULL,
    autore_id integer NOT NULL,
    oggetto_tipo_id integer,
    CONSTRAINT social_commento_oggetto_id_check CHECK ((oggetto_id >= 0))
);
 #   DROP TABLE public.social_commento;
       public         alfioemanuele    false    7            -           1259    621896    social_commento_id_seq    SEQUENCE     x   CREATE SEQUENCE social_commento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.social_commento_id_seq;
       public       alfioemanuele    false    7    302                       0    0    social_commento_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE social_commento_id_seq OWNED BY social_commento.id;
            public       alfioemanuele    false    301            0           1259    621910    social_giudizio    TABLE     j  CREATE TABLE social_giudizio (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    positivo boolean NOT NULL,
    oggetto_id integer NOT NULL,
    autore_id integer NOT NULL,
    oggetto_tipo_id integer,
    CONSTRAINT social_giudizio_oggetto_id_check CHECK ((oggetto_id >= 0))
);
 #   DROP TABLE public.social_giudizio;
       public         alfioemanuele    false    7            /           1259    621908    social_giudizio_id_seq    SEQUENCE     x   CREATE SEQUENCE social_giudizio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.social_giudizio_id_seq;
       public       alfioemanuele    false    7    304                       0    0    social_giudizio_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE social_giudizio_id_seq OWNED BY social_giudizio.id;
            public       alfioemanuele    false    303            �            1259    619879    thumbnail_kvstore    TABLE     e   CREATE TABLE thumbnail_kvstore (
    key character varying(200) NOT NULL,
    value text NOT NULL
);
 %   DROP TABLE public.thumbnail_kvstore;
       public         alfioemanuele    false    7            2           1259    621962    ufficio_soci_quota    TABLE     �  CREATE TABLE ufficio_soci_quota (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    progressivo integer NOT NULL,
    anno smallint NOT NULL,
    data_versamento date NOT NULL,
    data_annullamento date,
    stato character varying(1) NOT NULL,
    tipo character varying(1) NOT NULL,
    importo double precision NOT NULL,
    importo_extra double precision NOT NULL,
    causale character varying(512) NOT NULL,
    causale_extra character varying(512) NOT NULL,
    annullato_da_id integer,
    appartenenza_id integer,
    persona_id integer NOT NULL,
    registrato_da_id integer,
    sede_id integer NOT NULL,
    vecchio_id integer
);
 &   DROP TABLE public.ufficio_soci_quota;
       public         alfioemanuele    false    7            1           1259    621960    ufficio_soci_quota_id_seq    SEQUENCE     {   CREATE SEQUENCE ufficio_soci_quota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ufficio_soci_quota_id_seq;
       public       alfioemanuele    false    7    306                       0    0    ufficio_soci_quota_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE ufficio_soci_quota_id_seq OWNED BY ufficio_soci_quota.id;
            public       alfioemanuele    false    305            4           1259    621973    ufficio_soci_tesseramento    TABLE     �  CREATE TABLE ufficio_soci_tesseramento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    stato character varying(1) NOT NULL,
    anno smallint NOT NULL,
    inizio date NOT NULL,
    quota_attivo double precision NOT NULL,
    quota_ordinario double precision NOT NULL,
    quota_benemerito double precision NOT NULL,
    quota_aspirante double precision NOT NULL,
    quota_sostenitore double precision NOT NULL
);
 -   DROP TABLE public.ufficio_soci_tesseramento;
       public         alfioemanuele    false    7            3           1259    621971     ufficio_soci_tesseramento_id_seq    SEQUENCE     �   CREATE SEQUENCE ufficio_soci_tesseramento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ufficio_soci_tesseramento_id_seq;
       public       alfioemanuele    false    308    7                       0    0     ufficio_soci_tesseramento_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE ufficio_soci_tesseramento_id_seq OWNED BY ufficio_soci_tesseramento.id;
            public       alfioemanuele    false    307            6           1259    621983    ufficio_soci_tesserino    TABLE     �  CREATE TABLE ufficio_soci_tesserino (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    tipo_richiesta character varying(3) NOT NULL,
    stato_richiesta character varying(3) NOT NULL,
    motivo_richiesta character varying(512),
    motivo_rifiutato character varying(512),
    stato_emissione character varying(8),
    valido boolean NOT NULL,
    codice character varying(13),
    data_conferma timestamp with time zone,
    data_riconsegna timestamp with time zone,
    confermato_da_id integer,
    emesso_da_id integer NOT NULL,
    persona_id integer NOT NULL,
    richiesto_da_id integer NOT NULL,
    riconsegnato_a_id integer
);
 *   DROP TABLE public.ufficio_soci_tesserino;
       public         alfioemanuele    false    7            5           1259    621981    ufficio_soci_tesserino_id_seq    SEQUENCE        CREATE SEQUENCE ufficio_soci_tesserino_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.ufficio_soci_tesserino_id_seq;
       public       alfioemanuele    false    7    310                       0    0    ufficio_soci_tesserino_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE ufficio_soci_tesserino_id_seq OWNED BY ufficio_soci_tesserino.id;
            public       alfioemanuele    false    309            8           1259    622119    veicoli_autoparco    TABLE     a  CREATE TABLE veicoli_autoparco (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    estensione character varying(1) NOT NULL,
    nome character varying(256) NOT NULL,
    telefono character varying(64) NOT NULL,
    locazione_id integer,
    sede_id integer NOT NULL
);
 %   DROP TABLE public.veicoli_autoparco;
       public         alfioemanuele    false    7            7           1259    622117    veicoli_autoparco_id_seq    SEQUENCE     z   CREATE SEQUENCE veicoli_autoparco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.veicoli_autoparco_id_seq;
       public       alfioemanuele    false    7    312                       0    0    veicoli_autoparco_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE veicoli_autoparco_id_seq OWNED BY veicoli_autoparco.id;
            public       alfioemanuele    false    311            :           1259    622127    veicoli_collocazione    TABLE     V  CREATE TABLE veicoli_collocazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    autoparco_id integer NOT NULL,
    creato_da_id integer,
    veicolo_id integer NOT NULL
);
 (   DROP TABLE public.veicoli_collocazione;
       public         alfioemanuele    false    7            9           1259    622125    veicoli_collocazione_id_seq    SEQUENCE     }   CREATE SEQUENCE veicoli_collocazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.veicoli_collocazione_id_seq;
       public       alfioemanuele    false    7    314                       0    0    veicoli_collocazione_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE veicoli_collocazione_id_seq OWNED BY veicoli_collocazione.id;
            public       alfioemanuele    false    313            <           1259    622135    veicoli_fermotecnico    TABLE     _  CREATE TABLE veicoli_fermotecnico (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    inizio timestamp with time zone NOT NULL,
    fine timestamp with time zone,
    motivo character varying(512) NOT NULL,
    creato_da_id integer,
    veicolo_id integer NOT NULL
);
 (   DROP TABLE public.veicoli_fermotecnico;
       public         alfioemanuele    false    7            ;           1259    622133    veicoli_fermotecnico_id_seq    SEQUENCE     }   CREATE SEQUENCE veicoli_fermotecnico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.veicoli_fermotecnico_id_seq;
       public       alfioemanuele    false    316    7                       0    0    veicoli_fermotecnico_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE veicoli_fermotecnico_id_seq OWNED BY veicoli_fermotecnico.id;
            public       alfioemanuele    false    315            >           1259    622146    veicoli_manutenzione    TABLE       CREATE TABLE veicoli_manutenzione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    tipo character varying(1) NOT NULL,
    data date NOT NULL,
    descrizione text,
    km integer NOT NULL,
    manutentore character varying(512) NOT NULL,
    numero_fattura character varying(64) NOT NULL,
    costo double precision NOT NULL,
    creato_da_id integer,
    veicolo_id integer NOT NULL,
    CONSTRAINT veicoli_manutenzione_km_check CHECK ((km >= 0))
);
 (   DROP TABLE public.veicoli_manutenzione;
       public         alfioemanuele    false    7            =           1259    622144    veicoli_manutenzione_id_seq    SEQUENCE     }   CREATE SEQUENCE veicoli_manutenzione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.veicoli_manutenzione_id_seq;
       public       alfioemanuele    false    7    318                       0    0    veicoli_manutenzione_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE veicoli_manutenzione_id_seq OWNED BY veicoli_manutenzione.id;
            public       alfioemanuele    false    317            @           1259    622159    veicoli_rifornimento    TABLE     K  CREATE TABLE veicoli_rifornimento (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    data timestamp with time zone NOT NULL,
    contachilometri integer NOT NULL,
    costo double precision NOT NULL,
    consumo_carburante double precision NOT NULL,
    presso character varying(1),
    contalitri double precision,
    ricevuta character varying(32),
    veicolo_id integer NOT NULL,
    creato_da_id integer,
    CONSTRAINT veicoli_rifornimento_contachilometri_check CHECK ((contachilometri >= 0))
);
 (   DROP TABLE public.veicoli_rifornimento;
       public         alfioemanuele    false    7            ?           1259    622157    veicoli_rifornimento_id_seq    SEQUENCE     }   CREATE SEQUENCE veicoli_rifornimento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.veicoli_rifornimento_id_seq;
       public       alfioemanuele    false    320    7                       0    0    veicoli_rifornimento_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE veicoli_rifornimento_id_seq OWNED BY veicoli_rifornimento.id;
            public       alfioemanuele    false    319            B           1259    622168    veicoli_segnalazione    TABLE     $  CREATE TABLE veicoli_segnalazione (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    descrizione text NOT NULL,
    autore_id integer NOT NULL,
    manutenzione_id integer,
    veicolo_id integer NOT NULL
);
 (   DROP TABLE public.veicoli_segnalazione;
       public         alfioemanuele    false    7            A           1259    622166    veicoli_segnalazione_id_seq    SEQUENCE     }   CREATE SEQUENCE veicoli_segnalazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.veicoli_segnalazione_id_seq;
       public       alfioemanuele    false    7    322                       0    0    veicoli_segnalazione_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE veicoli_segnalazione_id_seq OWNED BY veicoli_segnalazione.id;
            public       alfioemanuele    false    321            D           1259    622179    veicoli_veicolo    TABLE     �  CREATE TABLE veicoli_veicolo (
    id integer NOT NULL,
    creazione timestamp with time zone NOT NULL,
    ultima_modifica timestamp with time zone NOT NULL,
    stato character varying(2) NOT NULL,
    libretto character varying(32) NOT NULL,
    targa character varying(16) NOT NULL,
    prima_immatricolazione date NOT NULL,
    proprietario_cognome character varying(127) NOT NULL,
    proprietario_nome character varying(127) NOT NULL,
    proprietario_indirizzo character varying(127) NOT NULL,
    pneumatici_anteriori character varying(255) NOT NULL,
    pneumatici_posteriori character varying(255) NOT NULL,
    pneumatici_alt_anteriori character varying(255),
    pneumatici_alt_posteriori character varying(255),
    cambio character varying(32) NOT NULL,
    lunghezza double precision,
    larghezza double precision,
    sbalzo double precision,
    tara integer,
    marca character varying(32) NOT NULL,
    modello character varying(32) NOT NULL,
    telaio character varying(64),
    massa_max integer NOT NULL,
    data_immatricolazione date NOT NULL,
    categoria character varying(128) NOT NULL,
    destinazione character varying(128) NOT NULL,
    carrozzeria character varying(128) NOT NULL,
    omologazione character varying(32),
    num_assi integer NOT NULL,
    rimorchio_frenato double precision,
    cilindrata integer NOT NULL,
    potenza_massima integer NOT NULL,
    alimentazione character varying(1),
    posti integer NOT NULL,
    regime integer NOT NULL,
    card_rifornimento character varying(64),
    selettiva_radio character varying(64),
    telepass character varying(64),
    intervallo_revisione integer NOT NULL,
    CONSTRAINT veicoli_veicolo_cilindrata_check CHECK ((cilindrata >= 0)),
    CONSTRAINT veicoli_veicolo_intervallo_revisione_check CHECK ((intervallo_revisione >= 0)),
    CONSTRAINT veicoli_veicolo_massa_max_check CHECK ((massa_max >= 0)),
    CONSTRAINT veicoli_veicolo_num_assi_check CHECK ((num_assi >= 0)),
    CONSTRAINT veicoli_veicolo_posti_check CHECK ((posti >= 0)),
    CONSTRAINT veicoli_veicolo_potenza_massima_check CHECK ((potenza_massima >= 0)),
    CONSTRAINT veicoli_veicolo_regime_check CHECK ((regime >= 0)),
    CONSTRAINT veicoli_veicolo_tara_check CHECK ((tara >= 0))
);
 #   DROP TABLE public.veicoli_veicolo;
       public         alfioemanuele    false    7            C           1259    622177    veicoli_veicolo_id_seq    SEQUENCE     x   CREATE SEQUENCE veicoli_veicolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.veicoli_veicolo_id_seq;
       public       alfioemanuele    false    324    7                       0    0    veicoli_veicolo_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE veicoli_veicolo_id_seq OWNED BY veicoli_veicolo.id;
            public       alfioemanuele    false    323            �           2604    619958    id    DEFAULT     z   ALTER TABLE ONLY anagrafica_appartenenza ALTER COLUMN id SET DEFAULT nextval('anagrafica_appartenenza_id_seq'::regclass);
 I   ALTER TABLE public.anagrafica_appartenenza ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    213    212    213            �           2604    619966    id    DEFAULT     n   ALTER TABLE ONLY anagrafica_delega ALTER COLUMN id SET DEFAULT nextval('anagrafica_delega_id_seq'::regclass);
 C   ALTER TABLE public.anagrafica_delega ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    215    214    215            �           2604    619975    id    DEFAULT     v   ALTER TABLE ONLY anagrafica_dimissione ALTER COLUMN id SET DEFAULT nextval('anagrafica_dimissione_id_seq'::regclass);
 G   ALTER TABLE public.anagrafica_dimissione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    217    216    217            �           2604    619986    id    DEFAULT     t   ALTER TABLE ONLY anagrafica_documento ALTER COLUMN id SET DEFAULT nextval('anagrafica_documento_id_seq'::regclass);
 F   ALTER TABLE public.anagrafica_documento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    218    219    219            �           2604    619994    id    DEFAULT     v   ALTER TABLE ONLY anagrafica_estensione ALTER COLUMN id SET DEFAULT nextval('anagrafica_estensione_id_seq'::regclass);
 G   ALTER TABLE public.anagrafica_estensione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    220    221    221            �           2604    620005    id    DEFAULT     x   ALTER TABLE ONLY anagrafica_fototessera ALTER COLUMN id SET DEFAULT nextval('anagrafica_fototessera_id_seq'::regclass);
 H   ALTER TABLE public.anagrafica_fototessera ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    222    223    223            �           2604    620013    id    DEFAULT     p   ALTER TABLE ONLY anagrafica_persona ALTER COLUMN id SET DEFAULT nextval('anagrafica_persona_id_seq'::regclass);
 D   ALTER TABLE public.anagrafica_persona ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    225    224    225            �           2604    620035    id    DEFAULT     �   ALTER TABLE ONLY anagrafica_provvedimentodisciplinare ALTER COLUMN id SET DEFAULT nextval('anagrafica_provvedimentodisciplinare_id_seq'::regclass);
 V   ALTER TABLE public.anagrafica_provvedimentodisciplinare ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    227    226    227            �           2604    620046    id    DEFAULT     p   ALTER TABLE ONLY anagrafica_riserva ALTER COLUMN id SET DEFAULT nextval('anagrafica_riserva_id_seq'::regclass);
 D   ALTER TABLE public.anagrafica_riserva ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    228    229    229            �           2604    620054    id    DEFAULT     j   ALTER TABLE ONLY anagrafica_sede ALTER COLUMN id SET DEFAULT nextval('anagrafica_sede_id_seq'::regclass);
 A   ALTER TABLE public.anagrafica_sede ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    230    231    231            �           2604    620066    id    DEFAULT     r   ALTER TABLE ONLY anagrafica_telefono ALTER COLUMN id SET DEFAULT nextval('anagrafica_telefono_id_seq'::regclass);
 E   ALTER TABLE public.anagrafica_telefono ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    232    233    233            �           2604    620074    id    DEFAULT     |   ALTER TABLE ONLY anagrafica_trasferimento ALTER COLUMN id SET DEFAULT nextval('anagrafica_trasferimento_id_seq'::regclass);
 J   ALTER TABLE public.anagrafica_trasferimento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    235    234    235            �           2604    621085    id    DEFAULT     f   ALTER TABLE ONLY attivita_area ALTER COLUMN id SET DEFAULT nextval('attivita_area_id_seq'::regclass);
 ?   ALTER TABLE public.attivita_area ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    254    255    255            �           2604    621093    id    DEFAULT     n   ALTER TABLE ONLY attivita_attivita ALTER COLUMN id SET DEFAULT nextval('attivita_attivita_id_seq'::regclass);
 C   ALTER TABLE public.attivita_attivita ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    256    257    257            �           2604    621104    id    DEFAULT     z   ALTER TABLE ONLY attivita_partecipazione ALTER COLUMN id SET DEFAULT nextval('attivita_partecipazione_id_seq'::regclass);
 I   ALTER TABLE public.attivita_partecipazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    258    259    259            �           2604    621112    id    DEFAULT     h   ALTER TABLE ONLY attivita_turno ALTER COLUMN id SET DEFAULT nextval('attivita_turno_id_seq'::regclass);
 @   ALTER TABLE public.attivita_turno ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    261    260    261            �           2604    620199    id    DEFAULT     v   ALTER TABLE ONLY autenticazione_utenza ALTER COLUMN id SET DEFAULT nextval('autenticazione_utenza_id_seq'::regclass);
 G   ALTER TABLE public.autenticazione_utenza ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    236    237    237            �           2604    620211    id    DEFAULT     �   ALTER TABLE ONLY autenticazione_utenza_groups ALTER COLUMN id SET DEFAULT nextval('autenticazione_utenza_groups_id_seq'::regclass);
 N   ALTER TABLE public.autenticazione_utenza_groups ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    239    238    239            �           2604    620219    id    DEFAULT     �   ALTER TABLE ONLY autenticazione_utenza_user_permissions ALTER COLUMN id SET DEFAULT nextval('autenticazione_utenza_user_permissions_id_seq'::regclass);
 X   ALTER TABLE public.autenticazione_utenza_user_permissions ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    241    240    241            �           2604    619917    id    DEFAULT     `   ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    209    208    209            �           2604    619927    id    DEFAULT     x   ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    211    210    211            �           2604    619909    id    DEFAULT     j   ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    206    207    207            �           2604    620288    id    DEFAULT     f   ALTER TABLE ONLY base_allegato ALTER COLUMN id SET DEFAULT nextval('base_allegato_id_seq'::regclass);
 ?   ALTER TABLE public.base_allegato ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    245    244    245            �           2604    620297    id    DEFAULT     r   ALTER TABLE ONLY base_autorizzazione ALTER COLUMN id SET DEFAULT nextval('base_autorizzazione_id_seq'::regclass);
 E   ALTER TABLE public.base_autorizzazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    246    247    247            �           2604    620311    id    DEFAULT     h   ALTER TABLE ONLY base_locazione ALTER COLUMN id SET DEFAULT nextval('base_locazione_id_seq'::regclass);
 @   ALTER TABLE public.base_locazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    249    248    249            �           2604    620325    id    DEFAULT     \   ALTER TABLE ONLY base_log ALTER COLUMN id SET DEFAULT nextval('base_log_id_seq'::regclass);
 :   ALTER TABLE public.base_log ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    251    250    251            �           2604    620336    id    DEFAULT     `   ALTER TABLE ONLY base_token ALTER COLUMN id SET DEFAULT nextval('base_token_id_seq'::regclass);
 <   ALTER TABLE public.base_token ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    252    253    253            �           2604    621312    id    DEFAULT     �   ALTER TABLE ONLY centrale_operativa_reperibilita ALTER COLUMN id SET DEFAULT nextval('centrale_operativa_reperibilita_id_seq'::regclass);
 Q   ALTER TABLE public.centrale_operativa_reperibilita ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    262    263    263            �           2604    621320    id    DEFAULT     |   ALTER TABLE ONLY centrale_operativa_turno ALTER COLUMN id SET DEFAULT nextval('centrale_operativa_turno_id_seq'::regclass);
 J   ALTER TABLE public.centrale_operativa_turno ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    264    265    265            �           2604    621365    id    DEFAULT     n   ALTER TABLE ONLY curriculum_titolo ALTER COLUMN id SET DEFAULT nextval('curriculum_titolo_id_seq'::regclass);
 C   ALTER TABLE public.curriculum_titolo ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    267    266    267            �           2604    621373    id    DEFAULT     �   ALTER TABLE ONLY curriculum_titolopersonale ALTER COLUMN id SET DEFAULT nextval('curriculum_titolopersonale_id_seq'::regclass);
 L   ALTER TABLE public.curriculum_titolopersonale ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    269    268    269            �           2604    620263    id    DEFAULT     l   ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    243    242    243            �           2604    619899    id    DEFAULT     r   ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    205    204    205            �           2604    621421    id    DEFAULT     x   ALTER TABLE ONLY django_cron_cronjoblog ALTER COLUMN id SET DEFAULT nextval('django_cron_cronjoblog_id_seq'::regclass);
 H   ALTER TABLE public.django_cron_cronjoblog ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    270    271    271            ~           2604    619857    id    DEFAULT     n   ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    197    198    198            �           2604    621890    id    DEFAULT     b   ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);
 =   ALTER TABLE public.django_site ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    299    300    300            �           2604    621440    id    DEFAULT     t   ALTER TABLE ONLY formazione_aspirante ALTER COLUMN id SET DEFAULT nextval('formazione_aspirante_id_seq'::regclass);
 F   ALTER TABLE public.formazione_aspirante ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    272    273    273            �           2604    621450    id    DEFAULT     �   ALTER TABLE ONLY formazione_assenzacorsobase ALTER COLUMN id SET DEFAULT nextval('formazione_assenzacorsobase_id_seq'::regclass);
 M   ALTER TABLE public.formazione_assenzacorsobase ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    275    274    275            �           2604    621458    id    DEFAULT     t   ALTER TABLE ONLY formazione_corsobase ALTER COLUMN id SET DEFAULT nextval('formazione_corsobase_id_seq'::regclass);
 F   ALTER TABLE public.formazione_corsobase ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    277    276    277            �           2604    621469    id    DEFAULT     �   ALTER TABLE ONLY formazione_lezionecorsobase ALTER COLUMN id SET DEFAULT nextval('formazione_lezionecorsobase_id_seq'::regclass);
 M   ALTER TABLE public.formazione_lezionecorsobase ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    279    278    279            �           2604    621477    id    DEFAULT     �   ALTER TABLE ONLY formazione_partecipazionecorsobase ALTER COLUMN id SET DEFAULT nextval('formazione_partecipazionecorsobase_id_seq'::regclass);
 T   ALTER TABLE public.formazione_partecipazionecorsobase ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    280    281    281            �           2604    621641    id    DEFAULT     r   ALTER TABLE ONLY gruppi_appartenenza ALTER COLUMN id SET DEFAULT nextval('gruppi_appartenenza_id_seq'::regclass);
 E   ALTER TABLE public.gruppi_appartenenza ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    283    282    283            �           2604    621652    id    DEFAULT     f   ALTER TABLE ONLY gruppi_gruppo ALTER COLUMN id SET DEFAULT nextval('gruppi_gruppo_id_seq'::regclass);
 ?   ALTER TABLE public.gruppi_gruppo ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    284    285    285            �           2604    619876    id    DEFAULT     l   ALTER TABLE ONLY patenti_elemento ALTER COLUMN id SET DEFAULT nextval('patenti_elemento_id_seq'::regclass);
 B   ALTER TABLE public.patenti_elemento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    201    202    202                       2604    619868    id    DEFAULT     j   ALTER TABLE ONLY patenti_patente ALTER COLUMN id SET DEFAULT nextval('patenti_patente_id_seq'::regclass);
 A   ALTER TABLE public.patenti_patente ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    200    199    200            �           2604    621722    id    DEFAULT     p   ALTER TABLE ONLY posta_destinatario ALTER COLUMN id SET DEFAULT nextval('posta_destinatario_id_seq'::regclass);
 D   ALTER TABLE public.posta_destinatario ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    286    287    287            �           2604    621730    id    DEFAULT     j   ALTER TABLE ONLY posta_messaggio ALTER COLUMN id SET DEFAULT nextval('posta_messaggio_id_seq'::regclass);
 A   ALTER TABLE public.posta_messaggio ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    288    289    289            �           2604    621784    id    DEFAULT     j   ALTER TABLE ONLY sangue_donatore ALTER COLUMN id SET DEFAULT nextval('sangue_donatore_id_seq'::regclass);
 A   ALTER TABLE public.sangue_donatore ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    290    291    291            �           2604    621794    id    DEFAULT     l   ALTER TABLE ONLY sangue_donazione ALTER COLUMN id SET DEFAULT nextval('sangue_donazione_id_seq'::regclass);
 B   ALTER TABLE public.sangue_donazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    293    292    293            �           2604    621802    id    DEFAULT     f   ALTER TABLE ONLY sangue_merito ALTER COLUMN id SET DEFAULT nextval('sangue_merito_id_seq'::regclass);
 ?   ALTER TABLE public.sangue_merito ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    295    294    295            �           2604    621810    id    DEFAULT     b   ALTER TABLE ONLY sangue_sede ALTER COLUMN id SET DEFAULT nextval('sangue_sede_id_seq'::regclass);
 =   ALTER TABLE public.sangue_sede ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    297    296    297            �           2604    621901    id    DEFAULT     j   ALTER TABLE ONLY social_commento ALTER COLUMN id SET DEFAULT nextval('social_commento_id_seq'::regclass);
 A   ALTER TABLE public.social_commento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    301    302    302            �           2604    621913    id    DEFAULT     j   ALTER TABLE ONLY social_giudizio ALTER COLUMN id SET DEFAULT nextval('social_giudizio_id_seq'::regclass);
 A   ALTER TABLE public.social_giudizio ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    303    304    304            �           2604    621965    id    DEFAULT     p   ALTER TABLE ONLY ufficio_soci_quota ALTER COLUMN id SET DEFAULT nextval('ufficio_soci_quota_id_seq'::regclass);
 D   ALTER TABLE public.ufficio_soci_quota ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    306    305    306            �           2604    621976    id    DEFAULT     ~   ALTER TABLE ONLY ufficio_soci_tesseramento ALTER COLUMN id SET DEFAULT nextval('ufficio_soci_tesseramento_id_seq'::regclass);
 K   ALTER TABLE public.ufficio_soci_tesseramento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    307    308    308            �           2604    621986    id    DEFAULT     x   ALTER TABLE ONLY ufficio_soci_tesserino ALTER COLUMN id SET DEFAULT nextval('ufficio_soci_tesserino_id_seq'::regclass);
 H   ALTER TABLE public.ufficio_soci_tesserino ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    309    310    310            �           2604    622122    id    DEFAULT     n   ALTER TABLE ONLY veicoli_autoparco ALTER COLUMN id SET DEFAULT nextval('veicoli_autoparco_id_seq'::regclass);
 C   ALTER TABLE public.veicoli_autoparco ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    311    312    312            �           2604    622130    id    DEFAULT     t   ALTER TABLE ONLY veicoli_collocazione ALTER COLUMN id SET DEFAULT nextval('veicoli_collocazione_id_seq'::regclass);
 F   ALTER TABLE public.veicoli_collocazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    314    313    314            �           2604    622138    id    DEFAULT     t   ALTER TABLE ONLY veicoli_fermotecnico ALTER COLUMN id SET DEFAULT nextval('veicoli_fermotecnico_id_seq'::regclass);
 F   ALTER TABLE public.veicoli_fermotecnico ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    315    316    316            �           2604    622149    id    DEFAULT     t   ALTER TABLE ONLY veicoli_manutenzione ALTER COLUMN id SET DEFAULT nextval('veicoli_manutenzione_id_seq'::regclass);
 F   ALTER TABLE public.veicoli_manutenzione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    317    318    318            �           2604    622162    id    DEFAULT     t   ALTER TABLE ONLY veicoli_rifornimento ALTER COLUMN id SET DEFAULT nextval('veicoli_rifornimento_id_seq'::regclass);
 F   ALTER TABLE public.veicoli_rifornimento ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    319    320    320            �           2604    622171    id    DEFAULT     t   ALTER TABLE ONLY veicoli_segnalazione ALTER COLUMN id SET DEFAULT nextval('veicoli_segnalazione_id_seq'::regclass);
 F   ALTER TABLE public.veicoli_segnalazione ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    321    322    322            �           2604    622182    id    DEFAULT     j   ALTER TABLE ONLY veicoli_veicolo ALTER COLUMN id SET DEFAULT nextval('veicoli_veicolo_id_seq'::regclass);
 A   ALTER TABLE public.veicoli_veicolo ALTER COLUMN id DROP DEFAULT;
       public       alfioemanuele    false    324    323    324            f          0    619955    anagrafica_appartenenza 
   TABLE DATA               �   COPY anagrafica_appartenenza (id, creazione, ultima_modifica, inizio, fine, confermata, ritirata, membro, terminazione, persona_id, precedente_id, sede_id, vecchia_sede_id) FROM stdin;
    public       alfioemanuele    false    213   �                 0    0    anagrafica_appartenenza_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('anagrafica_appartenenza_id_seq', 30, true);
            public       alfioemanuele    false    212            h          0    619963    anagrafica_delega 
   TABLE DATA               �   COPY anagrafica_delega (id, creazione, ultima_modifica, inizio, fine, tipo, oggetto_id, firmatario_id, oggetto_tipo_id, persona_id) FROM stdin;
    public       alfioemanuele    false    215   ;�                 0    0    anagrafica_delega_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('anagrafica_delega_id_seq', 17, true);
            public       alfioemanuele    false    214            j          0    619972    anagrafica_dimissione 
   TABLE DATA               �   COPY anagrafica_dimissione (id, motivo, info, appartenenza_id, persona_id, richiedente_id, sede_id, creazione, ultima_modifica) FROM stdin;
    public       alfioemanuele    false    217   X�                  0    0    anagrafica_dimissione_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('anagrafica_dimissione_id_seq', 1, false);
            public       alfioemanuele    false    216            l          0    619983    anagrafica_documento 
   TABLE DATA               _   COPY anagrafica_documento (id, creazione, ultima_modifica, tipo, file, persona_id) FROM stdin;
    public       alfioemanuele    false    219   u�      !           0    0    anagrafica_documento_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('anagrafica_documento_id_seq', 1, true);
            public       alfioemanuele    false    218            n          0    619991    anagrafica_estensione 
   TABLE DATA               �   COPY anagrafica_estensione (id, creazione, ultima_modifica, confermata, ritirata, protocollo_numero, protocollo_data, motivo, appartenenza_id, destinazione_id, persona_id, richiedente_id) FROM stdin;
    public       alfioemanuele    false    221   ��      "           0    0    anagrafica_estensione_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('anagrafica_estensione_id_seq', 2, true);
            public       alfioemanuele    false    220            p          0    620002    anagrafica_fototessera 
   TABLE DATA               q   COPY anagrafica_fototessera (id, creazione, ultima_modifica, confermata, ritirata, file, persona_id) FROM stdin;
    public       alfioemanuele    false    223   ��      #           0    0    anagrafica_fototessera_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('anagrafica_fototessera_id_seq', 1, false);
            public       alfioemanuele    false    222            r          0    620010    anagrafica_persona 
   TABLE DATA               �  COPY anagrafica_persona (id, creazione, ultima_modifica, vecchio_id, nome, cognome, codice_fiscale, data_nascita, genere, stato, comune_nascita, provincia_nascita, stato_nascita, indirizzo_residenza, comune_residenza, provincia_residenza, stato_residenza, cap_residenza, email_contatto, note, avatar, privacy_contatti, privacy_curriculum, privacy_deleghe, cm, conoscenza, iv) FROM stdin;
    public       alfioemanuele    false    225   ��      $           0    0    anagrafica_persona_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('anagrafica_persona_id_seq', 38, true);
            public       alfioemanuele    false    224            t          0    620032 $   anagrafica_provvedimentodisciplinare 
   TABLE DATA               �   COPY anagrafica_provvedimentodisciplinare (id, creazione, ultima_modifica, protocollo_data, protocollo_numero, inizio, fine, motivazione, tipo, persona_id, sede_id, registrato_da_id) FROM stdin;
    public       alfioemanuele    false    227   ��      %           0    0 +   anagrafica_provvedimentodisciplinare_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('anagrafica_provvedimentodisciplinare_id_seq', 1, false);
            public       alfioemanuele    false    226            v          0    620043    anagrafica_riserva 
   TABLE DATA               �   COPY anagrafica_riserva (id, creazione, ultima_modifica, inizio, fine, confermata, ritirata, appartenenza_id, motivo, persona_id, protocollo_data, protocollo_numero) FROM stdin;
    public       alfioemanuele    false    229   �      &           0    0    anagrafica_riserva_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('anagrafica_riserva_id_seq', 1, false);
            public       alfioemanuele    false    228            x          0    620051    anagrafica_sede 
   TABLE DATA               �   COPY anagrafica_sede (id, creazione, ultima_modifica, nome, vecchio_id, estensione, tipo, telefono, fax, email, codice_fiscale, partita_iva, attiva, slug, lft, rght, tree_id, level, genitore_id, locazione_id, pec, iban, sito_web) FROM stdin;
    public       alfioemanuele    false    231   #�      '           0    0    anagrafica_sede_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('anagrafica_sede_id_seq', 45, true);
            public       alfioemanuele    false    230            z          0    620063    anagrafica_telefono 
   TABLE DATA               d   COPY anagrafica_telefono (id, creazione, ultima_modifica, numero, servizio, persona_id) FROM stdin;
    public       alfioemanuele    false    233   @�      (           0    0    anagrafica_telefono_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('anagrafica_telefono_id_seq', 1, false);
            public       alfioemanuele    false    232            |          0    620071    anagrafica_trasferimento 
   TABLE DATA               �   COPY anagrafica_trasferimento (id, creazione, ultima_modifica, confermata, ritirata, protocollo_numero, protocollo_data, motivo, appartenenza_id, destinazione_id, persona_id, richiedente_id) FROM stdin;
    public       alfioemanuele    false    235   ]�      )           0    0    anagrafica_trasferimento_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('anagrafica_trasferimento_id_seq', 1, false);
            public       alfioemanuele    false    234            �          0    621082    attivita_area 
   TABLE DATA               Z   COPY attivita_area (id, creazione, ultima_modifica, nome, obiettivo, sede_id) FROM stdin;
    public       alfioemanuele    false    255   z�      *           0    0    attivita_area_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('attivita_area_id_seq', 4, true);
            public       alfioemanuele    false    254            �          0    621090    attivita_attivita 
   TABLE DATA               �   COPY attivita_attivita (id, creazione, ultima_modifica, vecchio_id, nome, stato, apertura, descrizione, area_id, estensione_id, locazione_id, sede_id, centrale_operativa) FROM stdin;
    public       alfioemanuele    false    257   ��      +           0    0    attivita_attivita_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('attivita_attivita_id_seq', 6, true);
            public       alfioemanuele    false    256            �          0    621101    attivita_partecipazione 
   TABLE DATA               �   COPY attivita_partecipazione (id, creazione, ultima_modifica, confermata, ritirata, stato, persona_id, turno_id, centrale_operativa) FROM stdin;
    public       alfioemanuele    false    259   ��      ,           0    0    attivita_partecipazione_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('attivita_partecipazione_id_seq', 1, true);
            public       alfioemanuele    false    258            �          0    621109    attivita_turno 
   TABLE DATA               �   COPY attivita_turno (id, creazione, ultima_modifica, nome, prenotazione, inizio, fine, minimo, massimo, attivita_id) FROM stdin;
    public       alfioemanuele    false    261   ��      -           0    0    attivita_turno_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('attivita_turno_id_seq', 8, true);
            public       alfioemanuele    false    260            ~          0    620196    autenticazione_utenza 
   TABLE DATA               �   COPY autenticazione_utenza (id, password, last_login, is_superuser, creazione, ultima_modifica, email, ultimo_accesso, ultimo_consenso, is_staff, is_active, persona_id) FROM stdin;
    public       alfioemanuele    false    237   ��      �          0    620208    autenticazione_utenza_groups 
   TABLE DATA               H   COPY autenticazione_utenza_groups (id, utenza_id, group_id) FROM stdin;
    public       alfioemanuele    false    239   �      .           0    0 #   autenticazione_utenza_groups_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('autenticazione_utenza_groups_id_seq', 1, false);
            public       alfioemanuele    false    238            /           0    0    autenticazione_utenza_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('autenticazione_utenza_id_seq', 1, true);
            public       alfioemanuele    false    236            �          0    620216 &   autenticazione_utenza_user_permissions 
   TABLE DATA               W   COPY autenticazione_utenza_user_permissions (id, utenza_id, permission_id) FROM stdin;
    public       alfioemanuele    false    241   (�      0           0    0 -   autenticazione_utenza_user_permissions_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('autenticazione_utenza_user_permissions_id_seq', 1, false);
            public       alfioemanuele    false    240            b          0    619914 
   auth_group 
   TABLE DATA               '   COPY auth_group (id, name) FROM stdin;
    public       alfioemanuele    false    209   E�      1           0    0    auth_group_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('auth_group_id_seq', 1, false);
            public       alfioemanuele    false    208            d          0    619924    auth_group_permissions 
   TABLE DATA               F   COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public       alfioemanuele    false    211   b�      2           0    0    auth_group_permissions_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);
            public       alfioemanuele    false    210            `          0    619906    auth_permission 
   TABLE DATA               G   COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
    public       alfioemanuele    false    207   �      3           0    0    auth_permission_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('auth_permission_id_seq', 390, true);
            public       alfioemanuele    false    206            �          0    620285    base_allegato 
   TABLE DATA               s   COPY base_allegato (id, creazione, ultima_modifica, oggetto_id, file, nome, oggetto_tipo_id, scadenza) FROM stdin;
    public       alfioemanuele    false    245   ��      4           0    0    base_allegato_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('base_allegato_id_seq', 1, true);
            public       alfioemanuele    false    244            �          0    620294    base_autorizzazione 
   TABLE DATA                 COPY base_autorizzazione (id, creazione, ultima_modifica, concessa, motivo_negazione, oggetto_id, necessaria, progressivo, destinatario_ruolo, destinatario_oggetto_id, destinatario_oggetto_tipo_id, firmatario_id, oggetto_tipo_id, richiedente_id) FROM stdin;
    public       alfioemanuele    false    247   �      5           0    0    base_autorizzazione_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('base_autorizzazione_id_seq', 5, true);
            public       alfioemanuele    false    246            �          0    620308    base_locazione 
   TABLE DATA               �   COPY base_locazione (id, creazione, ultima_modifica, indirizzo, geo, via, civico, comune, provincia, regione, cap, stato) FROM stdin;
    public       alfioemanuele    false    249   8�      6           0    0    base_locazione_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('base_locazione_id_seq', 1, false);
            public       alfioemanuele    false    248            �          0    620322    base_log 
   TABLE DATA               �   COPY base_log (id, creazione, ultima_modifica, azione, oggetto_repr, oggetto_app_label, oggetto_model, oggetto_pk, oggetto_campo, valore_precedente, valore_successivo, persona_id) FROM stdin;
    public       alfioemanuele    false    251   U�      7           0    0    base_log_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('base_log_id_seq', 1, false);
            public       alfioemanuele    false    250            �          0    620333 
   base_token 
   TABLE DATA               g   COPY base_token (id, creazione, ultima_modifica, codice, persona_id, redirect, valido_ore) FROM stdin;
    public       alfioemanuele    false    253   r�      8           0    0    base_token_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('base_token_id_seq', 1, false);
            public       alfioemanuele    false    252            �          0    621309    centrale_operativa_reperibilita 
   TABLE DATA               y   COPY centrale_operativa_reperibilita (id, creazione, ultima_modifica, inizio, fine, attivazione, persona_id) FROM stdin;
    public       alfioemanuele    false    263   ��      9           0    0 &   centrale_operativa_reperibilita_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('centrale_operativa_reperibilita_id_seq', 1, false);
            public       alfioemanuele    false    262            �          0    621317    centrale_operativa_turno 
   TABLE DATA               �   COPY centrale_operativa_turno (id, creazione, ultima_modifica, montato_data, smontato_data, montato_da_id, persona_id, smontato_da_id, turno_id) FROM stdin;
    public       alfioemanuele    false    265   ��      :           0    0    centrale_operativa_turno_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('centrale_operativa_turno_id_seq', 1, false);
            public       alfioemanuele    false    264            �          0    621362    curriculum_titolo 
   TABLE DATA               �   COPY curriculum_titolo (id, vecchio_id, tipo, richiede_conferma, richiede_data_ottenimento, richiede_luogo_ottenimento, richiede_data_scadenza, richiede_codice, inseribile_in_autonomia, nome) FROM stdin;
    public       alfioemanuele    false    267   ��      ;           0    0    curriculum_titolo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('curriculum_titolo_id_seq', 1, false);
            public       alfioemanuele    false    266            �          0    621370    curriculum_titolopersonale 
   TABLE DATA               �   COPY curriculum_titolopersonale (id, creazione, ultima_modifica, confermata, ritirata, data_ottenimento, luogo_ottenimento, data_scadenza, codice, codice_corso, certificato, certificato_da_id, persona_id, titolo_id) FROM stdin;
    public       alfioemanuele    false    269   ��      <           0    0 !   curriculum_titolopersonale_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('curriculum_titolopersonale_id_seq', 1, false);
            public       alfioemanuele    false    268            �          0    620260    django_admin_log 
   TABLE DATA               �   COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public       alfioemanuele    false    243   �      =           0    0    django_admin_log_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);
            public       alfioemanuele    false    242            ^          0    619896    django_content_type 
   TABLE DATA               <   COPY django_content_type (id, app_label, model) FROM stdin;
    public       alfioemanuele    false    205    �      >           0    0    django_content_type_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('django_content_type_id_seq', 130, true);
            public       alfioemanuele    false    204            �          0    621418    django_cron_cronjoblog 
   TABLE DATA               k   COPY django_cron_cronjoblog (id, code, start_time, end_time, is_success, message, ran_at_time) FROM stdin;
    public       alfioemanuele    false    271   ��      ?           0    0    django_cron_cronjoblog_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('django_cron_cronjoblog_id_seq', 1, false);
            public       alfioemanuele    false    270            W          0    619854    django_migrations 
   TABLE DATA               <   COPY django_migrations (id, app, name, applied) FROM stdin;
    public       alfioemanuele    false    198   ��      @           0    0    django_migrations_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('django_migrations_id_seq', 132, true);
            public       alfioemanuele    false    197            �          0    621875    django_session 
   TABLE DATA               I   COPY django_session (session_key, session_data, expire_date) FROM stdin;
    public       alfioemanuele    false    298   ��      �          0    621887    django_site 
   TABLE DATA               0   COPY django_site (id, domain, name) FROM stdin;
    public       alfioemanuele    false    300   ��      A           0    0    django_site_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('django_site_id_seq', 1, true);
            public       alfioemanuele    false    299            �          0    621437    formazione_aspirante 
   TABLE DATA               i   COPY formazione_aspirante (id, creazione, ultima_modifica, raggio, locazione_id, persona_id) FROM stdin;
    public       alfioemanuele    false    273   �      B           0    0    formazione_aspirante_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('formazione_aspirante_id_seq', 1, false);
            public       alfioemanuele    false    272            �          0    621447    formazione_assenzacorsobase 
   TABLE DATA               x   COPY formazione_assenzacorsobase (id, creazione, ultima_modifica, lezione_id, persona_id, registrata_da_id) FROM stdin;
    public       alfioemanuele    false    275   !�      C           0    0 "   formazione_assenzacorsobase_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('formazione_assenzacorsobase_id_seq', 1, false);
            public       alfioemanuele    false    274            �          0    621455    formazione_corsobase 
   TABLE DATA               �   COPY formazione_corsobase (id, creazione, ultima_modifica, stato, data_inizio, data_esame, progressivo, anno, descrizione, locazione_id, sede_id, vecchio_id, data_attivazione, data_convocazione, op_attivazione, op_convocazione) FROM stdin;
    public       alfioemanuele    false    277   >�      D           0    0    formazione_corsobase_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('formazione_corsobase_id_seq', 1, false);
            public       alfioemanuele    false    276            �          0    621466    formazione_lezionecorsobase 
   TABLE DATA               l   COPY formazione_lezionecorsobase (id, creazione, ultima_modifica, inizio, fine, nome, corso_id) FROM stdin;
    public       alfioemanuele    false    279   [�      E           0    0 "   formazione_lezionecorsobase_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('formazione_lezionecorsobase_id_seq', 1, false);
            public       alfioemanuele    false    278            �          0    621474 "   formazione_partecipazionecorsobase 
   TABLE DATA                 COPY formazione_partecipazionecorsobase (id, creazione, ultima_modifica, confermata, ritirata, esito_esame, ammissione, motivo_non_ammissione, esito_parte_1, argomento_parte_1, esito_parte_2, argomento_parte_2, extra_1, extra_2, corso_id, persona_id, destinazione_id) FROM stdin;
    public       alfioemanuele    false    281   x�      F           0    0 )   formazione_partecipazionecorsobase_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('formazione_partecipazionecorsobase_id_seq', 1, false);
            public       alfioemanuele    false    280            �          0    621638    gruppi_appartenenza 
   TABLE DATA               �   COPY gruppi_appartenenza (id, creazione, ultima_modifica, inizio, fine, motivo_negazione, gruppo_id, negato_da_id, persona_id) FROM stdin;
    public       alfioemanuele    false    283   ��      G           0    0    gruppi_appartenenza_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('gruppi_appartenenza_id_seq', 1, false);
            public       alfioemanuele    false    282            �          0    621649    gruppi_gruppo 
   TABLE DATA               |   COPY gruppi_gruppo (id, creazione, ultima_modifica, estensione, nome, obiettivo, area_id, attivita_id, sede_id) FROM stdin;
    public       alfioemanuele    false    285   ��      H           0    0    gruppi_gruppo_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('gruppi_gruppo_id_seq', 1, false);
            public       alfioemanuele    false    284            [          0    619873    patenti_elemento 
   TABLE DATA               Y   COPY patenti_elemento (id, creazione, ultima_modifica, confermata, ritirata) FROM stdin;
    public       alfioemanuele    false    202   ��      I           0    0    patenti_elemento_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('patenti_elemento_id_seq', 1, false);
            public       alfioemanuele    false    201            Y          0    619865    patenti_patente 
   TABLE DATA               H   COPY patenti_patente (id, creazione, ultima_modifica, tipo) FROM stdin;
    public       alfioemanuele    false    200   ��      J           0    0    patenti_patente_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('patenti_patente_id_seq', 1, false);
            public       alfioemanuele    false    199            �          0    621719    posta_destinatario 
   TABLE DATA               {   COPY posta_destinatario (id, creazione, ultima_modifica, inviato, tentativo, errore, messaggio_id, persona_id) FROM stdin;
    public       alfioemanuele    false    287   	�      K           0    0    posta_destinatario_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('posta_destinatario_id_seq', 7, true);
            public       alfioemanuele    false    286            �          0    621727    posta_messaggio 
   TABLE DATA               �   COPY posta_messaggio (id, creazione, ultima_modifica, oggetto, corpo, ultimo_tentativo, terminato, mittente_id, rispondi_a_id) FROM stdin;
    public       alfioemanuele    false    289   &�      L           0    0    posta_messaggio_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('posta_messaggio_id_seq', 7, true);
            public       alfioemanuele    false    288            �          0    621781    sangue_donatore 
   TABLE DATA               �   COPY sangue_donatore (id, creazione, ultima_modifica, gruppo_sanguigno, fattore_rh, fanotipo_rh, kell, codice_sit, persona_id, sede_sit_id) FROM stdin;
    public       alfioemanuele    false    291   C�      M           0    0    sangue_donatore_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('sangue_donatore_id_seq', 1, false);
            public       alfioemanuele    false    290            �          0    621791    sangue_donazione 
   TABLE DATA               z   COPY sangue_donazione (id, creazione, ultima_modifica, confermata, ritirata, tipo, data, persona_id, sede_id) FROM stdin;
    public       alfioemanuele    false    293   `�      N           0    0    sangue_donazione_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('sangue_donazione_id_seq', 1, false);
            public       alfioemanuele    false    292            �          0    621799    sangue_merito 
   TABLE DATA               _   COPY sangue_merito (id, creazione, ultima_modifica, donazione, merito, persona_id) FROM stdin;
    public       alfioemanuele    false    295   }�      O           0    0    sangue_merito_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('sangue_merito_id_seq', 1, false);
            public       alfioemanuele    false    294            �          0    621807    sangue_sede 
   TABLE DATA               C   COPY sangue_sede (id, citta, provincia, regione, nome) FROM stdin;
    public       alfioemanuele    false    297   ��      P           0    0    sangue_sede_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('sangue_sede_id_seq', 1, false);
            public       alfioemanuele    false    296            �          0    621898    social_commento 
   TABLE DATA               t   COPY social_commento (id, creazione, ultima_modifica, commento, oggetto_id, autore_id, oggetto_tipo_id) FROM stdin;
    public       alfioemanuele    false    302   ��      Q           0    0    social_commento_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('social_commento_id_seq', 1, false);
            public       alfioemanuele    false    301            �          0    621910    social_giudizio 
   TABLE DATA               t   COPY social_giudizio (id, creazione, ultima_modifica, positivo, oggetto_id, autore_id, oggetto_tipo_id) FROM stdin;
    public       alfioemanuele    false    304   ��      R           0    0    social_giudizio_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('social_giudizio_id_seq', 1, false);
            public       alfioemanuele    false    303            }          0    618776    spatial_ref_sys 
   TABLE DATA               "   COPY spatial_ref_sys  FROM stdin;
    public       alfioemanuele    false    183   ��      \          0    619879    thumbnail_kvstore 
   TABLE DATA               0   COPY thumbnail_kvstore (key, value) FROM stdin;
    public       alfioemanuele    false    203   �      �          0    621962    ufficio_soci_quota 
   TABLE DATA                 COPY ufficio_soci_quota (id, creazione, ultima_modifica, progressivo, anno, data_versamento, data_annullamento, stato, tipo, importo, importo_extra, causale, causale_extra, annullato_da_id, appartenenza_id, persona_id, registrato_da_id, sede_id, vecchio_id) FROM stdin;
    public       alfioemanuele    false    306   +�      S           0    0    ufficio_soci_quota_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('ufficio_soci_quota_id_seq', 1, false);
            public       alfioemanuele    false    305            �          0    621973    ufficio_soci_tesseramento 
   TABLE DATA               �   COPY ufficio_soci_tesseramento (id, creazione, ultima_modifica, stato, anno, inizio, quota_attivo, quota_ordinario, quota_benemerito, quota_aspirante, quota_sostenitore) FROM stdin;
    public       alfioemanuele    false    308   H�      T           0    0     ufficio_soci_tesseramento_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('ufficio_soci_tesseramento_id_seq', 1, false);
            public       alfioemanuele    false    307            �          0    621983    ufficio_soci_tesserino 
   TABLE DATA                 COPY ufficio_soci_tesserino (id, creazione, ultima_modifica, tipo_richiesta, stato_richiesta, motivo_richiesta, motivo_rifiutato, stato_emissione, valido, codice, data_conferma, data_riconsegna, confermato_da_id, emesso_da_id, persona_id, richiesto_da_id, riconsegnato_a_id) FROM stdin;
    public       alfioemanuele    false    310   e�      U           0    0    ufficio_soci_tesserino_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('ufficio_soci_tesserino_id_seq', 1, false);
            public       alfioemanuele    false    309            �          0    622119    veicoli_autoparco 
   TABLE DATA               w   COPY veicoli_autoparco (id, creazione, ultima_modifica, estensione, nome, telefono, locazione_id, sede_id) FROM stdin;
    public       alfioemanuele    false    312   ��      V           0    0    veicoli_autoparco_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('veicoli_autoparco_id_seq', 1, false);
            public       alfioemanuele    false    311            �          0    622127    veicoli_collocazione 
   TABLE DATA               }   COPY veicoli_collocazione (id, creazione, ultima_modifica, inizio, fine, autoparco_id, creato_da_id, veicolo_id) FROM stdin;
    public       alfioemanuele    false    314   ��      W           0    0    veicoli_collocazione_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('veicoli_collocazione_id_seq', 1, false);
            public       alfioemanuele    false    313            �          0    622135    veicoli_fermotecnico 
   TABLE DATA               w   COPY veicoli_fermotecnico (id, creazione, ultima_modifica, inizio, fine, motivo, creato_da_id, veicolo_id) FROM stdin;
    public       alfioemanuele    false    316   ��      X           0    0    veicoli_fermotecnico_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('veicoli_fermotecnico_id_seq', 1, false);
            public       alfioemanuele    false    315            �          0    622146    veicoli_manutenzione 
   TABLE DATA               �   COPY veicoli_manutenzione (id, creazione, ultima_modifica, tipo, data, descrizione, km, manutentore, numero_fattura, costo, creato_da_id, veicolo_id) FROM stdin;
    public       alfioemanuele    false    318   ��      Y           0    0    veicoli_manutenzione_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('veicoli_manutenzione_id_seq', 1, false);
            public       alfioemanuele    false    317            �          0    622159    veicoli_rifornimento 
   TABLE DATA               �   COPY veicoli_rifornimento (id, creazione, ultima_modifica, data, contachilometri, costo, consumo_carburante, presso, contalitri, ricevuta, veicolo_id, creato_da_id) FROM stdin;
    public       alfioemanuele    false    320   ��      Z           0    0    veicoli_rifornimento_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('veicoli_rifornimento_id_seq', 1, false);
            public       alfioemanuele    false    319            �          0    622168    veicoli_segnalazione 
   TABLE DATA               |   COPY veicoli_segnalazione (id, creazione, ultima_modifica, descrizione, autore_id, manutenzione_id, veicolo_id) FROM stdin;
    public       alfioemanuele    false    322   �      [           0    0    veicoli_segnalazione_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('veicoli_segnalazione_id_seq', 1, false);
            public       alfioemanuele    false    321            �          0    622179    veicoli_veicolo 
   TABLE DATA               K  COPY veicoli_veicolo (id, creazione, ultima_modifica, stato, libretto, targa, prima_immatricolazione, proprietario_cognome, proprietario_nome, proprietario_indirizzo, pneumatici_anteriori, pneumatici_posteriori, pneumatici_alt_anteriori, pneumatici_alt_posteriori, cambio, lunghezza, larghezza, sbalzo, tara, marca, modello, telaio, massa_max, data_immatricolazione, categoria, destinazione, carrozzeria, omologazione, num_assi, rimorchio_frenato, cilindrata, potenza_massima, alimentazione, posti, regime, card_rifornimento, selettiva_radio, telepass, intervallo_revisione) FROM stdin;
    public       alfioemanuele    false    324   0�      \           0    0    veicoli_veicolo_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('veicoli_veicolo_id_seq', 1, false);
            public       alfioemanuele    false    323                       2606    619960    anagrafica_appartenenza_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY anagrafica_appartenenza
    ADD CONSTRAINT anagrafica_appartenenza_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.anagrafica_appartenenza DROP CONSTRAINT anagrafica_appartenenza_pkey;
       public         alfioemanuele    false    213    213            &           2606    619969    anagrafica_delega_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY anagrafica_delega
    ADD CONSTRAINT anagrafica_delega_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.anagrafica_delega DROP CONSTRAINT anagrafica_delega_pkey;
       public         alfioemanuele    false    215    215            0           2606    619980    anagrafica_dimissione_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY anagrafica_dimissione
    ADD CONSTRAINT anagrafica_dimissione_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.anagrafica_dimissione DROP CONSTRAINT anagrafica_dimissione_pkey;
       public         alfioemanuele    false    217    217            6           2606    619988    anagrafica_documento_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY anagrafica_documento
    ADD CONSTRAINT anagrafica_documento_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.anagrafica_documento DROP CONSTRAINT anagrafica_documento_pkey;
       public         alfioemanuele    false    219    219            A           2606    619999    anagrafica_estensione_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY anagrafica_estensione
    ADD CONSTRAINT anagrafica_estensione_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.anagrafica_estensione DROP CONSTRAINT anagrafica_estensione_pkey;
       public         alfioemanuele    false    221    221            H           2606    620007    anagrafica_fototessera_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY anagrafica_fototessera
    ADD CONSTRAINT anagrafica_fototessera_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.anagrafica_fototessera DROP CONSTRAINT anagrafica_fototessera_pkey;
       public         alfioemanuele    false    223    223            S           2606    620020 %   anagrafica_persona_codice_fiscale_key 
   CONSTRAINT     v   ALTER TABLE ONLY anagrafica_persona
    ADD CONSTRAINT anagrafica_persona_codice_fiscale_key UNIQUE (codice_fiscale);
 b   ALTER TABLE ONLY public.anagrafica_persona DROP CONSTRAINT anagrafica_persona_codice_fiscale_key;
       public         alfioemanuele    false    225    225            a           2606    620018    anagrafica_persona_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY anagrafica_persona
    ADD CONSTRAINT anagrafica_persona_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.anagrafica_persona DROP CONSTRAINT anagrafica_persona_pkey;
       public         alfioemanuele    false    225    225            k           2606    620040 )   anagrafica_provvedimentodisciplinare_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY anagrafica_provvedimentodisciplinare
    ADD CONSTRAINT anagrafica_provvedimentodisciplinare_pkey PRIMARY KEY (id);
 x   ALTER TABLE ONLY public.anagrafica_provvedimentodisciplinare DROP CONSTRAINT anagrafica_provvedimentodisciplinare_pkey;
       public         alfioemanuele    false    227    227            w           2606    620048    anagrafica_riserva_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY anagrafica_riserva
    ADD CONSTRAINT anagrafica_riserva_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.anagrafica_riserva DROP CONSTRAINT anagrafica_riserva_pkey;
       public         alfioemanuele    false    229    229            �           2606    620060    anagrafica_sede_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY anagrafica_sede
    ADD CONSTRAINT anagrafica_sede_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.anagrafica_sede DROP CONSTRAINT anagrafica_sede_pkey;
       public         alfioemanuele    false    231    231            �           2606    620068    anagrafica_telefono_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY anagrafica_telefono
    ADD CONSTRAINT anagrafica_telefono_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.anagrafica_telefono DROP CONSTRAINT anagrafica_telefono_pkey;
       public         alfioemanuele    false    233    233            �           2606    620079    anagrafica_trasferimento_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY anagrafica_trasferimento
    ADD CONSTRAINT anagrafica_trasferimento_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.anagrafica_trasferimento DROP CONSTRAINT anagrafica_trasferimento_pkey;
       public         alfioemanuele    false    235    235                       2606    621087    attivita_area_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY attivita_area
    ADD CONSTRAINT attivita_area_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.attivita_area DROP CONSTRAINT attivita_area_pkey;
       public         alfioemanuele    false    255    255                       2606    621098    attivita_attivita_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY attivita_attivita
    ADD CONSTRAINT attivita_attivita_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.attivita_attivita DROP CONSTRAINT attivita_attivita_pkey;
       public         alfioemanuele    false    257    257            )           2606    621106    attivita_partecipazione_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY attivita_partecipazione
    ADD CONSTRAINT attivita_partecipazione_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.attivita_partecipazione DROP CONSTRAINT attivita_partecipazione_pkey;
       public         alfioemanuele    false    259    259            :           2606    621114    attivita_turno_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY attivita_turno
    ADD CONSTRAINT attivita_turno_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.attivita_turno DROP CONSTRAINT attivita_turno_pkey;
       public         alfioemanuele    false    261    261            �           2606    620203    autenticazione_utenza_email_key 
   CONSTRAINT     j   ALTER TABLE ONLY autenticazione_utenza
    ADD CONSTRAINT autenticazione_utenza_email_key UNIQUE (email);
 _   ALTER TABLE ONLY public.autenticazione_utenza DROP CONSTRAINT autenticazione_utenza_email_key;
       public         alfioemanuele    false    237    237            �           2606    620213 !   autenticazione_utenza_groups_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY autenticazione_utenza_groups
    ADD CONSTRAINT autenticazione_utenza_groups_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.autenticazione_utenza_groups DROP CONSTRAINT autenticazione_utenza_groups_pkey;
       public         alfioemanuele    false    239    239            �           2606    620241 4   autenticazione_utenza_groups_utenza_id_db0a7f00_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_groups
    ADD CONSTRAINT autenticazione_utenza_groups_utenza_id_db0a7f00_uniq UNIQUE (utenza_id, group_id);
 {   ALTER TABLE ONLY public.autenticazione_utenza_groups DROP CONSTRAINT autenticazione_utenza_groups_utenza_id_db0a7f00_uniq;
       public         alfioemanuele    false    239    239    239            �           2606    620205 $   autenticazione_utenza_persona_id_key 
   CONSTRAINT     t   ALTER TABLE ONLY autenticazione_utenza
    ADD CONSTRAINT autenticazione_utenza_persona_id_key UNIQUE (persona_id);
 d   ALTER TABLE ONLY public.autenticazione_utenza DROP CONSTRAINT autenticazione_utenza_persona_id_key;
       public         alfioemanuele    false    237    237            �           2606    620201    autenticazione_utenza_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY autenticazione_utenza
    ADD CONSTRAINT autenticazione_utenza_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.autenticazione_utenza DROP CONSTRAINT autenticazione_utenza_pkey;
       public         alfioemanuele    false    237    237            �           2606    620221 +   autenticazione_utenza_user_permissions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_user_permissions
    ADD CONSTRAINT autenticazione_utenza_user_permissions_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.autenticazione_utenza_user_permissions DROP CONSTRAINT autenticazione_utenza_user_permissions_pkey;
       public         alfioemanuele    false    241    241            �           2606    620255 >   autenticazione_utenza_user_permissions_utenza_id_c5ee131a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_user_permissions
    ADD CONSTRAINT autenticazione_utenza_user_permissions_utenza_id_c5ee131a_uniq UNIQUE (utenza_id, permission_id);
 �   ALTER TABLE ONLY public.autenticazione_utenza_user_permissions DROP CONSTRAINT autenticazione_utenza_user_permissions_utenza_id_c5ee131a_uniq;
       public         alfioemanuele    false    241    241    241            �           2606    619921    auth_group_name_key 
   CONSTRAINT     R   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public         alfioemanuele    false    209    209            �           2606    619950 -   auth_group_permissions_group_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 n   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq;
       public         alfioemanuele    false    211    211    211            �           2606    619929    auth_group_permissions_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public         alfioemanuele    false    211    211            �           2606    619919    auth_group_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public         alfioemanuele    false    209    209            �           2606    619936 -   auth_permission_content_type_id_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);
 g   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_01ab375a_uniq;
       public         alfioemanuele    false    207    207    207            �           2606    619911    auth_permission_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public         alfioemanuele    false    207    207            �           2606    620291    base_allegato_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY base_allegato
    ADD CONSTRAINT base_allegato_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.base_allegato DROP CONSTRAINT base_allegato_pkey;
       public         alfioemanuele    false    245    245            �           2606    620305    base_autorizzazione_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY base_autorizzazione
    ADD CONSTRAINT base_autorizzazione_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.base_autorizzazione DROP CONSTRAINT base_autorizzazione_pkey;
       public         alfioemanuele    false    247    247            �           2606    620318    base_locazione_indirizzo_key 
   CONSTRAINT     d   ALTER TABLE ONLY base_locazione
    ADD CONSTRAINT base_locazione_indirizzo_key UNIQUE (indirizzo);
 U   ALTER TABLE ONLY public.base_locazione DROP CONSTRAINT base_locazione_indirizzo_key;
       public         alfioemanuele    false    249    249            �           2606    620316    base_locazione_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY base_locazione
    ADD CONSTRAINT base_locazione_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.base_locazione DROP CONSTRAINT base_locazione_pkey;
       public         alfioemanuele    false    249    249            �           2606    620330    base_log_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY base_log
    ADD CONSTRAINT base_log_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.base_log DROP CONSTRAINT base_log_pkey;
       public         alfioemanuele    false    251    251            �           2606    620732    base_token_codice_key 
   CONSTRAINT     V   ALTER TABLE ONLY base_token
    ADD CONSTRAINT base_token_codice_key UNIQUE (codice);
 J   ALTER TABLE ONLY public.base_token DROP CONSTRAINT base_token_codice_key;
       public         alfioemanuele    false    253    253            �           2606    620338    base_token_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY base_token
    ADD CONSTRAINT base_token_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.base_token DROP CONSTRAINT base_token_pkey;
       public         alfioemanuele    false    253    253            A           2606    621314 $   centrale_operativa_reperibilita_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY centrale_operativa_reperibilita
    ADD CONSTRAINT centrale_operativa_reperibilita_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.centrale_operativa_reperibilita DROP CONSTRAINT centrale_operativa_reperibilita_pkey;
       public         alfioemanuele    false    263    263            J           2606    621322    centrale_operativa_turno_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY centrale_operativa_turno
    ADD CONSTRAINT centrale_operativa_turno_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.centrale_operativa_turno DROP CONSTRAINT centrale_operativa_turno_pkey;
       public         alfioemanuele    false    265    265            P           2606    621367    curriculum_titolo_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY curriculum_titolo
    ADD CONSTRAINT curriculum_titolo_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.curriculum_titolo DROP CONSTRAINT curriculum_titolo_pkey;
       public         alfioemanuele    false    267    267            ^           2606    621378    curriculum_titolopersonale_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY curriculum_titolopersonale
    ADD CONSTRAINT curriculum_titolopersonale_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.curriculum_titolopersonale DROP CONSTRAINT curriculum_titolopersonale_pkey;
       public         alfioemanuele    false    269    269            �           2606    620269    django_admin_log_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public         alfioemanuele    false    243    243            �           2606    619903 +   django_content_type_app_label_76bd3d3b_uniq 
   CONSTRAINT        ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);
 i   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_76bd3d3b_uniq;
       public         alfioemanuele    false    205    205    205            �           2606    619901    django_content_type_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public         alfioemanuele    false    205    205            h           2606    621426    django_cron_cronjoblog_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY django_cron_cronjoblog
    ADD CONSTRAINT django_cron_cronjoblog_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.django_cron_cronjoblog DROP CONSTRAINT django_cron_cronjoblog_pkey;
       public         alfioemanuele    false    271    271            �           2606    619862    django_migrations_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public         alfioemanuele    false    198    198            �           2606    621882    django_session_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public         alfioemanuele    false    298    298            �           2606    621894     django_site_domain_a2e37b91_uniq 
   CONSTRAINT     b   ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);
 V   ALTER TABLE ONLY public.django_site DROP CONSTRAINT django_site_domain_a2e37b91_uniq;
       public         alfioemanuele    false    300    300            �           2606    621892    django_site_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.django_site DROP CONSTRAINT django_site_pkey;
       public         alfioemanuele    false    300    300            m           2606    621444 #   formazione_aspirante_persona_id_key 
   CONSTRAINT     r   ALTER TABLE ONLY formazione_aspirante
    ADD CONSTRAINT formazione_aspirante_persona_id_key UNIQUE (persona_id);
 b   ALTER TABLE ONLY public.formazione_aspirante DROP CONSTRAINT formazione_aspirante_persona_id_key;
       public         alfioemanuele    false    273    273            o           2606    621442    formazione_aspirante_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY formazione_aspirante
    ADD CONSTRAINT formazione_aspirante_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.formazione_aspirante DROP CONSTRAINT formazione_aspirante_pkey;
       public         alfioemanuele    false    273    273            w           2606    621452     formazione_assenzacorsobase_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY formazione_assenzacorsobase
    ADD CONSTRAINT formazione_assenzacorsobase_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.formazione_assenzacorsobase DROP CONSTRAINT formazione_assenzacorsobase_pkey;
       public         alfioemanuele    false    275    275            �           2606    621463    formazione_corsobase_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY formazione_corsobase
    ADD CONSTRAINT formazione_corsobase_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.formazione_corsobase DROP CONSTRAINT formazione_corsobase_pkey;
       public         alfioemanuele    false    277    277            �           2606    621471     formazione_lezionecorsobase_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY formazione_lezionecorsobase
    ADD CONSTRAINT formazione_lezionecorsobase_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.formazione_lezionecorsobase DROP CONSTRAINT formazione_lezionecorsobase_pkey;
       public         alfioemanuele    false    279    279            �           2606    621482 '   formazione_partecipazionecorsobase_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY formazione_partecipazionecorsobase
    ADD CONSTRAINT formazione_partecipazionecorsobase_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.formazione_partecipazionecorsobase DROP CONSTRAINT formazione_partecipazionecorsobase_pkey;
       public         alfioemanuele    false    281    281            �           2606    621646    gruppi_appartenenza_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY gruppi_appartenenza
    ADD CONSTRAINT gruppi_appartenenza_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.gruppi_appartenenza DROP CONSTRAINT gruppi_appartenenza_pkey;
       public         alfioemanuele    false    283    283            �           2606    621654    gruppi_gruppo_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY gruppi_gruppo
    ADD CONSTRAINT gruppi_gruppo_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.gruppi_gruppo DROP CONSTRAINT gruppi_gruppo_pkey;
       public         alfioemanuele    false    285    285            �           2606    619878    patenti_elemento_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY patenti_elemento
    ADD CONSTRAINT patenti_elemento_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.patenti_elemento DROP CONSTRAINT patenti_elemento_pkey;
       public         alfioemanuele    false    202    202            �           2606    619870    patenti_patente_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY patenti_patente
    ADD CONSTRAINT patenti_patente_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.patenti_patente DROP CONSTRAINT patenti_patente_pkey;
       public         alfioemanuele    false    200    200            �           2606    621724    posta_destinatario_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY posta_destinatario
    ADD CONSTRAINT posta_destinatario_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.posta_destinatario DROP CONSTRAINT posta_destinatario_pkey;
       public         alfioemanuele    false    287    287            �           2606    621735    posta_messaggio_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY posta_messaggio
    ADD CONSTRAINT posta_messaggio_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.posta_messaggio DROP CONSTRAINT posta_messaggio_pkey;
       public         alfioemanuele    false    289    289            �           2606    621788    sangue_donatore_persona_id_key 
   CONSTRAINT     h   ALTER TABLE ONLY sangue_donatore
    ADD CONSTRAINT sangue_donatore_persona_id_key UNIQUE (persona_id);
 X   ALTER TABLE ONLY public.sangue_donatore DROP CONSTRAINT sangue_donatore_persona_id_key;
       public         alfioemanuele    false    291    291            �           2606    621786    sangue_donatore_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY sangue_donatore
    ADD CONSTRAINT sangue_donatore_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.sangue_donatore DROP CONSTRAINT sangue_donatore_pkey;
       public         alfioemanuele    false    291    291            �           2606    621796    sangue_donazione_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY sangue_donazione
    ADD CONSTRAINT sangue_donazione_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.sangue_donazione DROP CONSTRAINT sangue_donazione_pkey;
       public         alfioemanuele    false    293    293            �           2606    621804    sangue_merito_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY sangue_merito
    ADD CONSTRAINT sangue_merito_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.sangue_merito DROP CONSTRAINT sangue_merito_pkey;
       public         alfioemanuele    false    295    295            �           2606    621812    sangue_sede_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY sangue_sede
    ADD CONSTRAINT sangue_sede_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.sangue_sede DROP CONSTRAINT sangue_sede_pkey;
       public         alfioemanuele    false    297    297            �           2606    621907    social_commento_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY social_commento
    ADD CONSTRAINT social_commento_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.social_commento DROP CONSTRAINT social_commento_pkey;
       public         alfioemanuele    false    302    302            �           2606    621916    social_giudizio_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY social_giudizio
    ADD CONSTRAINT social_giudizio_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.social_giudizio DROP CONSTRAINT social_giudizio_pkey;
       public         alfioemanuele    false    304    304            �           2606    619886    thumbnail_kvstore_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY thumbnail_kvstore
    ADD CONSTRAINT thumbnail_kvstore_pkey PRIMARY KEY (key);
 R   ALTER TABLE ONLY public.thumbnail_kvstore DROP CONSTRAINT thumbnail_kvstore_pkey;
       public         alfioemanuele    false    203    203                       2606    621970    ufficio_soci_quota_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci_quota_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci_quota_pkey;
       public         alfioemanuele    false    306    306                       2606    621995 ,   ufficio_soci_quota_progressivo_4dd12648_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci_quota_progressivo_4dd12648_uniq UNIQUE (progressivo, anno, sede_id);
 i   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci_quota_progressivo_4dd12648_uniq;
       public         alfioemanuele    false    306    306    306    306                       2606    621980 "   ufficio_soci_tesseramento_anno_key 
   CONSTRAINT     p   ALTER TABLE ONLY ufficio_soci_tesseramento
    ADD CONSTRAINT ufficio_soci_tesseramento_anno_key UNIQUE (anno);
 f   ALTER TABLE ONLY public.ufficio_soci_tesseramento DROP CONSTRAINT ufficio_soci_tesseramento_anno_key;
       public         alfioemanuele    false    308    308                       2606    621978    ufficio_soci_tesseramento_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY ufficio_soci_tesseramento
    ADD CONSTRAINT ufficio_soci_tesseramento_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.ufficio_soci_tesseramento DROP CONSTRAINT ufficio_soci_tesseramento_pkey;
       public         alfioemanuele    false    308    308                       2606    621993 !   ufficio_soci_tesserino_codice_key 
   CONSTRAINT     n   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci_tesserino_codice_key UNIQUE (codice);
 b   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci_tesserino_codice_key;
       public         alfioemanuele    false    310    310                       2606    621991    ufficio_soci_tesserino_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci_tesserino_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci_tesserino_pkey;
       public         alfioemanuele    false    310    310            +           2606    622124    veicoli_autoparco_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY veicoli_autoparco
    ADD CONSTRAINT veicoli_autoparco_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.veicoli_autoparco DROP CONSTRAINT veicoli_autoparco_pkey;
       public         alfioemanuele    false    312    312            4           2606    622132    veicoli_collocazione_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY veicoli_collocazione
    ADD CONSTRAINT veicoli_collocazione_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.veicoli_collocazione DROP CONSTRAINT veicoli_collocazione_pkey;
       public         alfioemanuele    false    314    314            <           2606    622143    veicoli_fermotecnico_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY veicoli_fermotecnico
    ADD CONSTRAINT veicoli_fermotecnico_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.veicoli_fermotecnico DROP CONSTRAINT veicoli_fermotecnico_pkey;
       public         alfioemanuele    false    316    316            D           2606    622156    veicoli_manutenzione_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY veicoli_manutenzione
    ADD CONSTRAINT veicoli_manutenzione_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.veicoli_manutenzione DROP CONSTRAINT veicoli_manutenzione_pkey;
       public         alfioemanuele    false    318    318            Q           2606    622165    veicoli_rifornimento_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY veicoli_rifornimento
    ADD CONSTRAINT veicoli_rifornimento_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.veicoli_rifornimento DROP CONSTRAINT veicoli_rifornimento_pkey;
       public         alfioemanuele    false    320    320            Y           2606    622176    veicoli_segnalazione_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY veicoli_segnalazione
    ADD CONSTRAINT veicoli_segnalazione_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.veicoli_segnalazione DROP CONSTRAINT veicoli_segnalazione_pkey;
       public         alfioemanuele    false    322    322            d           2606    622195    veicoli_veicolo_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY veicoli_veicolo
    ADD CONSTRAINT veicoli_veicolo_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.veicoli_veicolo DROP CONSTRAINT veicoli_veicolo_pkey;
       public         alfioemanuele    false    324    324            h           2606    622197    veicoli_veicolo_telaio_key 
   CONSTRAINT     `   ALTER TABLE ONLY veicoli_veicolo
    ADD CONSTRAINT veicoli_veicolo_telaio_key UNIQUE (telaio);
 T   ALTER TABLE ONLY public.veicoli_veicolo DROP CONSTRAINT veicoli_veicolo_telaio_key;
       public         alfioemanuele    false    324    324            �           1259    620522     anagrafica_appartenenza_0526208f    INDEX     h   CREATE INDEX anagrafica_appartenenza_0526208f ON anagrafica_appartenenza USING btree (vecchia_sede_id);
 4   DROP INDEX public.anagrafica_appartenenza_0526208f;
       public         alfioemanuele    false    213            �           1259    620516     anagrafica_appartenenza_0687f864    INDEX     `   CREATE INDEX anagrafica_appartenenza_0687f864 ON anagrafica_appartenenza USING btree (sede_id);
 4   DROP INDEX public.anagrafica_appartenenza_0687f864;
       public         alfioemanuele    false    213            �           1259    620510     anagrafica_appartenenza_3554fea7    INDEX     f   CREATE INDEX anagrafica_appartenenza_3554fea7 ON anagrafica_appartenenza USING btree (precedente_id);
 4   DROP INDEX public.anagrafica_appartenenza_3554fea7;
       public         alfioemanuele    false    213            �           1259    620080     anagrafica_appartenenza_36063dc9    INDEX     b   CREATE INDEX anagrafica_appartenenza_36063dc9 ON anagrafica_appartenenza USING btree (creazione);
 4   DROP INDEX public.anagrafica_appartenenza_36063dc9;
       public         alfioemanuele    false    213            �           1259    620084     anagrafica_appartenenza_43662d06    INDEX     c   CREATE INDEX anagrafica_appartenenza_43662d06 ON anagrafica_appartenenza USING btree (confermata);
 4   DROP INDEX public.anagrafica_appartenenza_43662d06;
       public         alfioemanuele    false    213            �           1259    620085     anagrafica_appartenenza_4a9487af    INDEX     a   CREATE INDEX anagrafica_appartenenza_4a9487af ON anagrafica_appartenenza USING btree (ritirata);
 4   DROP INDEX public.anagrafica_appartenenza_4a9487af;
       public         alfioemanuele    false    213            �           1259    620081     anagrafica_appartenenza_69bd2e5f    INDEX     h   CREATE INDEX anagrafica_appartenenza_69bd2e5f ON anagrafica_appartenenza USING btree (ultima_modifica);
 4   DROP INDEX public.anagrafica_appartenenza_69bd2e5f;
       public         alfioemanuele    false    213            �           1259    620082     anagrafica_appartenenza_7df656af    INDEX     _   CREATE INDEX anagrafica_appartenenza_7df656af ON anagrafica_appartenenza USING btree (inizio);
 4   DROP INDEX public.anagrafica_appartenenza_7df656af;
       public         alfioemanuele    false    213            �           1259    620086     anagrafica_appartenenza_9364fb87    INDEX     _   CREATE INDEX anagrafica_appartenenza_9364fb87 ON anagrafica_appartenenza USING btree (membro);
 4   DROP INDEX public.anagrafica_appartenenza_9364fb87;
       public         alfioemanuele    false    213            �           1259    620973 /   anagrafica_appartenenza_confermata_6dc30a80_idx    INDEX     ~   CREATE INDEX anagrafica_appartenenza_confermata_6dc30a80_idx ON anagrafica_appartenenza USING btree (confermata, persona_id);
 C   DROP INDEX public.anagrafica_appartenenza_confermata_6dc30a80_idx;
       public         alfioemanuele    false    213    213                        1259    620504     anagrafica_appartenenza_e8589820    INDEX     c   CREATE INDEX anagrafica_appartenenza_e8589820 ON anagrafica_appartenenza USING btree (persona_id);
 4   DROP INDEX public.anagrafica_appartenenza_e8589820;
       public         alfioemanuele    false    213                       1259    620087     anagrafica_appartenenza_ed4272b5    INDEX     e   CREATE INDEX anagrafica_appartenenza_ed4272b5 ON anagrafica_appartenenza USING btree (terminazione);
 4   DROP INDEX public.anagrafica_appartenenza_ed4272b5;
       public         alfioemanuele    false    213                       1259    620083     anagrafica_appartenenza_fff25994    INDEX     ]   CREATE INDEX anagrafica_appartenenza_fff25994 ON anagrafica_appartenenza USING btree (fine);
 4   DROP INDEX public.anagrafica_appartenenza_fff25994;
       public         alfioemanuele    false    213                       1259    621078 '   anagrafica_appartenenza_id_c708bd84_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_id_c708bd84_idx ON anagrafica_appartenenza USING btree (id, sede_id, membro, inizio, fine);
 ;   DROP INDEX public.anagrafica_appartenenza_id_c708bd84_idx;
       public         alfioemanuele    false    213    213    213    213    213                       1259    620946 +   anagrafica_appartenenza_inizio_b1953360_idx    INDEX     p   CREATE INDEX anagrafica_appartenenza_inizio_b1953360_idx ON anagrafica_appartenenza USING btree (inizio, fine);
 ?   DROP INDEX public.anagrafica_appartenenza_inizio_b1953360_idx;
       public         alfioemanuele    false    213    213                       1259    620971 +   anagrafica_appartenenza_membro_8432f1cd_idx    INDEX     v   CREATE INDEX anagrafica_appartenenza_membro_8432f1cd_idx ON anagrafica_appartenenza USING btree (membro, confermata);
 ?   DROP INDEX public.anagrafica_appartenenza_membro_8432f1cd_idx;
       public         alfioemanuele    false    213    213                       1259    621077 +   anagrafica_appartenenza_membro_996b60da_idx    INDEX        CREATE INDEX anagrafica_appartenenza_membro_996b60da_idx ON anagrafica_appartenenza USING btree (membro, confermata, sede_id);
 ?   DROP INDEX public.anagrafica_appartenenza_membro_996b60da_idx;
       public         alfioemanuele    false    213    213    213                       1259    620088 ,   anagrafica_appartenenza_membro_9bb43ea0_like    INDEX        CREATE INDEX anagrafica_appartenenza_membro_9bb43ea0_like ON anagrafica_appartenenza USING btree (membro varchar_pattern_ops);
 @   DROP INDEX public.anagrafica_appartenenza_membro_9bb43ea0_like;
       public         alfioemanuele    false    213                       1259    620972 +   anagrafica_appartenenza_membro_a33e6688_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_membro_a33e6688_idx ON anagrafica_appartenenza USING btree (membro, confermata, persona_id);
 ?   DROP INDEX public.anagrafica_appartenenza_membro_a33e6688_idx;
       public         alfioemanuele    false    213    213    213            	           1259    620974 +   anagrafica_appartenenza_membro_ab39a013_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_membro_ab39a013_idx ON anagrafica_appartenenza USING btree (membro, confermata, inizio, fine);
 ?   DROP INDEX public.anagrafica_appartenenza_membro_ab39a013_idx;
       public         alfioemanuele    false    213    213    213    213            
           1259    620976 /   anagrafica_appartenenza_persona_id_03960659_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_persona_id_03960659_idx ON anagrafica_appartenenza USING btree (persona_id, inizio, fine, membro);
 C   DROP INDEX public.anagrafica_appartenenza_persona_id_03960659_idx;
       public         alfioemanuele    false    213    213    213    213                       1259    620944 /   anagrafica_appartenenza_persona_id_2091c263_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_persona_id_2091c263_idx ON anagrafica_appartenenza USING btree (persona_id, inizio, fine);
 C   DROP INDEX public.anagrafica_appartenenza_persona_id_2091c263_idx;
       public         alfioemanuele    false    213    213    213                       1259    620947 /   anagrafica_appartenenza_persona_id_65a301f6_idx    INDEX     {   CREATE INDEX anagrafica_appartenenza_persona_id_65a301f6_idx ON anagrafica_appartenenza USING btree (persona_id, sede_id);
 C   DROP INDEX public.anagrafica_appartenenza_persona_id_65a301f6_idx;
       public         alfioemanuele    false    213    213                       1259    620975 /   anagrafica_appartenenza_persona_id_7cf4ad5e_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_persona_id_7cf4ad5e_idx ON anagrafica_appartenenza USING btree (persona_id, inizio, fine, membro, confermata);
 C   DROP INDEX public.anagrafica_appartenenza_persona_id_7cf4ad5e_idx;
       public         alfioemanuele    false    213    213    213    213    213                       1259    620945 ,   anagrafica_appartenenza_sede_id_2ae5876d_idx    INDEX     z   CREATE INDEX anagrafica_appartenenza_sede_id_2ae5876d_idx ON anagrafica_appartenenza USING btree (sede_id, inizio, fine);
 @   DROP INDEX public.anagrafica_appartenenza_sede_id_2ae5876d_idx;
       public         alfioemanuele    false    213    213    213                       1259    620948 ,   anagrafica_appartenenza_sede_id_c7c375fa_idx    INDEX     �   CREATE INDEX anagrafica_appartenenza_sede_id_c7c375fa_idx ON anagrafica_appartenenza USING btree (sede_id, membro, inizio, fine);
 @   DROP INDEX public.anagrafica_appartenenza_sede_id_c7c375fa_idx;
       public         alfioemanuele    false    213    213    213    213                       1259    620949 ,   anagrafica_appartenenza_sede_id_ecc36d22_idx    INDEX     t   CREATE INDEX anagrafica_appartenenza_sede_id_ecc36d22_idx ON anagrafica_appartenenza USING btree (sede_id, membro);
 @   DROP INDEX public.anagrafica_appartenenza_sede_id_ecc36d22_idx;
       public         alfioemanuele    false    213    213                       1259    620089 2   anagrafica_appartenenza_terminazione_428ebe50_like    INDEX     �   CREATE INDEX anagrafica_appartenenza_terminazione_428ebe50_like ON anagrafica_appartenenza USING btree (terminazione varchar_pattern_ops);
 F   DROP INDEX public.anagrafica_appartenenza_terminazione_428ebe50_like;
       public         alfioemanuele    false    213                       1259    620090    anagrafica_delega_36063dc9    INDEX     V   CREATE INDEX anagrafica_delega_36063dc9 ON anagrafica_delega USING btree (creazione);
 .   DROP INDEX public.anagrafica_delega_36063dc9;
       public         alfioemanuele    false    215                       1259    620094    anagrafica_delega_401281b0    INDEX     Q   CREATE INDEX anagrafica_delega_401281b0 ON anagrafica_delega USING btree (tipo);
 .   DROP INDEX public.anagrafica_delega_401281b0;
       public         alfioemanuele    false    215                       1259    620486    anagrafica_delega_515fa17e    INDEX     Z   CREATE INDEX anagrafica_delega_515fa17e ON anagrafica_delega USING btree (firmatario_id);
 .   DROP INDEX public.anagrafica_delega_515fa17e;
       public         alfioemanuele    false    215                       1259    620091    anagrafica_delega_69bd2e5f    INDEX     \   CREATE INDEX anagrafica_delega_69bd2e5f ON anagrafica_delega USING btree (ultima_modifica);
 .   DROP INDEX public.anagrafica_delega_69bd2e5f;
       public         alfioemanuele    false    215                       1259    620092    anagrafica_delega_7df656af    INDEX     S   CREATE INDEX anagrafica_delega_7df656af ON anagrafica_delega USING btree (inizio);
 .   DROP INDEX public.anagrafica_delega_7df656af;
       public         alfioemanuele    false    215                       1259    620095    anagrafica_delega_9c82ce86    INDEX     W   CREATE INDEX anagrafica_delega_9c82ce86 ON anagrafica_delega USING btree (oggetto_id);
 .   DROP INDEX public.anagrafica_delega_9c82ce86;
       public         alfioemanuele    false    215                       1259    620498    anagrafica_delega_e8589820    INDEX     W   CREATE INDEX anagrafica_delega_e8589820 ON anagrafica_delega USING btree (persona_id);
 .   DROP INDEX public.anagrafica_delega_e8589820;
       public         alfioemanuele    false    215                       1259    620492    anagrafica_delega_fe2a0979    INDEX     \   CREATE INDEX anagrafica_delega_fe2a0979 ON anagrafica_delega USING btree (oggetto_tipo_id);
 .   DROP INDEX public.anagrafica_delega_fe2a0979;
       public         alfioemanuele    false    215                       1259    620093    anagrafica_delega_fff25994    INDEX     Q   CREATE INDEX anagrafica_delega_fff25994 ON anagrafica_delega USING btree (fine);
 .   DROP INDEX public.anagrafica_delega_fff25994;
       public         alfioemanuele    false    215                       1259    620952 %   anagrafica_delega_inizio_12d1cd58_idx    INDEX     d   CREATE INDEX anagrafica_delega_inizio_12d1cd58_idx ON anagrafica_delega USING btree (inizio, fine);
 9   DROP INDEX public.anagrafica_delega_inizio_12d1cd58_idx;
       public         alfioemanuele    false    215    215                       1259    620964 %   anagrafica_delega_inizio_85ba6481_idx    INDEX     �   CREATE INDEX anagrafica_delega_inizio_85ba6481_idx ON anagrafica_delega USING btree (inizio, fine, tipo, oggetto_id, oggetto_tipo_id);
 9   DROP INDEX public.anagrafica_delega_inizio_85ba6481_idx;
       public         alfioemanuele    false    215    215    215    215    215                       1259    620963 %   anagrafica_delega_inizio_9f1c70a8_idx    INDEX     j   CREATE INDEX anagrafica_delega_inizio_9f1c70a8_idx ON anagrafica_delega USING btree (inizio, fine, tipo);
 9   DROP INDEX public.anagrafica_delega_inizio_9f1c70a8_idx;
       public         alfioemanuele    false    215    215    215                        1259    620953 .   anagrafica_delega_oggetto_tipo_id_6bdb9373_idx    INDEX     |   CREATE INDEX anagrafica_delega_oggetto_tipo_id_6bdb9373_idx ON anagrafica_delega USING btree (oggetto_tipo_id, oggetto_id);
 B   DROP INDEX public.anagrafica_delega_oggetto_tipo_id_6bdb9373_idx;
       public         alfioemanuele    false    215    215            !           1259    620977 )   anagrafica_delega_persona_id_2cbc7c88_idx    INDEX     t   CREATE INDEX anagrafica_delega_persona_id_2cbc7c88_idx ON anagrafica_delega USING btree (persona_id, inizio, fine);
 =   DROP INDEX public.anagrafica_delega_persona_id_2cbc7c88_idx;
       public         alfioemanuele    false    215    215    215            "           1259    620961 )   anagrafica_delega_persona_id_504b3bbb_idx    INDEX     z   CREATE INDEX anagrafica_delega_persona_id_504b3bbb_idx ON anagrafica_delega USING btree (persona_id, inizio, fine, tipo);
 =   DROP INDEX public.anagrafica_delega_persona_id_504b3bbb_idx;
       public         alfioemanuele    false    215    215    215    215            #           1259    620951 )   anagrafica_delega_persona_id_98188654_idx    INDEX     l   CREATE INDEX anagrafica_delega_persona_id_98188654_idx ON anagrafica_delega USING btree (persona_id, tipo);
 =   DROP INDEX public.anagrafica_delega_persona_id_98188654_idx;
       public         alfioemanuele    false    215    215            $           1259    620962 )   anagrafica_delega_persona_id_ca68c76e_idx    INDEX     �   CREATE INDEX anagrafica_delega_persona_id_ca68c76e_idx ON anagrafica_delega USING btree (persona_id, inizio, fine, tipo, oggetto_id, oggetto_tipo_id);
 =   DROP INDEX public.anagrafica_delega_persona_id_ca68c76e_idx;
       public         alfioemanuele    false    215    215    215    215    215    215            '           1259    620950 #   anagrafica_delega_tipo_d237ebb0_idx    INDEX     w   CREATE INDEX anagrafica_delega_tipo_d237ebb0_idx ON anagrafica_delega USING btree (tipo, oggetto_tipo_id, oggetto_id);
 7   DROP INDEX public.anagrafica_delega_tipo_d237ebb0_idx;
       public         alfioemanuele    false    215    215    215            (           1259    620096 $   anagrafica_delega_tipo_f5abc5c5_like    INDEX     o   CREATE INDEX anagrafica_delega_tipo_f5abc5c5_like ON anagrafica_delega USING btree (tipo varchar_pattern_ops);
 8   DROP INDEX public.anagrafica_delega_tipo_f5abc5c5_like;
       public         alfioemanuele    false    215            )           1259    620480    anagrafica_dimissione_0687f864    INDEX     \   CREATE INDEX anagrafica_dimissione_0687f864 ON anagrafica_dimissione USING btree (sede_id);
 2   DROP INDEX public.anagrafica_dimissione_0687f864;
       public         alfioemanuele    false    217            *           1259    620599    anagrafica_dimissione_36063dc9    INDEX     ^   CREATE INDEX anagrafica_dimissione_36063dc9 ON anagrafica_dimissione USING btree (creazione);
 2   DROP INDEX public.anagrafica_dimissione_36063dc9;
       public         alfioemanuele    false    217            +           1259    620462    anagrafica_dimissione_530b0ac8    INDEX     d   CREATE INDEX anagrafica_dimissione_530b0ac8 ON anagrafica_dimissione USING btree (appartenenza_id);
 2   DROP INDEX public.anagrafica_dimissione_530b0ac8;
       public         alfioemanuele    false    217            ,           1259    620600    anagrafica_dimissione_69bd2e5f    INDEX     d   CREATE INDEX anagrafica_dimissione_69bd2e5f ON anagrafica_dimissione USING btree (ultima_modifica);
 2   DROP INDEX public.anagrafica_dimissione_69bd2e5f;
       public         alfioemanuele    false    217            -           1259    620474    anagrafica_dimissione_e3692faf    INDEX     c   CREATE INDEX anagrafica_dimissione_e3692faf ON anagrafica_dimissione USING btree (richiedente_id);
 2   DROP INDEX public.anagrafica_dimissione_e3692faf;
       public         alfioemanuele    false    217            .           1259    620468    anagrafica_dimissione_e8589820    INDEX     _   CREATE INDEX anagrafica_dimissione_e8589820 ON anagrafica_dimissione USING btree (persona_id);
 2   DROP INDEX public.anagrafica_dimissione_e8589820;
       public         alfioemanuele    false    217            1           1259    620099    anagrafica_documento_36063dc9    INDEX     \   CREATE INDEX anagrafica_documento_36063dc9 ON anagrafica_documento USING btree (creazione);
 1   DROP INDEX public.anagrafica_documento_36063dc9;
       public         alfioemanuele    false    219            2           1259    620101    anagrafica_documento_401281b0    INDEX     W   CREATE INDEX anagrafica_documento_401281b0 ON anagrafica_documento USING btree (tipo);
 1   DROP INDEX public.anagrafica_documento_401281b0;
       public         alfioemanuele    false    219            3           1259    620100    anagrafica_documento_69bd2e5f    INDEX     b   CREATE INDEX anagrafica_documento_69bd2e5f ON anagrafica_documento USING btree (ultima_modifica);
 1   DROP INDEX public.anagrafica_documento_69bd2e5f;
       public         alfioemanuele    false    219            4           1259    620456    anagrafica_documento_e8589820    INDEX     ]   CREATE INDEX anagrafica_documento_e8589820 ON anagrafica_documento USING btree (persona_id);
 1   DROP INDEX public.anagrafica_documento_e8589820;
       public         alfioemanuele    false    219            7           1259    620102 '   anagrafica_documento_tipo_643d2179_like    INDEX     u   CREATE INDEX anagrafica_documento_tipo_643d2179_like ON anagrafica_documento USING btree (tipo varchar_pattern_ops);
 ;   DROP INDEX public.anagrafica_documento_tipo_643d2179_like;
       public         alfioemanuele    false    219            8           1259    620103    anagrafica_estensione_36063dc9    INDEX     ^   CREATE INDEX anagrafica_estensione_36063dc9 ON anagrafica_estensione USING btree (creazione);
 2   DROP INDEX public.anagrafica_estensione_36063dc9;
       public         alfioemanuele    false    221            9           1259    620105    anagrafica_estensione_43662d06    INDEX     _   CREATE INDEX anagrafica_estensione_43662d06 ON anagrafica_estensione USING btree (confermata);
 2   DROP INDEX public.anagrafica_estensione_43662d06;
       public         alfioemanuele    false    221            :           1259    620106    anagrafica_estensione_4a9487af    INDEX     ]   CREATE INDEX anagrafica_estensione_4a9487af ON anagrafica_estensione USING btree (ritirata);
 2   DROP INDEX public.anagrafica_estensione_4a9487af;
       public         alfioemanuele    false    221            ;           1259    620432    anagrafica_estensione_530b0ac8    INDEX     d   CREATE INDEX anagrafica_estensione_530b0ac8 ON anagrafica_estensione USING btree (appartenenza_id);
 2   DROP INDEX public.anagrafica_estensione_530b0ac8;
       public         alfioemanuele    false    221            <           1259    620104    anagrafica_estensione_69bd2e5f    INDEX     d   CREATE INDEX anagrafica_estensione_69bd2e5f ON anagrafica_estensione USING btree (ultima_modifica);
 2   DROP INDEX public.anagrafica_estensione_69bd2e5f;
       public         alfioemanuele    false    221            =           1259    620438    anagrafica_estensione_cb8e6a80    INDEX     d   CREATE INDEX anagrafica_estensione_cb8e6a80 ON anagrafica_estensione USING btree (destinazione_id);
 2   DROP INDEX public.anagrafica_estensione_cb8e6a80;
       public         alfioemanuele    false    221            >           1259    620450    anagrafica_estensione_e3692faf    INDEX     c   CREATE INDEX anagrafica_estensione_e3692faf ON anagrafica_estensione USING btree (richiedente_id);
 2   DROP INDEX public.anagrafica_estensione_e3692faf;
       public         alfioemanuele    false    221            ?           1259    620444    anagrafica_estensione_e8589820    INDEX     _   CREATE INDEX anagrafica_estensione_e8589820 ON anagrafica_estensione USING btree (persona_id);
 2   DROP INDEX public.anagrafica_estensione_e8589820;
       public         alfioemanuele    false    221            B           1259    620107    anagrafica_fototessera_36063dc9    INDEX     `   CREATE INDEX anagrafica_fototessera_36063dc9 ON anagrafica_fototessera USING btree (creazione);
 3   DROP INDEX public.anagrafica_fototessera_36063dc9;
       public         alfioemanuele    false    223            C           1259    620109    anagrafica_fototessera_43662d06    INDEX     a   CREATE INDEX anagrafica_fototessera_43662d06 ON anagrafica_fototessera USING btree (confermata);
 3   DROP INDEX public.anagrafica_fototessera_43662d06;
       public         alfioemanuele    false    223            D           1259    620110    anagrafica_fototessera_4a9487af    INDEX     _   CREATE INDEX anagrafica_fototessera_4a9487af ON anagrafica_fototessera USING btree (ritirata);
 3   DROP INDEX public.anagrafica_fototessera_4a9487af;
       public         alfioemanuele    false    223            E           1259    620108    anagrafica_fototessera_69bd2e5f    INDEX     f   CREATE INDEX anagrafica_fototessera_69bd2e5f ON anagrafica_fototessera USING btree (ultima_modifica);
 3   DROP INDEX public.anagrafica_fototessera_69bd2e5f;
       public         alfioemanuele    false    223            F           1259    620426    anagrafica_fototessera_e8589820    INDEX     a   CREATE INDEX anagrafica_fototessera_e8589820 ON anagrafica_fototessera USING btree (persona_id);
 3   DROP INDEX public.anagrafica_fototessera_e8589820;
       public         alfioemanuele    false    223            I           1259    620663    anagrafica_persona_04f07280    INDEX     ^   CREATE INDEX anagrafica_persona_04f07280 ON anagrafica_persona USING btree (privacy_deleghe);
 /   DROP INDEX public.anagrafica_persona_04f07280;
       public         alfioemanuele    false    225            J           1259    620115    anagrafica_persona_313902d5    INDEX     U   CREATE INDEX anagrafica_persona_313902d5 ON anagrafica_persona USING btree (genere);
 /   DROP INDEX public.anagrafica_persona_313902d5;
       public         alfioemanuele    false    225            K           1259    620111    anagrafica_persona_36063dc9    INDEX     X   CREATE INDEX anagrafica_persona_36063dc9 ON anagrafica_persona USING btree (creazione);
 /   DROP INDEX public.anagrafica_persona_36063dc9;
       public         alfioemanuele    false    225            L           1259    620112    anagrafica_persona_69bd2e5f    INDEX     ^   CREATE INDEX anagrafica_persona_69bd2e5f ON anagrafica_persona USING btree (ultima_modifica);
 /   DROP INDEX public.anagrafica_persona_69bd2e5f;
       public         alfioemanuele    false    225            M           1259    620114    anagrafica_persona_798a16e8    INDEX     [   CREATE INDEX anagrafica_persona_798a16e8 ON anagrafica_persona USING btree (data_nascita);
 /   DROP INDEX public.anagrafica_persona_798a16e8;
       public         alfioemanuele    false    225            N           1259    620847    anagrafica_persona_820eb5b6    INDEX     Q   CREATE INDEX anagrafica_persona_820eb5b6 ON anagrafica_persona USING btree (cm);
 /   DROP INDEX public.anagrafica_persona_820eb5b6;
       public         alfioemanuele    false    225            O           1259    620662    anagrafica_persona_aed6a6bc    INDEX     a   CREATE INDEX anagrafica_persona_aed6a6bc ON anagrafica_persona USING btree (privacy_curriculum);
 /   DROP INDEX public.anagrafica_persona_aed6a6bc;
       public         alfioemanuele    false    225            P           1259    620848    anagrafica_persona_c6d86a4e    INDEX     Y   CREATE INDEX anagrafica_persona_c6d86a4e ON anagrafica_persona USING btree (conoscenza);
 /   DROP INDEX public.anagrafica_persona_c6d86a4e;
       public         alfioemanuele    false    225            Q           1259    620117 /   anagrafica_persona_codice_fiscale_1583088a_like    INDEX     �   CREATE INDEX anagrafica_persona_codice_fiscale_1583088a_like ON anagrafica_persona USING btree (codice_fiscale varchar_pattern_ops);
 C   DROP INDEX public.anagrafica_persona_codice_fiscale_1583088a_like;
       public         alfioemanuele    false    225            T           1259    620851 (   anagrafica_persona_cognome_bd30736c_like    INDEX     w   CREATE INDEX anagrafica_persona_cognome_bd30736c_like ON anagrafica_persona USING btree (cognome varchar_pattern_ops);
 <   DROP INDEX public.anagrafica_persona_cognome_bd30736c_like;
       public         alfioemanuele    false    225            U           1259    620850 (   anagrafica_persona_cognome_bd30736c_uniq    INDEX     c   CREATE INDEX anagrafica_persona_cognome_bd30736c_uniq ON anagrafica_persona USING btree (cognome);
 <   DROP INDEX public.anagrafica_persona_cognome_bd30736c_uniq;
       public         alfioemanuele    false    225            V           1259    620113    anagrafica_persona_d6ef5c1f    INDEX     Y   CREATE INDEX anagrafica_persona_d6ef5c1f ON anagrafica_persona USING btree (vecchio_id);
 /   DROP INDEX public.anagrafica_persona_d6ef5c1f;
       public         alfioemanuele    false    225            W           1259    620116    anagrafica_persona_e0b406f5    INDEX     T   CREATE INDEX anagrafica_persona_e0b406f5 ON anagrafica_persona USING btree (stato);
 /   DROP INDEX public.anagrafica_persona_e0b406f5;
       public         alfioemanuele    false    225            X           1259    620849    anagrafica_persona_f0b53b2d    INDEX     Q   CREATE INDEX anagrafica_persona_f0b53b2d ON anagrafica_persona USING btree (iv);
 /   DROP INDEX public.anagrafica_persona_f0b53b2d;
       public         alfioemanuele    false    225            Y           1259    620661    anagrafica_persona_f2ff7cbe    INDEX     _   CREATE INDEX anagrafica_persona_f2ff7cbe ON anagrafica_persona USING btree (privacy_contatti);
 /   DROP INDEX public.anagrafica_persona_f2ff7cbe;
       public         alfioemanuele    false    225            Z           1259    620118 '   anagrafica_persona_genere_eca23be3_like    INDEX     u   CREATE INDEX anagrafica_persona_genere_eca23be3_like ON anagrafica_persona USING btree (genere varchar_pattern_ops);
 ;   DROP INDEX public.anagrafica_persona_genere_eca23be3_like;
       public         alfioemanuele    false    225            [           1259    621079 "   anagrafica_persona_id_8ad8c544_idx    INDEX     w   CREATE INDEX anagrafica_persona_id_8ad8c544_idx ON anagrafica_persona USING btree (id, nome, cognome, codice_fiscale);
 6   DROP INDEX public.anagrafica_persona_id_8ad8c544_idx;
       public         alfioemanuele    false    225    225    225    225            \           1259    620853 %   anagrafica_persona_nome_70081da9_like    INDEX     q   CREATE INDEX anagrafica_persona_nome_70081da9_like ON anagrafica_persona USING btree (nome varchar_pattern_ops);
 9   DROP INDEX public.anagrafica_persona_nome_70081da9_like;
       public         alfioemanuele    false    225            ]           1259    620852 %   anagrafica_persona_nome_70081da9_uniq    INDEX     ]   CREATE INDEX anagrafica_persona_nome_70081da9_uniq ON anagrafica_persona USING btree (nome);
 9   DROP INDEX public.anagrafica_persona_nome_70081da9_uniq;
       public         alfioemanuele    false    225            ^           1259    620955 $   anagrafica_persona_nome_d0a64a88_idx    INDEX     e   CREATE INDEX anagrafica_persona_nome_d0a64a88_idx ON anagrafica_persona USING btree (nome, cognome);
 8   DROP INDEX public.anagrafica_persona_nome_d0a64a88_idx;
       public         alfioemanuele    false    225    225            _           1259    620954 $   anagrafica_persona_nome_d6ba09ab_idx    INDEX     u   CREATE INDEX anagrafica_persona_nome_d6ba09ab_idx ON anagrafica_persona USING btree (nome, cognome, codice_fiscale);
 8   DROP INDEX public.anagrafica_persona_nome_d6ba09ab_idx;
       public         alfioemanuele    false    225    225    225            b           1259    620119 &   anagrafica_persona_stato_b8b12958_like    INDEX     s   CREATE INDEX anagrafica_persona_stato_b8b12958_like ON anagrafica_persona USING btree (stato varchar_pattern_ops);
 :   DROP INDEX public.anagrafica_persona_stato_b8b12958_like;
       public         alfioemanuele    false    225            c           1259    620542 -   anagrafica_provvedimentodisciplinare_0687f864    INDEX     z   CREATE INDEX anagrafica_provvedimentodisciplinare_0687f864 ON anagrafica_provvedimentodisciplinare USING btree (sede_id);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_0687f864;
       public         alfioemanuele    false    227            d           1259    620125 -   anagrafica_provvedimentodisciplinare_36063dc9    INDEX     |   CREATE INDEX anagrafica_provvedimentodisciplinare_36063dc9 ON anagrafica_provvedimentodisciplinare USING btree (creazione);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_36063dc9;
       public         alfioemanuele    false    227            e           1259    620601 -   anagrafica_provvedimentodisciplinare_5744ea4d    INDEX     �   CREATE INDEX anagrafica_provvedimentodisciplinare_5744ea4d ON anagrafica_provvedimentodisciplinare USING btree (registrato_da_id);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_5744ea4d;
       public         alfioemanuele    false    227            f           1259    620126 -   anagrafica_provvedimentodisciplinare_69bd2e5f    INDEX     �   CREATE INDEX anagrafica_provvedimentodisciplinare_69bd2e5f ON anagrafica_provvedimentodisciplinare USING btree (ultima_modifica);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_69bd2e5f;
       public         alfioemanuele    false    227            g           1259    620128 -   anagrafica_provvedimentodisciplinare_7df656af    INDEX     y   CREATE INDEX anagrafica_provvedimentodisciplinare_7df656af ON anagrafica_provvedimentodisciplinare USING btree (inizio);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_7df656af;
       public         alfioemanuele    false    227            h           1259    620414 -   anagrafica_provvedimentodisciplinare_e8589820    INDEX     }   CREATE INDEX anagrafica_provvedimentodisciplinare_e8589820 ON anagrafica_provvedimentodisciplinare USING btree (persona_id);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_e8589820;
       public         alfioemanuele    false    227            i           1259    620129 -   anagrafica_provvedimentodisciplinare_fff25994    INDEX     w   CREATE INDEX anagrafica_provvedimentodisciplinare_fff25994 ON anagrafica_provvedimentodisciplinare USING btree (fine);
 A   DROP INDEX public.anagrafica_provvedimentodisciplinare_fff25994;
       public         alfioemanuele    false    227            l           1259    620130    anagrafica_riserva_36063dc9    INDEX     X   CREATE INDEX anagrafica_riserva_36063dc9 ON anagrafica_riserva USING btree (creazione);
 /   DROP INDEX public.anagrafica_riserva_36063dc9;
       public         alfioemanuele    false    229            m           1259    620134    anagrafica_riserva_43662d06    INDEX     Y   CREATE INDEX anagrafica_riserva_43662d06 ON anagrafica_riserva USING btree (confermata);
 /   DROP INDEX public.anagrafica_riserva_43662d06;
       public         alfioemanuele    false    229            n           1259    620135    anagrafica_riserva_4a9487af    INDEX     W   CREATE INDEX anagrafica_riserva_4a9487af ON anagrafica_riserva USING btree (ritirata);
 /   DROP INDEX public.anagrafica_riserva_4a9487af;
       public         alfioemanuele    false    229            o           1259    620718    anagrafica_riserva_530b0ac8    INDEX     ^   CREATE INDEX anagrafica_riserva_530b0ac8 ON anagrafica_riserva USING btree (appartenenza_id);
 /   DROP INDEX public.anagrafica_riserva_530b0ac8;
       public         alfioemanuele    false    229            p           1259    620131    anagrafica_riserva_69bd2e5f    INDEX     ^   CREATE INDEX anagrafica_riserva_69bd2e5f ON anagrafica_riserva USING btree (ultima_modifica);
 /   DROP INDEX public.anagrafica_riserva_69bd2e5f;
       public         alfioemanuele    false    229            q           1259    620132    anagrafica_riserva_7df656af    INDEX     U   CREATE INDEX anagrafica_riserva_7df656af ON anagrafica_riserva USING btree (inizio);
 /   DROP INDEX public.anagrafica_riserva_7df656af;
       public         alfioemanuele    false    229            r           1259    620724    anagrafica_riserva_e8589820    INDEX     Y   CREATE INDEX anagrafica_riserva_e8589820 ON anagrafica_riserva USING btree (persona_id);
 /   DROP INDEX public.anagrafica_riserva_e8589820;
       public         alfioemanuele    false    229            s           1259    620133    anagrafica_riserva_fff25994    INDEX     S   CREATE INDEX anagrafica_riserva_fff25994 ON anagrafica_riserva USING btree (fine);
 /   DROP INDEX public.anagrafica_riserva_fff25994;
       public         alfioemanuele    false    229            t           1259    620957 &   anagrafica_riserva_inizio_f8af8216_idx    INDEX     f   CREATE INDEX anagrafica_riserva_inizio_f8af8216_idx ON anagrafica_riserva USING btree (inizio, fine);
 :   DROP INDEX public.anagrafica_riserva_inizio_f8af8216_idx;
       public         alfioemanuele    false    229    229            u           1259    620956 *   anagrafica_riserva_persona_id_5ee09e53_idx    INDEX     v   CREATE INDEX anagrafica_riserva_persona_id_5ee09e53_idx ON anagrafica_riserva USING btree (persona_id, inizio, fine);
 >   DROP INDEX public.anagrafica_riserva_persona_id_5ee09e53_idx;
       public         alfioemanuele    false    229    229    229            x           1259    620147    anagrafica_sede_28576d3a    INDEX     O   CREATE INDEX anagrafica_sede_28576d3a ON anagrafica_sede USING btree (attiva);
 ,   DROP INDEX public.anagrafica_sede_28576d3a;
       public         alfioemanuele    false    231            y           1259    620408    anagrafica_sede_29a104e3    INDEX     U   CREATE INDEX anagrafica_sede_29a104e3 ON anagrafica_sede USING btree (locazione_id);
 ,   DROP INDEX public.anagrafica_sede_29a104e3;
       public         alfioemanuele    false    231            z           1259    620148    anagrafica_sede_2dbcba41    INDEX     M   CREATE INDEX anagrafica_sede_2dbcba41 ON anagrafica_sede USING btree (slug);
 ,   DROP INDEX public.anagrafica_sede_2dbcba41;
       public         alfioemanuele    false    231            {           1259    620141    anagrafica_sede_36063dc9    INDEX     R   CREATE INDEX anagrafica_sede_36063dc9 ON anagrafica_sede USING btree (creazione);
 ,   DROP INDEX public.anagrafica_sede_36063dc9;
       public         alfioemanuele    false    231            |           1259    620150    anagrafica_sede_3cfbd988    INDEX     M   CREATE INDEX anagrafica_sede_3cfbd988 ON anagrafica_sede USING btree (rght);
 ,   DROP INDEX public.anagrafica_sede_3cfbd988;
       public         alfioemanuele    false    231            }           1259    620146    anagrafica_sede_401281b0    INDEX     M   CREATE INDEX anagrafica_sede_401281b0 ON anagrafica_sede USING btree (tipo);
 ,   DROP INDEX public.anagrafica_sede_401281b0;
       public         alfioemanuele    false    231            ~           1259    620151    anagrafica_sede_656442a0    INDEX     P   CREATE INDEX anagrafica_sede_656442a0 ON anagrafica_sede USING btree (tree_id);
 ,   DROP INDEX public.anagrafica_sede_656442a0;
       public         alfioemanuele    false    231                       1259    620143    anagrafica_sede_666ac576    INDEX     M   CREATE INDEX anagrafica_sede_666ac576 ON anagrafica_sede USING btree (nome);
 ,   DROP INDEX public.anagrafica_sede_666ac576;
       public         alfioemanuele    false    231            �           1259    620142    anagrafica_sede_69bd2e5f    INDEX     X   CREATE INDEX anagrafica_sede_69bd2e5f ON anagrafica_sede USING btree (ultima_modifica);
 ,   DROP INDEX public.anagrafica_sede_69bd2e5f;
       public         alfioemanuele    false    231            �           1259    620958 #   anagrafica_sede_attiva_233f988f_idx    INDEX     f   CREATE INDEX anagrafica_sede_attiva_233f988f_idx ON anagrafica_sede USING btree (attiva, estensione);
 7   DROP INDEX public.anagrafica_sede_attiva_233f988f_idx;
       public         alfioemanuele    false    231    231            �           1259    620960 #   anagrafica_sede_attiva_7fd691e4_idx    INDEX     `   CREATE INDEX anagrafica_sede_attiva_7fd691e4_idx ON anagrafica_sede USING btree (attiva, tipo);
 7   DROP INDEX public.anagrafica_sede_attiva_7fd691e4_idx;
       public         alfioemanuele    false    231    231            �           1259    620152    anagrafica_sede_c9e9a848    INDEX     N   CREATE INDEX anagrafica_sede_c9e9a848 ON anagrafica_sede USING btree (level);
 ,   DROP INDEX public.anagrafica_sede_c9e9a848;
       public         alfioemanuele    false    231            �           1259    620149    anagrafica_sede_caf7cc51    INDEX     L   CREATE INDEX anagrafica_sede_caf7cc51 ON anagrafica_sede USING btree (lft);
 ,   DROP INDEX public.anagrafica_sede_caf7cc51;
       public         alfioemanuele    false    231            �           1259    620144    anagrafica_sede_d6ef5c1f    INDEX     S   CREATE INDEX anagrafica_sede_d6ef5c1f ON anagrafica_sede USING btree (vecchio_id);
 ,   DROP INDEX public.anagrafica_sede_d6ef5c1f;
       public         alfioemanuele    false    231            �           1259    620145    anagrafica_sede_dbb9a234    INDEX     S   CREATE INDEX anagrafica_sede_dbb9a234 ON anagrafica_sede USING btree (estensione);
 ,   DROP INDEX public.anagrafica_sede_dbb9a234;
       public         alfioemanuele    false    231            �           1259    620153    anagrafica_sede_e3246201    INDEX     T   CREATE INDEX anagrafica_sede_e3246201 ON anagrafica_sede USING btree (genitore_id);
 ,   DROP INDEX public.anagrafica_sede_e3246201;
       public         alfioemanuele    false    231            �           1259    620155 (   anagrafica_sede_estensione_b209debc_like    INDEX     w   CREATE INDEX anagrafica_sede_estensione_b209debc_like ON anagrafica_sede USING btree (estensione varchar_pattern_ops);
 <   DROP INDEX public.anagrafica_sede_estensione_b209debc_like;
       public         alfioemanuele    false    231            �           1259    620959 '   anagrafica_sede_estensione_cccb80d7_idx    INDEX     h   CREATE INDEX anagrafica_sede_estensione_cccb80d7_idx ON anagrafica_sede USING btree (estensione, tipo);
 ;   DROP INDEX public.anagrafica_sede_estensione_cccb80d7_idx;
       public         alfioemanuele    false    231    231            �           1259    620970 (   anagrafica_sede_genitore_id_b098ef17_idx    INDEX     p   CREATE INDEX anagrafica_sede_genitore_id_b098ef17_idx ON anagrafica_sede USING btree (genitore_id, estensione);
 <   DROP INDEX public.anagrafica_sede_genitore_id_b098ef17_idx;
       public         alfioemanuele    false    231    231            �           1259    620966     anagrafica_sede_lft_05961abf_idx    INDEX     b   CREATE INDEX anagrafica_sede_lft_05961abf_idx ON anagrafica_sede USING btree (lft, rght, attiva);
 4   DROP INDEX public.anagrafica_sede_lft_05961abf_idx;
       public         alfioemanuele    false    231    231    231            �           1259    620967     anagrafica_sede_lft_b9e067ed_idx    INDEX     c   CREATE INDEX anagrafica_sede_lft_b9e067ed_idx ON anagrafica_sede USING btree (lft, rght, tree_id);
 4   DROP INDEX public.anagrafica_sede_lft_b9e067ed_idx;
       public         alfioemanuele    false    231    231    231            �           1259    620965     anagrafica_sede_lft_e582fb51_idx    INDEX     Z   CREATE INDEX anagrafica_sede_lft_e582fb51_idx ON anagrafica_sede USING btree (lft, rght);
 4   DROP INDEX public.anagrafica_sede_lft_e582fb51_idx;
       public         alfioemanuele    false    231    231            �           1259    620968     anagrafica_sede_lft_ee02f9f7_idx    INDEX     n   CREATE INDEX anagrafica_sede_lft_ee02f9f7_idx ON anagrafica_sede USING btree (lft, rght, attiva, estensione);
 4   DROP INDEX public.anagrafica_sede_lft_ee02f9f7_idx;
       public         alfioemanuele    false    231    231    231    231            �           1259    620154 "   anagrafica_sede_nome_b7509597_like    INDEX     k   CREATE INDEX anagrafica_sede_nome_b7509597_like ON anagrafica_sede USING btree (nome varchar_pattern_ops);
 6   DROP INDEX public.anagrafica_sede_nome_b7509597_like;
       public         alfioemanuele    false    231            �           1259    620157 "   anagrafica_sede_slug_45022f7a_like    INDEX     k   CREATE INDEX anagrafica_sede_slug_45022f7a_like ON anagrafica_sede USING btree (slug varchar_pattern_ops);
 6   DROP INDEX public.anagrafica_sede_slug_45022f7a_like;
       public         alfioemanuele    false    231            �           1259    620156 "   anagrafica_sede_tipo_6828be71_like    INDEX     k   CREATE INDEX anagrafica_sede_tipo_6828be71_like ON anagrafica_sede USING btree (tipo varchar_pattern_ops);
 6   DROP INDEX public.anagrafica_sede_tipo_6828be71_like;
       public         alfioemanuele    false    231            �           1259    620163    anagrafica_telefono_36063dc9    INDEX     Z   CREATE INDEX anagrafica_telefono_36063dc9 ON anagrafica_telefono USING btree (creazione);
 0   DROP INDEX public.anagrafica_telefono_36063dc9;
       public         alfioemanuele    false    233            �           1259    620164    anagrafica_telefono_69bd2e5f    INDEX     `   CREATE INDEX anagrafica_telefono_69bd2e5f ON anagrafica_telefono USING btree (ultima_modifica);
 0   DROP INDEX public.anagrafica_telefono_69bd2e5f;
       public         alfioemanuele    false    233            �           1259    620165    anagrafica_telefono_e8589820    INDEX     [   CREATE INDEX anagrafica_telefono_e8589820 ON anagrafica_telefono USING btree (persona_id);
 0   DROP INDEX public.anagrafica_telefono_e8589820;
       public         alfioemanuele    false    233            �           1259    620969 +   anagrafica_telefono_persona_id_f331fd86_idx    INDEX     t   CREATE INDEX anagrafica_telefono_persona_id_f331fd86_idx ON anagrafica_telefono USING btree (persona_id, servizio);
 ?   DROP INDEX public.anagrafica_telefono_persona_id_f331fd86_idx;
       public         alfioemanuele    false    233    233            �           1259    620186 !   anagrafica_trasferimento_36063dc9    INDEX     d   CREATE INDEX anagrafica_trasferimento_36063dc9 ON anagrafica_trasferimento USING btree (creazione);
 5   DROP INDEX public.anagrafica_trasferimento_36063dc9;
       public         alfioemanuele    false    235            �           1259    620188 !   anagrafica_trasferimento_43662d06    INDEX     e   CREATE INDEX anagrafica_trasferimento_43662d06 ON anagrafica_trasferimento USING btree (confermata);
 5   DROP INDEX public.anagrafica_trasferimento_43662d06;
       public         alfioemanuele    false    235            �           1259    620189 !   anagrafica_trasferimento_4a9487af    INDEX     c   CREATE INDEX anagrafica_trasferimento_4a9487af ON anagrafica_trasferimento USING btree (ritirata);
 5   DROP INDEX public.anagrafica_trasferimento_4a9487af;
       public         alfioemanuele    false    235            �           1259    620190 !   anagrafica_trasferimento_530b0ac8    INDEX     j   CREATE INDEX anagrafica_trasferimento_530b0ac8 ON anagrafica_trasferimento USING btree (appartenenza_id);
 5   DROP INDEX public.anagrafica_trasferimento_530b0ac8;
       public         alfioemanuele    false    235            �           1259    620187 !   anagrafica_trasferimento_69bd2e5f    INDEX     j   CREATE INDEX anagrafica_trasferimento_69bd2e5f ON anagrafica_trasferimento USING btree (ultima_modifica);
 5   DROP INDEX public.anagrafica_trasferimento_69bd2e5f;
       public         alfioemanuele    false    235            �           1259    620191 !   anagrafica_trasferimento_cb8e6a80    INDEX     j   CREATE INDEX anagrafica_trasferimento_cb8e6a80 ON anagrafica_trasferimento USING btree (destinazione_id);
 5   DROP INDEX public.anagrafica_trasferimento_cb8e6a80;
       public         alfioemanuele    false    235            �           1259    620193 !   anagrafica_trasferimento_e3692faf    INDEX     i   CREATE INDEX anagrafica_trasferimento_e3692faf ON anagrafica_trasferimento USING btree (richiedente_id);
 5   DROP INDEX public.anagrafica_trasferimento_e3692faf;
       public         alfioemanuele    false    235            �           1259    620192 !   anagrafica_trasferimento_e8589820    INDEX     e   CREATE INDEX anagrafica_trasferimento_e8589820 ON anagrafica_trasferimento USING btree (persona_id);
 5   DROP INDEX public.anagrafica_trasferimento_e8589820;
       public         alfioemanuele    false    235            �           1259    621186    attivita_area_0687f864    INDEX     L   CREATE INDEX attivita_area_0687f864 ON attivita_area USING btree (sede_id);
 *   DROP INDEX public.attivita_area_0687f864;
       public         alfioemanuele    false    255            �           1259    621115    attivita_area_36063dc9    INDEX     N   CREATE INDEX attivita_area_36063dc9 ON attivita_area USING btree (creazione);
 *   DROP INDEX public.attivita_area_36063dc9;
       public         alfioemanuele    false    255                        1259    621117    attivita_area_666ac576    INDEX     I   CREATE INDEX attivita_area_666ac576 ON attivita_area USING btree (nome);
 *   DROP INDEX public.attivita_area_666ac576;
       public         alfioemanuele    false    255                       1259    621116    attivita_area_69bd2e5f    INDEX     T   CREATE INDEX attivita_area_69bd2e5f ON attivita_area USING btree (ultima_modifica);
 *   DROP INDEX public.attivita_area_69bd2e5f;
       public         alfioemanuele    false    255                       1259    621118    attivita_area_cefdb931    INDEX     N   CREATE INDEX attivita_area_cefdb931 ON attivita_area USING btree (obiettivo);
 *   DROP INDEX public.attivita_area_cefdb931;
       public         alfioemanuele    false    255                       1259    621119     attivita_area_nome_87de2dfa_like    INDEX     g   CREATE INDEX attivita_area_nome_87de2dfa_like ON attivita_area USING btree (nome varchar_pattern_ops);
 4   DROP INDEX public.attivita_area_nome_87de2dfa_like;
       public         alfioemanuele    false    255                       1259    621228 "   attivita_area_sede_id_0593399b_idx    INDEX     c   CREATE INDEX attivita_area_sede_id_0593399b_idx ON attivita_area USING btree (sede_id, obiettivo);
 6   DROP INDEX public.attivita_area_sede_id_0593399b_idx;
       public         alfioemanuele    false    255    255                       1259    621180    attivita_attivita_0687f864    INDEX     T   CREATE INDEX attivita_attivita_0687f864 ON attivita_attivita USING btree (sede_id);
 .   DROP INDEX public.attivita_attivita_0687f864;
       public         alfioemanuele    false    257                       1259    621257    attivita_attivita_213ee482    INDEX     _   CREATE INDEX attivita_attivita_213ee482 ON attivita_attivita USING btree (centrale_operativa);
 .   DROP INDEX public.attivita_attivita_213ee482;
       public         alfioemanuele    false    257            	           1259    621135    attivita_attivita_2873ce9d    INDEX     U   CREATE INDEX attivita_attivita_2873ce9d ON attivita_attivita USING btree (apertura);
 .   DROP INDEX public.attivita_attivita_2873ce9d;
       public         alfioemanuele    false    257            
           1259    621174    attivita_attivita_29a104e3    INDEX     Y   CREATE INDEX attivita_attivita_29a104e3 ON attivita_attivita USING btree (locazione_id);
 .   DROP INDEX public.attivita_attivita_29a104e3;
       public         alfioemanuele    false    257                       1259    621130    attivita_attivita_36063dc9    INDEX     V   CREATE INDEX attivita_attivita_36063dc9 ON attivita_attivita USING btree (creazione);
 .   DROP INDEX public.attivita_attivita_36063dc9;
       public         alfioemanuele    false    257                       1259    621133    attivita_attivita_666ac576    INDEX     Q   CREATE INDEX attivita_attivita_666ac576 ON attivita_attivita USING btree (nome);
 .   DROP INDEX public.attivita_attivita_666ac576;
       public         alfioemanuele    false    257                       1259    621131    attivita_attivita_69bd2e5f    INDEX     \   CREATE INDEX attivita_attivita_69bd2e5f ON attivita_attivita USING btree (ultima_modifica);
 .   DROP INDEX public.attivita_attivita_69bd2e5f;
       public         alfioemanuele    false    257                       1259    621140 (   attivita_attivita_apertura_f026ec65_like    INDEX     w   CREATE INDEX attivita_attivita_apertura_f026ec65_like ON attivita_attivita USING btree (apertura varchar_pattern_ops);
 <   DROP INDEX public.attivita_attivita_apertura_f026ec65_like;
       public         alfioemanuele    false    257                       1259    621275 1   attivita_attivita_centrale_operativa_179878e8_idx    INDEX        CREATE INDEX attivita_attivita_centrale_operativa_179878e8_idx ON attivita_attivita USING btree (centrale_operativa, sede_id);
 E   DROP INDEX public.attivita_attivita_centrale_operativa_179878e8_idx;
       public         alfioemanuele    false    257    257                       1259    621136    attivita_attivita_d266de13    INDEX     T   CREATE INDEX attivita_attivita_d266de13 ON attivita_attivita USING btree (area_id);
 .   DROP INDEX public.attivita_attivita_d266de13;
       public         alfioemanuele    false    257                       1259    621132    attivita_attivita_d6ef5c1f    INDEX     W   CREATE INDEX attivita_attivita_d6ef5c1f ON attivita_attivita USING btree (vecchio_id);
 .   DROP INDEX public.attivita_attivita_d6ef5c1f;
       public         alfioemanuele    false    257                       1259    621134    attivita_attivita_e0b406f5    INDEX     R   CREATE INDEX attivita_attivita_e0b406f5 ON attivita_attivita USING btree (stato);
 .   DROP INDEX public.attivita_attivita_e0b406f5;
       public         alfioemanuele    false    257                       1259    621225 ,   attivita_attivita_estensione_id_adfc324e_idx    INDEX     v   CREATE INDEX attivita_attivita_estensione_id_adfc324e_idx ON attivita_attivita USING btree (estensione_id, apertura);
 @   DROP INDEX public.attivita_attivita_estensione_id_adfc324e_idx;
       public         alfioemanuele    false    257    257                       1259    621137    attivita_attivita_f911fd76    INDEX     Z   CREATE INDEX attivita_attivita_f911fd76 ON attivita_attivita USING btree (estensione_id);
 .   DROP INDEX public.attivita_attivita_f911fd76;
       public         alfioemanuele    false    257                       1259    621138 $   attivita_attivita_nome_df14a3b3_like    INDEX     o   CREATE INDEX attivita_attivita_nome_df14a3b3_like ON attivita_attivita USING btree (nome varchar_pattern_ops);
 8   DROP INDEX public.attivita_attivita_nome_df14a3b3_like;
       public         alfioemanuele    false    257                       1259    621226 &   attivita_attivita_sede_id_1bb22550_idx    INDEX     y   CREATE INDEX attivita_attivita_sede_id_1bb22550_idx ON attivita_attivita USING btree (sede_id, estensione_id, apertura);
 :   DROP INDEX public.attivita_attivita_sede_id_1bb22550_idx;
       public         alfioemanuele    false    257    257    257                       1259    621224 &   attivita_attivita_sede_id_35b8f18e_idx    INDEX     �   CREATE INDEX attivita_attivita_sede_id_35b8f18e_idx ON attivita_attivita USING btree (sede_id, estensione_id, apertura, stato);
 :   DROP INDEX public.attivita_attivita_sede_id_35b8f18e_idx;
       public         alfioemanuele    false    257    257    257    257                       1259    621223 &   attivita_attivita_sede_id_65fe7596_idx    INDEX     v   CREATE INDEX attivita_attivita_sede_id_65fe7596_idx ON attivita_attivita USING btree (sede_id, estensione_id, stato);
 :   DROP INDEX public.attivita_attivita_sede_id_65fe7596_idx;
       public         alfioemanuele    false    257    257    257                       1259    621227 &   attivita_attivita_sede_id_96b5dddd_idx    INDEX     o   CREATE INDEX attivita_attivita_sede_id_96b5dddd_idx ON attivita_attivita USING btree (sede_id, estensione_id);
 :   DROP INDEX public.attivita_attivita_sede_id_96b5dddd_idx;
       public         alfioemanuele    false    257    257                       1259    621222 &   attivita_attivita_sede_id_d46ac694_idx    INDEX     j   CREATE INDEX attivita_attivita_sede_id_d46ac694_idx ON attivita_attivita USING btree (sede_id, apertura);
 :   DROP INDEX public.attivita_attivita_sede_id_d46ac694_idx;
       public         alfioemanuele    false    257    257                       1259    621139 %   attivita_attivita_stato_8003dc3a_like    INDEX     q   CREATE INDEX attivita_attivita_stato_8003dc3a_like ON attivita_attivita USING btree (stato varchar_pattern_ops);
 9   DROP INDEX public.attivita_attivita_stato_8003dc3a_like;
       public         alfioemanuele    false    257                       1259    621168     attivita_partecipazione_177cb605    INDEX     a   CREATE INDEX attivita_partecipazione_177cb605 ON attivita_partecipazione USING btree (turno_id);
 4   DROP INDEX public.attivita_partecipazione_177cb605;
       public         alfioemanuele    false    259                       1259    621274     attivita_partecipazione_213ee482    INDEX     k   CREATE INDEX attivita_partecipazione_213ee482 ON attivita_partecipazione USING btree (centrale_operativa);
 4   DROP INDEX public.attivita_partecipazione_213ee482;
       public         alfioemanuele    false    259                        1259    621146     attivita_partecipazione_36063dc9    INDEX     b   CREATE INDEX attivita_partecipazione_36063dc9 ON attivita_partecipazione USING btree (creazione);
 4   DROP INDEX public.attivita_partecipazione_36063dc9;
       public         alfioemanuele    false    259            !           1259    621148     attivita_partecipazione_43662d06    INDEX     c   CREATE INDEX attivita_partecipazione_43662d06 ON attivita_partecipazione USING btree (confermata);
 4   DROP INDEX public.attivita_partecipazione_43662d06;
       public         alfioemanuele    false    259            "           1259    621149     attivita_partecipazione_4a9487af    INDEX     a   CREATE INDEX attivita_partecipazione_4a9487af ON attivita_partecipazione USING btree (ritirata);
 4   DROP INDEX public.attivita_partecipazione_4a9487af;
       public         alfioemanuele    false    259            #           1259    621147     attivita_partecipazione_69bd2e5f    INDEX     h   CREATE INDEX attivita_partecipazione_69bd2e5f ON attivita_partecipazione USING btree (ultima_modifica);
 4   DROP INDEX public.attivita_partecipazione_69bd2e5f;
       public         alfioemanuele    false    259            $           1259    621150     attivita_partecipazione_e0b406f5    INDEX     ^   CREATE INDEX attivita_partecipazione_e0b406f5 ON attivita_partecipazione USING btree (stato);
 4   DROP INDEX public.attivita_partecipazione_e0b406f5;
       public         alfioemanuele    false    259            %           1259    621151     attivita_partecipazione_e8589820    INDEX     c   CREATE INDEX attivita_partecipazione_e8589820 ON attivita_partecipazione USING btree (persona_id);
 4   DROP INDEX public.attivita_partecipazione_e8589820;
       public         alfioemanuele    false    259            &           1259    621216 /   attivita_partecipazione_persona_id_0b1793b6_idx    INDEX     �   CREATE INDEX attivita_partecipazione_persona_id_0b1793b6_idx ON attivita_partecipazione USING btree (persona_id, turno_id, stato);
 C   DROP INDEX public.attivita_partecipazione_persona_id_0b1793b6_idx;
       public         alfioemanuele    false    259    259    259            '           1259    621218 /   attivita_partecipazione_persona_id_f056b983_idx    INDEX     |   CREATE INDEX attivita_partecipazione_persona_id_f056b983_idx ON attivita_partecipazione USING btree (persona_id, turno_id);
 C   DROP INDEX public.attivita_partecipazione_persona_id_f056b983_idx;
       public         alfioemanuele    false    259    259            *           1259    621152 +   attivita_partecipazione_stato_e872ecd9_like    INDEX     }   CREATE INDEX attivita_partecipazione_stato_e872ecd9_like ON attivita_partecipazione USING btree (stato varchar_pattern_ops);
 ?   DROP INDEX public.attivita_partecipazione_stato_e872ecd9_like;
       public         alfioemanuele    false    259            +           1259    621217 -   attivita_partecipazione_turno_id_820c154b_idx    INDEX     u   CREATE INDEX attivita_partecipazione_turno_id_820c154b_idx ON attivita_partecipazione USING btree (turno_id, stato);
 A   DROP INDEX public.attivita_partecipazione_turno_id_820c154b_idx;
       public         alfioemanuele    false    259    259            ,           1259    621158    attivita_turno_36063dc9    INDEX     P   CREATE INDEX attivita_turno_36063dc9 ON attivita_turno USING btree (creazione);
 +   DROP INDEX public.attivita_turno_36063dc9;
       public         alfioemanuele    false    261            -           1259    621166    attivita_turno_3abe1833    INDEX     R   CREATE INDEX attivita_turno_3abe1833 ON attivita_turno USING btree (attivita_id);
 +   DROP INDEX public.attivita_turno_3abe1833;
       public         alfioemanuele    false    261            .           1259    621160    attivita_turno_666ac576    INDEX     K   CREATE INDEX attivita_turno_666ac576 ON attivita_turno USING btree (nome);
 +   DROP INDEX public.attivita_turno_666ac576;
       public         alfioemanuele    false    261            /           1259    621159    attivita_turno_69bd2e5f    INDEX     V   CREATE INDEX attivita_turno_69bd2e5f ON attivita_turno USING btree (ultima_modifica);
 +   DROP INDEX public.attivita_turno_69bd2e5f;
       public         alfioemanuele    false    261            0           1259    621162    attivita_turno_7df656af    INDEX     M   CREATE INDEX attivita_turno_7df656af ON attivita_turno USING btree (inizio);
 +   DROP INDEX public.attivita_turno_7df656af;
       public         alfioemanuele    false    261            1           1259    621165    attivita_turno_8cac5ac4    INDEX     N   CREATE INDEX attivita_turno_8cac5ac4 ON attivita_turno USING btree (massimo);
 +   DROP INDEX public.attivita_turno_8cac5ac4;
       public         alfioemanuele    false    261            2           1259    621161    attivita_turno_9b1d5224    INDEX     S   CREATE INDEX attivita_turno_9b1d5224 ON attivita_turno USING btree (prenotazione);
 +   DROP INDEX public.attivita_turno_9b1d5224;
       public         alfioemanuele    false    261            3           1259    621219 '   attivita_turno_attivita_id_64dfe525_idx    INDEX     j   CREATE INDEX attivita_turno_attivita_id_64dfe525_idx ON attivita_turno USING btree (attivita_id, inizio);
 ;   DROP INDEX public.attivita_turno_attivita_id_64dfe525_idx;
       public         alfioemanuele    false    261    261            4           1259    621220 '   attivita_turno_attivita_id_d9f6d0b8_idx    INDEX     p   CREATE INDEX attivita_turno_attivita_id_d9f6d0b8_idx ON attivita_turno USING btree (attivita_id, inizio, fine);
 ;   DROP INDEX public.attivita_turno_attivita_id_d9f6d0b8_idx;
       public         alfioemanuele    false    261    261    261            5           1259    621164    attivita_turno_bf5f7974    INDEX     M   CREATE INDEX attivita_turno_bf5f7974 ON attivita_turno USING btree (minimo);
 +   DROP INDEX public.attivita_turno_bf5f7974;
       public         alfioemanuele    false    261            6           1259    621163    attivita_turno_fff25994    INDEX     K   CREATE INDEX attivita_turno_fff25994 ON attivita_turno USING btree (fine);
 +   DROP INDEX public.attivita_turno_fff25994;
       public         alfioemanuele    false    261            7           1259    621221 "   attivita_turno_inizio_4ea3f755_idx    INDEX     ^   CREATE INDEX attivita_turno_inizio_4ea3f755_idx ON attivita_turno USING btree (inizio, fine);
 6   DROP INDEX public.attivita_turno_inizio_4ea3f755_idx;
       public         alfioemanuele    false    261    261            8           1259    621167 !   attivita_turno_nome_3c326217_like    INDEX     i   CREATE INDEX attivita_turno_nome_3c326217_like ON attivita_turno USING btree (nome varchar_pattern_ops);
 5   DROP INDEX public.attivita_turno_nome_3c326217_like;
       public         alfioemanuele    false    261            �           1259    620227    autenticazione_utenza_36063dc9    INDEX     ^   CREATE INDEX autenticazione_utenza_36063dc9 ON autenticazione_utenza USING btree (creazione);
 2   DROP INDEX public.autenticazione_utenza_36063dc9;
       public         alfioemanuele    false    237            �           1259    620228    autenticazione_utenza_69bd2e5f    INDEX     d   CREATE INDEX autenticazione_utenza_69bd2e5f ON autenticazione_utenza USING btree (ultima_modifica);
 2   DROP INDEX public.autenticazione_utenza_69bd2e5f;
       public         alfioemanuele    false    237            �           1259    620229 )   autenticazione_utenza_email_1427a4ce_like    INDEX     y   CREATE INDEX autenticazione_utenza_email_1427a4ce_like ON autenticazione_utenza USING btree (email varchar_pattern_ops);
 =   DROP INDEX public.autenticazione_utenza_email_1427a4ce_like;
       public         alfioemanuele    false    237            �           1259    620243 %   autenticazione_utenza_groups_0e939a4f    INDEX     k   CREATE INDEX autenticazione_utenza_groups_0e939a4f ON autenticazione_utenza_groups USING btree (group_id);
 9   DROP INDEX public.autenticazione_utenza_groups_0e939a4f;
       public         alfioemanuele    false    239            �           1259    620242 %   autenticazione_utenza_groups_677a0914    INDEX     l   CREATE INDEX autenticazione_utenza_groups_677a0914 ON autenticazione_utenza_groups USING btree (utenza_id);
 9   DROP INDEX public.autenticazione_utenza_groups_677a0914;
       public         alfioemanuele    false    239            �           1259    620256 /   autenticazione_utenza_user_permissions_677a0914    INDEX     �   CREATE INDEX autenticazione_utenza_user_permissions_677a0914 ON autenticazione_utenza_user_permissions USING btree (utenza_id);
 C   DROP INDEX public.autenticazione_utenza_user_permissions_677a0914;
       public         alfioemanuele    false    241            �           1259    620257 /   autenticazione_utenza_user_permissions_8373b171    INDEX     �   CREATE INDEX autenticazione_utenza_user_permissions_8373b171 ON autenticazione_utenza_user_permissions USING btree (permission_id);
 C   DROP INDEX public.autenticazione_utenza_user_permissions_8373b171;
       public         alfioemanuele    false    241            �           1259    619938    auth_group_name_a6ea08ec_like    INDEX     a   CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public         alfioemanuele    false    209            �           1259    619951    auth_group_permissions_0e939a4f    INDEX     _   CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);
 3   DROP INDEX public.auth_group_permissions_0e939a4f;
       public         alfioemanuele    false    211            �           1259    619952    auth_group_permissions_8373b171    INDEX     d   CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);
 3   DROP INDEX public.auth_group_permissions_8373b171;
       public         alfioemanuele    false    211            �           1259    619937    auth_permission_417f1b1c    INDEX     X   CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);
 ,   DROP INDEX public.auth_permission_417f1b1c;
       public         alfioemanuele    false    207            �           1259    620344    base_allegato_36063dc9    INDEX     N   CREATE INDEX base_allegato_36063dc9 ON base_allegato USING btree (creazione);
 *   DROP INDEX public.base_allegato_36063dc9;
       public         alfioemanuele    false    245            �           1259    620345    base_allegato_69bd2e5f    INDEX     T   CREATE INDEX base_allegato_69bd2e5f ON base_allegato USING btree (ultima_modifica);
 *   DROP INDEX public.base_allegato_69bd2e5f;
       public         alfioemanuele    false    245            �           1259    620346    base_allegato_9c82ce86    INDEX     O   CREATE INDEX base_allegato_9c82ce86 ON base_allegato USING btree (oggetto_id);
 *   DROP INDEX public.base_allegato_9c82ce86;
       public         alfioemanuele    false    245            �           1259    621306    base_allegato_f5148848    INDEX     M   CREATE INDEX base_allegato_f5148848 ON base_allegato USING btree (scadenza);
 *   DROP INDEX public.base_allegato_f5148848;
       public         alfioemanuele    false    245            �           1259    620347    base_allegato_fe2a0979    INDEX     T   CREATE INDEX base_allegato_fe2a0979 ON base_allegato USING btree (oggetto_tipo_id);
 *   DROP INDEX public.base_allegato_fe2a0979;
       public         alfioemanuele    false    245            �           1259    620373    base_autorizzazione_1d6d29b9    INDEX     h   CREATE INDEX base_autorizzazione_1d6d29b9 ON base_autorizzazione USING btree (destinatario_oggetto_id);
 0   DROP INDEX public.base_autorizzazione_1d6d29b9;
       public         alfioemanuele    false    247            �           1259    620372    base_autorizzazione_2fe19435    INDEX     [   CREATE INDEX base_autorizzazione_2fe19435 ON base_autorizzazione USING btree (necessaria);
 0   DROP INDEX public.base_autorizzazione_2fe19435;
       public         alfioemanuele    false    247            �           1259    620368    base_autorizzazione_36063dc9    INDEX     Z   CREATE INDEX base_autorizzazione_36063dc9 ON base_autorizzazione USING btree (creazione);
 0   DROP INDEX public.base_autorizzazione_36063dc9;
       public         alfioemanuele    false    247            �           1259    620375    base_autorizzazione_515fa17e    INDEX     ^   CREATE INDEX base_autorizzazione_515fa17e ON base_autorizzazione USING btree (firmatario_id);
 0   DROP INDEX public.base_autorizzazione_515fa17e;
       public         alfioemanuele    false    247            �           1259    620369    base_autorizzazione_69bd2e5f    INDEX     `   CREATE INDEX base_autorizzazione_69bd2e5f ON base_autorizzazione USING btree (ultima_modifica);
 0   DROP INDEX public.base_autorizzazione_69bd2e5f;
       public         alfioemanuele    false    247            �           1259    620371    base_autorizzazione_9c82ce86    INDEX     [   CREATE INDEX base_autorizzazione_9c82ce86 ON base_autorizzazione USING btree (oggetto_id);
 0   DROP INDEX public.base_autorizzazione_9c82ce86;
       public         alfioemanuele    false    247            �           1259    620370    base_autorizzazione_9fd792c4    INDEX     Y   CREATE INDEX base_autorizzazione_9fd792c4 ON base_autorizzazione USING btree (concessa);
 0   DROP INDEX public.base_autorizzazione_9fd792c4;
       public         alfioemanuele    false    247            �           1259    620374    base_autorizzazione_c836c01f    INDEX     m   CREATE INDEX base_autorizzazione_c836c01f ON base_autorizzazione USING btree (destinatario_oggetto_tipo_id);
 0   DROP INDEX public.base_autorizzazione_c836c01f;
       public         alfioemanuele    false    247            �           1259    621279 =   base_autorizzazione_destinatario_oggetto_tipo_id_13cef3d7_idx    INDEX     �   CREATE INDEX base_autorizzazione_destinatario_oggetto_tipo_id_13cef3d7_idx ON base_autorizzazione USING btree (destinatario_oggetto_tipo_id, destinatario_oggetto_id);
 Q   DROP INDEX public.base_autorizzazione_destinatario_oggetto_tipo_id_13cef3d7_idx;
       public         alfioemanuele    false    247    247            �           1259    620794 4   base_autorizzazione_destinatario_ruolo_564a3afe_like    INDEX     �   CREATE INDEX base_autorizzazione_destinatario_ruolo_564a3afe_like ON base_autorizzazione USING btree (destinatario_ruolo varchar_pattern_ops);
 H   DROP INDEX public.base_autorizzazione_destinatario_ruolo_564a3afe_like;
       public         alfioemanuele    false    247            �           1259    620793 4   base_autorizzazione_destinatario_ruolo_564a3afe_uniq    INDEX     {   CREATE INDEX base_autorizzazione_destinatario_ruolo_564a3afe_uniq ON base_autorizzazione USING btree (destinatario_ruolo);
 H   DROP INDEX public.base_autorizzazione_destinatario_ruolo_564a3afe_uniq;
       public         alfioemanuele    false    247            �           1259    621281 3   base_autorizzazione_destinatario_ruolo_67040295_idx    INDEX     �   CREATE INDEX base_autorizzazione_destinatario_ruolo_67040295_idx ON base_autorizzazione USING btree (destinatario_ruolo, destinatario_oggetto_tipo_id);
 G   DROP INDEX public.base_autorizzazione_destinatario_ruolo_67040295_idx;
       public         alfioemanuele    false    247    247            �           1259    621280 3   base_autorizzazione_destinatario_ruolo_9918e77c_idx    INDEX     �   CREATE INDEX base_autorizzazione_destinatario_ruolo_9918e77c_idx ON base_autorizzazione USING btree (destinatario_ruolo, destinatario_oggetto_tipo_id, destinatario_oggetto_id);
 G   DROP INDEX public.base_autorizzazione_destinatario_ruolo_9918e77c_idx;
       public         alfioemanuele    false    247    247    247            �           1259    620377    base_autorizzazione_e3692faf    INDEX     _   CREATE INDEX base_autorizzazione_e3692faf ON base_autorizzazione USING btree (richiedente_id);
 0   DROP INDEX public.base_autorizzazione_e3692faf;
       public         alfioemanuele    false    247            �           1259    620376    base_autorizzazione_fe2a0979    INDEX     `   CREATE INDEX base_autorizzazione_fe2a0979 ON base_autorizzazione USING btree (oggetto_tipo_id);
 0   DROP INDEX public.base_autorizzazione_fe2a0979;
       public         alfioemanuele    false    247            �           1259    621278 +   base_autorizzazione_necessaria_1186765f_idx    INDEX     �   CREATE INDEX base_autorizzazione_necessaria_1186765f_idx ON base_autorizzazione USING btree (necessaria, destinatario_oggetto_tipo_id, destinatario_oggetto_id);
 ?   DROP INDEX public.base_autorizzazione_necessaria_1186765f_idx;
       public         alfioemanuele    false    247    247    247            �           1259    621277 +   base_autorizzazione_necessaria_29c8dc15_idx    INDEX     t   CREATE INDEX base_autorizzazione_necessaria_29c8dc15_idx ON base_autorizzazione USING btree (necessaria, concessa);
 ?   DROP INDEX public.base_autorizzazione_necessaria_29c8dc15_idx;
       public         alfioemanuele    false    247    247            �           1259    621283 +   base_autorizzazione_necessaria_34dab438_idx    INDEX     �   CREATE INDEX base_autorizzazione_necessaria_34dab438_idx ON base_autorizzazione USING btree (necessaria, destinatario_ruolo, destinatario_oggetto_tipo_id, destinatario_oggetto_id);
 ?   DROP INDEX public.base_autorizzazione_necessaria_34dab438_idx;
       public         alfioemanuele    false    247    247    247    247            �           1259    621282 +   base_autorizzazione_necessaria_c3d12f99_idx    INDEX     w   CREATE INDEX base_autorizzazione_necessaria_c3d12f99_idx ON base_autorizzazione USING btree (necessaria, progressivo);
 ?   DROP INDEX public.base_autorizzazione_necessaria_c3d12f99_idx;
       public         alfioemanuele    false    247    247            �           1259    620381    base_locazione_16a74f32    INDEX     P   CREATE INDEX base_locazione_16a74f32 ON base_locazione USING btree (provincia);
 +   DROP INDEX public.base_locazione_16a74f32;
       public         alfioemanuele    false    249            �           1259    620378    base_locazione_36063dc9    INDEX     P   CREATE INDEX base_locazione_36063dc9 ON base_locazione USING btree (creazione);
 +   DROP INDEX public.base_locazione_36063dc9;
       public         alfioemanuele    false    249            �           1259    620383    base_locazione_3d791e43    INDEX     J   CREATE INDEX base_locazione_3d791e43 ON base_locazione USING btree (cap);
 +   DROP INDEX public.base_locazione_3d791e43;
       public         alfioemanuele    false    249            �           1259    620382    base_locazione_5d3c7293    INDEX     N   CREATE INDEX base_locazione_5d3c7293 ON base_locazione USING btree (regione);
 +   DROP INDEX public.base_locazione_5d3c7293;
       public         alfioemanuele    false    249            �           1259    620379    base_locazione_69bd2e5f    INDEX     V   CREATE INDEX base_locazione_69bd2e5f ON base_locazione USING btree (ultima_modifica);
 +   DROP INDEX public.base_locazione_69bd2e5f;
       public         alfioemanuele    false    249            �           1259    620380    base_locazione_800d4d10    INDEX     M   CREATE INDEX base_locazione_800d4d10 ON base_locazione USING btree (comune);
 +   DROP INDEX public.base_locazione_800d4d10;
       public         alfioemanuele    false    249            �           1259    620388     base_locazione_cap_3ebdebe3_like    INDEX     g   CREATE INDEX base_locazione_cap_3ebdebe3_like ON base_locazione USING btree (cap varchar_pattern_ops);
 4   DROP INDEX public.base_locazione_cap_3ebdebe3_like;
       public         alfioemanuele    false    249            �           1259    620385 #   base_locazione_comune_9aebb52b_like    INDEX     m   CREATE INDEX base_locazione_comune_9aebb52b_like ON base_locazione USING btree (comune varchar_pattern_ops);
 7   DROP INDEX public.base_locazione_comune_9aebb52b_like;
       public         alfioemanuele    false    249            �           1259    621305     base_locazione_geo_2fecf11f_uniq    INDEX     S   CREATE INDEX base_locazione_geo_2fecf11f_uniq ON base_locazione USING btree (geo);
 4   DROP INDEX public.base_locazione_geo_2fecf11f_uniq;
       public         alfioemanuele    false    249    2    2    2    7    2    7    2    7    2    7    2    7    2    7    7    2    7    2    7    7            �           1259    621284    base_locazione_geo_id    INDEX     G   CREATE INDEX base_locazione_geo_id ON base_locazione USING gist (geo);
 )   DROP INDEX public.base_locazione_geo_id;
       public         alfioemanuele    false    249    2    2    2    7    2    7    2    7    2    7    2    7    2    7    7    2    7    2    7    2    7    2    7    7    2    7            �           1259    620384 &   base_locazione_indirizzo_5aee5061_like    INDEX     s   CREATE INDEX base_locazione_indirizzo_5aee5061_like ON base_locazione USING btree (indirizzo varchar_pattern_ops);
 :   DROP INDEX public.base_locazione_indirizzo_5aee5061_like;
       public         alfioemanuele    false    249            �           1259    620386 &   base_locazione_provincia_8aed40a7_like    INDEX     s   CREATE INDEX base_locazione_provincia_8aed40a7_like ON base_locazione USING btree (provincia varchar_pattern_ops);
 :   DROP INDEX public.base_locazione_provincia_8aed40a7_like;
       public         alfioemanuele    false    249            �           1259    620387 $   base_locazione_regione_da2c3801_like    INDEX     o   CREATE INDEX base_locazione_regione_da2c3801_like ON base_locazione USING btree (regione varchar_pattern_ops);
 8   DROP INDEX public.base_locazione_regione_da2c3801_like;
       public         alfioemanuele    false    249            �           1259    620396    base_log_01b9b886    INDEX     L   CREATE INDEX base_log_01b9b886 ON base_log USING btree (oggetto_app_label);
 %   DROP INDEX public.base_log_01b9b886;
       public         alfioemanuele    false    251            �           1259    620394    base_log_36063dc9    INDEX     D   CREATE INDEX base_log_36063dc9 ON base_log USING btree (creazione);
 %   DROP INDEX public.base_log_36063dc9;
       public         alfioemanuele    false    251            �           1259    620398    base_log_419c0abe    INDEX     E   CREATE INDEX base_log_419c0abe ON base_log USING btree (oggetto_pk);
 %   DROP INDEX public.base_log_419c0abe;
       public         alfioemanuele    false    251            �           1259    620395    base_log_69bd2e5f    INDEX     J   CREATE INDEX base_log_69bd2e5f ON base_log USING btree (ultima_modifica);
 %   DROP INDEX public.base_log_69bd2e5f;
       public         alfioemanuele    false    251            �           1259    620399    base_log_76c74769    INDEX     H   CREATE INDEX base_log_76c74769 ON base_log USING btree (oggetto_campo);
 %   DROP INDEX public.base_log_76c74769;
       public         alfioemanuele    false    251            �           1259    620397    base_log_af04014c    INDEX     H   CREATE INDEX base_log_af04014c ON base_log USING btree (oggetto_model);
 %   DROP INDEX public.base_log_af04014c;
       public         alfioemanuele    false    251            �           1259    620400    base_log_e8589820    INDEX     E   CREATE INDEX base_log_e8589820 ON base_log USING btree (persona_id);
 %   DROP INDEX public.base_log_e8589820;
       public         alfioemanuele    false    251            �           1259    620401 (   base_log_oggetto_app_label_ab1437f7_like    INDEX     w   CREATE INDEX base_log_oggetto_app_label_ab1437f7_like ON base_log USING btree (oggetto_app_label varchar_pattern_ops);
 <   DROP INDEX public.base_log_oggetto_app_label_ab1437f7_like;
       public         alfioemanuele    false    251            �           1259    620403 $   base_log_oggetto_campo_dc04c832_like    INDEX     o   CREATE INDEX base_log_oggetto_campo_dc04c832_like ON base_log USING btree (oggetto_campo varchar_pattern_ops);
 8   DROP INDEX public.base_log_oggetto_campo_dc04c832_like;
       public         alfioemanuele    false    251            �           1259    620402 $   base_log_oggetto_model_482bbd90_like    INDEX     o   CREATE INDEX base_log_oggetto_model_482bbd90_like ON base_log USING btree (oggetto_model varchar_pattern_ops);
 8   DROP INDEX public.base_log_oggetto_model_482bbd90_like;
       public         alfioemanuele    false    251            �           1259    620404    base_token_36063dc9    INDEX     H   CREATE INDEX base_token_36063dc9 ON base_token USING btree (creazione);
 '   DROP INDEX public.base_token_36063dc9;
       public         alfioemanuele    false    253            �           1259    620405    base_token_69bd2e5f    INDEX     N   CREATE INDEX base_token_69bd2e5f ON base_token USING btree (ultima_modifica);
 '   DROP INDEX public.base_token_69bd2e5f;
       public         alfioemanuele    false    253            �           1259    620761    base_token_e8589820    INDEX     I   CREATE INDEX base_token_e8589820 ON base_token USING btree (persona_id);
 '   DROP INDEX public.base_token_e8589820;
       public         alfioemanuele    false    253            �           1259    620767    base_token_f17ca2c8    INDEX     G   CREATE INDEX base_token_f17ca2c8 ON base_token USING btree (redirect);
 '   DROP INDEX public.base_token_f17ca2c8;
       public         alfioemanuele    false    253            ;           1259    621329 (   centrale_operativa_reperibilita_36063dc9    INDEX     r   CREATE INDEX centrale_operativa_reperibilita_36063dc9 ON centrale_operativa_reperibilita USING btree (creazione);
 <   DROP INDEX public.centrale_operativa_reperibilita_36063dc9;
       public         alfioemanuele    false    263            <           1259    621330 (   centrale_operativa_reperibilita_69bd2e5f    INDEX     x   CREATE INDEX centrale_operativa_reperibilita_69bd2e5f ON centrale_operativa_reperibilita USING btree (ultima_modifica);
 <   DROP INDEX public.centrale_operativa_reperibilita_69bd2e5f;
       public         alfioemanuele    false    263            =           1259    621331 (   centrale_operativa_reperibilita_7df656af    INDEX     o   CREATE INDEX centrale_operativa_reperibilita_7df656af ON centrale_operativa_reperibilita USING btree (inizio);
 <   DROP INDEX public.centrale_operativa_reperibilita_7df656af;
       public         alfioemanuele    false    263            >           1259    621333 (   centrale_operativa_reperibilita_e8589820    INDEX     s   CREATE INDEX centrale_operativa_reperibilita_e8589820 ON centrale_operativa_reperibilita USING btree (persona_id);
 <   DROP INDEX public.centrale_operativa_reperibilita_e8589820;
       public         alfioemanuele    false    263            ?           1259    621332 (   centrale_operativa_reperibilita_fff25994    INDEX     m   CREATE INDEX centrale_operativa_reperibilita_fff25994 ON centrale_operativa_reperibilita USING btree (fine);
 <   DROP INDEX public.centrale_operativa_reperibilita_fff25994;
       public         alfioemanuele    false    263            B           1259    621359 !   centrale_operativa_turno_177cb605    INDEX     c   CREATE INDEX centrale_operativa_turno_177cb605 ON centrale_operativa_turno USING btree (turno_id);
 5   DROP INDEX public.centrale_operativa_turno_177cb605;
       public         alfioemanuele    false    265            C           1259    621354 !   centrale_operativa_turno_36063dc9    INDEX     d   CREATE INDEX centrale_operativa_turno_36063dc9 ON centrale_operativa_turno USING btree (creazione);
 5   DROP INDEX public.centrale_operativa_turno_36063dc9;
       public         alfioemanuele    false    265            D           1259    621355 !   centrale_operativa_turno_69bd2e5f    INDEX     j   CREATE INDEX centrale_operativa_turno_69bd2e5f ON centrale_operativa_turno USING btree (ultima_modifica);
 5   DROP INDEX public.centrale_operativa_turno_69bd2e5f;
       public         alfioemanuele    false    265            E           1259    621358 !   centrale_operativa_turno_aa815821    INDEX     i   CREATE INDEX centrale_operativa_turno_aa815821 ON centrale_operativa_turno USING btree (smontato_da_id);
 5   DROP INDEX public.centrale_operativa_turno_aa815821;
       public         alfioemanuele    false    265            F           1259    621356 !   centrale_operativa_turno_cf57b80f    INDEX     h   CREATE INDEX centrale_operativa_turno_cf57b80f ON centrale_operativa_turno USING btree (montato_da_id);
 5   DROP INDEX public.centrale_operativa_turno_cf57b80f;
       public         alfioemanuele    false    265            G           1259    621357 !   centrale_operativa_turno_e8589820    INDEX     e   CREATE INDEX centrale_operativa_turno_e8589820 ON centrale_operativa_turno USING btree (persona_id);
 5   DROP INDEX public.centrale_operativa_turno_e8589820;
       public         alfioemanuele    false    265            H           1259    621323 0   centrale_operativa_turno_persona_id_3410fbc6_idx    INDEX     ~   CREATE INDEX centrale_operativa_turno_persona_id_3410fbc6_idx ON centrale_operativa_turno USING btree (persona_id, turno_id);
 D   DROP INDEX public.centrale_operativa_turno_persona_id_3410fbc6_idx;
       public         alfioemanuele    false    265    265            K           1259    621380    curriculum_titolo_401281b0    INDEX     Q   CREATE INDEX curriculum_titolo_401281b0 ON curriculum_titolo USING btree (tipo);
 .   DROP INDEX public.curriculum_titolo_401281b0;
       public         alfioemanuele    false    267            L           1259    621381    curriculum_titolo_666ac576    INDEX     Q   CREATE INDEX curriculum_titolo_666ac576 ON curriculum_titolo USING btree (nome);
 .   DROP INDEX public.curriculum_titolo_666ac576;
       public         alfioemanuele    false    267            M           1259    621379    curriculum_titolo_d6ef5c1f    INDEX     W   CREATE INDEX curriculum_titolo_d6ef5c1f ON curriculum_titolo USING btree (vecchio_id);
 .   DROP INDEX public.curriculum_titolo_d6ef5c1f;
       public         alfioemanuele    false    267            N           1259    621383 $   curriculum_titolo_nome_77553fbd_like    INDEX     o   CREATE INDEX curriculum_titolo_nome_77553fbd_like ON curriculum_titolo USING btree (nome varchar_pattern_ops);
 8   DROP INDEX public.curriculum_titolo_nome_77553fbd_like;
       public         alfioemanuele    false    267            Q           1259    621382 $   curriculum_titolo_tipo_aafed192_like    INDEX     o   CREATE INDEX curriculum_titolo_tipo_aafed192_like ON curriculum_titolo USING btree (tipo varchar_pattern_ops);
 8   DROP INDEX public.curriculum_titolo_tipo_aafed192_like;
       public         alfioemanuele    false    267            R           1259    621399 #   curriculum_titolopersonale_36063dc9    INDEX     h   CREATE INDEX curriculum_titolopersonale_36063dc9 ON curriculum_titolopersonale USING btree (creazione);
 7   DROP INDEX public.curriculum_titolopersonale_36063dc9;
       public         alfioemanuele    false    269            S           1259    621401 #   curriculum_titolopersonale_43662d06    INDEX     i   CREATE INDEX curriculum_titolopersonale_43662d06 ON curriculum_titolopersonale USING btree (confermata);
 7   DROP INDEX public.curriculum_titolopersonale_43662d06;
       public         alfioemanuele    false    269            T           1259    621402 #   curriculum_titolopersonale_4a9487af    INDEX     g   CREATE INDEX curriculum_titolopersonale_4a9487af ON curriculum_titolopersonale USING btree (ritirata);
 7   DROP INDEX public.curriculum_titolopersonale_4a9487af;
       public         alfioemanuele    false    269            U           1259    621404 #   curriculum_titolopersonale_5cd09f51    INDEX     k   CREATE INDEX curriculum_titolopersonale_5cd09f51 ON curriculum_titolopersonale USING btree (codice_corso);
 7   DROP INDEX public.curriculum_titolopersonale_5cd09f51;
       public         alfioemanuele    false    269            V           1259    621400 #   curriculum_titolopersonale_69bd2e5f    INDEX     n   CREATE INDEX curriculum_titolopersonale_69bd2e5f ON curriculum_titolopersonale USING btree (ultima_modifica);
 7   DROP INDEX public.curriculum_titolopersonale_69bd2e5f;
       public         alfioemanuele    false    269            W           1259    621405 #   curriculum_titolopersonale_a4c17435    INDEX     p   CREATE INDEX curriculum_titolopersonale_a4c17435 ON curriculum_titolopersonale USING btree (certificato_da_id);
 7   DROP INDEX public.curriculum_titolopersonale_a4c17435;
       public         alfioemanuele    false    269            X           1259    621408 /   curriculum_titolopersonale_codice_b6ced81c_like    INDEX     �   CREATE INDEX curriculum_titolopersonale_codice_b6ced81c_like ON curriculum_titolopersonale USING btree (codice varchar_pattern_ops);
 C   DROP INDEX public.curriculum_titolopersonale_codice_b6ced81c_like;
       public         alfioemanuele    false    269            Y           1259    621409 5   curriculum_titolopersonale_codice_corso_d680009e_like    INDEX     �   CREATE INDEX curriculum_titolopersonale_codice_corso_d680009e_like ON curriculum_titolopersonale USING btree (codice_corso varchar_pattern_ops);
 I   DROP INDEX public.curriculum_titolopersonale_codice_corso_d680009e_like;
       public         alfioemanuele    false    269            Z           1259    621407 #   curriculum_titolopersonale_df36e023    INDEX     h   CREATE INDEX curriculum_titolopersonale_df36e023 ON curriculum_titolopersonale USING btree (titolo_id);
 7   DROP INDEX public.curriculum_titolopersonale_df36e023;
       public         alfioemanuele    false    269            [           1259    621403 #   curriculum_titolopersonale_df5c2c5c    INDEX     e   CREATE INDEX curriculum_titolopersonale_df5c2c5c ON curriculum_titolopersonale USING btree (codice);
 7   DROP INDEX public.curriculum_titolopersonale_df5c2c5c;
       public         alfioemanuele    false    269            \           1259    621406 #   curriculum_titolopersonale_e8589820    INDEX     i   CREATE INDEX curriculum_titolopersonale_e8589820 ON curriculum_titolopersonale USING btree (persona_id);
 7   DROP INDEX public.curriculum_titolopersonale_e8589820;
       public         alfioemanuele    false    269            �           1259    620280    django_admin_log_417f1b1c    INDEX     Z   CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);
 -   DROP INDEX public.django_admin_log_417f1b1c;
       public         alfioemanuele    false    243            �           1259    620281    django_admin_log_e8701ad4    INDEX     R   CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);
 -   DROP INDEX public.django_admin_log_e8701ad4;
       public         alfioemanuele    false    243            _           1259    621432    django_cron_cronjoblog_305d2889    INDEX     _   CREATE INDEX django_cron_cronjoblog_305d2889 ON django_cron_cronjoblog USING btree (end_time);
 3   DROP INDEX public.django_cron_cronjoblog_305d2889;
       public         alfioemanuele    false    271            `           1259    621433    django_cron_cronjoblog_a05e4b70    INDEX     b   CREATE INDEX django_cron_cronjoblog_a05e4b70 ON django_cron_cronjoblog USING btree (ran_at_time);
 3   DROP INDEX public.django_cron_cronjoblog_a05e4b70;
       public         alfioemanuele    false    271            a           1259    621430    django_cron_cronjoblog_c1336794    INDEX     [   CREATE INDEX django_cron_cronjoblog_c1336794 ON django_cron_cronjoblog USING btree (code);
 3   DROP INDEX public.django_cron_cronjoblog_c1336794;
       public         alfioemanuele    false    271            b           1259    621431    django_cron_cronjoblog_c4d98dbd    INDEX     a   CREATE INDEX django_cron_cronjoblog_c4d98dbd ON django_cron_cronjoblog USING btree (start_time);
 3   DROP INDEX public.django_cron_cronjoblog_c4d98dbd;
       public         alfioemanuele    false    271            c           1259    621434 )   django_cron_cronjoblog_code_48865653_like    INDEX     y   CREATE INDEX django_cron_cronjoblog_code_48865653_like ON django_cron_cronjoblog USING btree (code varchar_pattern_ops);
 =   DROP INDEX public.django_cron_cronjoblog_code_48865653_like;
       public         alfioemanuele    false    271            d           1259    621428 (   django_cron_cronjoblog_code_4fc78f9d_idx    INDEX     p   CREATE INDEX django_cron_cronjoblog_code_4fc78f9d_idx ON django_cron_cronjoblog USING btree (code, start_time);
 <   DROP INDEX public.django_cron_cronjoblog_code_4fc78f9d_idx;
       public         alfioemanuele    false    271    271            e           1259    621427 (   django_cron_cronjoblog_code_84da9606_idx    INDEX     }   CREATE INDEX django_cron_cronjoblog_code_84da9606_idx ON django_cron_cronjoblog USING btree (code, is_success, ran_at_time);
 <   DROP INDEX public.django_cron_cronjoblog_code_84da9606_idx;
       public         alfioemanuele    false    271    271    271            f           1259    621429 (   django_cron_cronjoblog_code_8b50b8fa_idx    INDEX     }   CREATE INDEX django_cron_cronjoblog_code_8b50b8fa_idx ON django_cron_cronjoblog USING btree (code, start_time, ran_at_time);
 <   DROP INDEX public.django_cron_cronjoblog_code_8b50b8fa_idx;
       public         alfioemanuele    false    271    271    271            �           1259    621883    django_session_de54fa62    INDEX     R   CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);
 +   DROP INDEX public.django_session_de54fa62;
       public         alfioemanuele    false    298            �           1259    621884 (   django_session_session_key_c0390e0f_like    INDEX     w   CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public         alfioemanuele    false    298            �           1259    621895     django_site_domain_a2e37b91_like    INDEX     g   CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);
 4   DROP INDEX public.django_site_domain_a2e37b91_like;
       public         alfioemanuele    false    300            i           1259    621495    formazione_aspirante_29a104e3    INDEX     _   CREATE INDEX formazione_aspirante_29a104e3 ON formazione_aspirante USING btree (locazione_id);
 1   DROP INDEX public.formazione_aspirante_29a104e3;
       public         alfioemanuele    false    273            j           1259    621493    formazione_aspirante_36063dc9    INDEX     \   CREATE INDEX formazione_aspirante_36063dc9 ON formazione_aspirante USING btree (creazione);
 1   DROP INDEX public.formazione_aspirante_36063dc9;
       public         alfioemanuele    false    273            k           1259    621494    formazione_aspirante_69bd2e5f    INDEX     b   CREATE INDEX formazione_aspirante_69bd2e5f ON formazione_aspirante USING btree (ultima_modifica);
 1   DROP INDEX public.formazione_aspirante_69bd2e5f;
       public         alfioemanuele    false    273            p           1259    621587 )   formazione_aspirante_raggio_1d2fe13c_uniq    INDEX     e   CREATE INDEX formazione_aspirante_raggio_1d2fe13c_uniq ON formazione_aspirante USING btree (raggio);
 =   DROP INDEX public.formazione_aspirante_raggio_1d2fe13c_uniq;
       public         alfioemanuele    false    273            q           1259    621548 $   formazione_assenzacorsobase_13c52846    INDEX     k   CREATE INDEX formazione_assenzacorsobase_13c52846 ON formazione_assenzacorsobase USING btree (lezione_id);
 8   DROP INDEX public.formazione_assenzacorsobase_13c52846;
       public         alfioemanuele    false    275            r           1259    621496 $   formazione_assenzacorsobase_36063dc9    INDEX     j   CREATE INDEX formazione_assenzacorsobase_36063dc9 ON formazione_assenzacorsobase USING btree (creazione);
 8   DROP INDEX public.formazione_assenzacorsobase_36063dc9;
       public         alfioemanuele    false    275            s           1259    621497 $   formazione_assenzacorsobase_69bd2e5f    INDEX     p   CREATE INDEX formazione_assenzacorsobase_69bd2e5f ON formazione_assenzacorsobase USING btree (ultima_modifica);
 8   DROP INDEX public.formazione_assenzacorsobase_69bd2e5f;
       public         alfioemanuele    false    275            t           1259    621560 $   formazione_assenzacorsobase_b66de96c    INDEX     q   CREATE INDEX formazione_assenzacorsobase_b66de96c ON formazione_assenzacorsobase USING btree (registrata_da_id);
 8   DROP INDEX public.formazione_assenzacorsobase_b66de96c;
       public         alfioemanuele    false    275            u           1259    621554 $   formazione_assenzacorsobase_e8589820    INDEX     k   CREATE INDEX formazione_assenzacorsobase_e8589820 ON formazione_assenzacorsobase USING btree (persona_id);
 8   DROP INDEX public.formazione_assenzacorsobase_e8589820;
       public         alfioemanuele    false    275            x           1259    621513    formazione_corsobase_0687f864    INDEX     Z   CREATE INDEX formazione_corsobase_0687f864 ON formazione_corsobase USING btree (sede_id);
 1   DROP INDEX public.formazione_corsobase_0687f864;
       public         alfioemanuele    false    277            y           1259    621512    formazione_corsobase_29a104e3    INDEX     _   CREATE INDEX formazione_corsobase_29a104e3 ON formazione_corsobase USING btree (locazione_id);
 1   DROP INDEX public.formazione_corsobase_29a104e3;
       public         alfioemanuele    false    277            z           1259    621508    formazione_corsobase_36063dc9    INDEX     \   CREATE INDEX formazione_corsobase_36063dc9 ON formazione_corsobase USING btree (creazione);
 1   DROP INDEX public.formazione_corsobase_36063dc9;
       public         alfioemanuele    false    277            {           1259    621509    formazione_corsobase_69bd2e5f    INDEX     b   CREATE INDEX formazione_corsobase_69bd2e5f ON formazione_corsobase USING btree (ultima_modifica);
 1   DROP INDEX public.formazione_corsobase_69bd2e5f;
       public         alfioemanuele    false    277            |           1259    621510    formazione_corsobase_6b81ba8e    INDEX     ^   CREATE INDEX formazione_corsobase_6b81ba8e ON formazione_corsobase USING btree (progressivo);
 1   DROP INDEX public.formazione_corsobase_6b81ba8e;
       public         alfioemanuele    false    277            }           1259    621566    formazione_corsobase_d6ef5c1f    INDEX     ]   CREATE INDEX formazione_corsobase_d6ef5c1f ON formazione_corsobase USING btree (vecchio_id);
 1   DROP INDEX public.formazione_corsobase_d6ef5c1f;
       public         alfioemanuele    false    277            ~           1259    621511    formazione_corsobase_ddc70b20    INDEX     W   CREATE INDEX formazione_corsobase_ddc70b20 ON formazione_corsobase USING btree (anno);
 1   DROP INDEX public.formazione_corsobase_ddc70b20;
       public         alfioemanuele    false    277            �           1259    621519 $   formazione_lezionecorsobase_36063dc9    INDEX     j   CREATE INDEX formazione_lezionecorsobase_36063dc9 ON formazione_lezionecorsobase USING btree (creazione);
 8   DROP INDEX public.formazione_lezionecorsobase_36063dc9;
       public         alfioemanuele    false    279            �           1259    621520 $   formazione_lezionecorsobase_69bd2e5f    INDEX     p   CREATE INDEX formazione_lezionecorsobase_69bd2e5f ON formazione_lezionecorsobase USING btree (ultima_modifica);
 8   DROP INDEX public.formazione_lezionecorsobase_69bd2e5f;
       public         alfioemanuele    false    279            �           1259    621523 $   formazione_lezionecorsobase_7d9c2dba    INDEX     i   CREATE INDEX formazione_lezionecorsobase_7d9c2dba ON formazione_lezionecorsobase USING btree (corso_id);
 8   DROP INDEX public.formazione_lezionecorsobase_7d9c2dba;
       public         alfioemanuele    false    279            �           1259    621521 $   formazione_lezionecorsobase_7df656af    INDEX     g   CREATE INDEX formazione_lezionecorsobase_7df656af ON formazione_lezionecorsobase USING btree (inizio);
 8   DROP INDEX public.formazione_lezionecorsobase_7df656af;
       public         alfioemanuele    false    279            �           1259    621522 $   formazione_lezionecorsobase_fff25994    INDEX     e   CREATE INDEX formazione_lezionecorsobase_fff25994 ON formazione_lezionecorsobase USING btree (fine);
 8   DROP INDEX public.formazione_lezionecorsobase_fff25994;
       public         alfioemanuele    false    279            �           1259    621538 +   formazione_partecipazionecorsobase_057ae320    INDEX     z   CREATE INDEX formazione_partecipazionecorsobase_057ae320 ON formazione_partecipazionecorsobase USING btree (esito_esame);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_057ae320;
       public         alfioemanuele    false    281            �           1259    621534 +   formazione_partecipazionecorsobase_36063dc9    INDEX     x   CREATE INDEX formazione_partecipazionecorsobase_36063dc9 ON formazione_partecipazionecorsobase USING btree (creazione);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_36063dc9;
       public         alfioemanuele    false    281            �           1259    621536 +   formazione_partecipazionecorsobase_43662d06    INDEX     y   CREATE INDEX formazione_partecipazionecorsobase_43662d06 ON formazione_partecipazionecorsobase USING btree (confermata);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_43662d06;
       public         alfioemanuele    false    281            �           1259    621537 +   formazione_partecipazionecorsobase_4a9487af    INDEX     w   CREATE INDEX formazione_partecipazionecorsobase_4a9487af ON formazione_partecipazionecorsobase USING btree (ritirata);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_4a9487af;
       public         alfioemanuele    false    281            �           1259    621535 +   formazione_partecipazionecorsobase_69bd2e5f    INDEX     ~   CREATE INDEX formazione_partecipazionecorsobase_69bd2e5f ON formazione_partecipazionecorsobase USING btree (ultima_modifica);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_69bd2e5f;
       public         alfioemanuele    false    281            �           1259    621542 +   formazione_partecipazionecorsobase_7d9c2dba    INDEX     w   CREATE INDEX formazione_partecipazionecorsobase_7d9c2dba ON formazione_partecipazionecorsobase USING btree (corso_id);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_7d9c2dba;
       public         alfioemanuele    false    281            �           1259    621539 +   formazione_partecipazionecorsobase_95c12757    INDEX     y   CREATE INDEX formazione_partecipazionecorsobase_95c12757 ON formazione_partecipazionecorsobase USING btree (ammissione);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_95c12757;
       public         alfioemanuele    false    281            �           1259    621541 +   formazione_partecipazionecorsobase_9ffeed07    INDEX     |   CREATE INDEX formazione_partecipazionecorsobase_9ffeed07 ON formazione_partecipazionecorsobase USING btree (esito_parte_2);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_9ffeed07;
       public         alfioemanuele    false    281            �           1259    621540 +   formazione_partecipazionecorsobase_ae23e0a9    INDEX     |   CREATE INDEX formazione_partecipazionecorsobase_ae23e0a9 ON formazione_partecipazionecorsobase USING btree (esito_parte_1);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_ae23e0a9;
       public         alfioemanuele    false    281            �           1259    621545 ;   formazione_partecipazionecorsobase_ammissione_c2a4220a_like    INDEX     �   CREATE INDEX formazione_partecipazionecorsobase_ammissione_c2a4220a_like ON formazione_partecipazionecorsobase USING btree (ammissione varchar_pattern_ops);
 O   DROP INDEX public.formazione_partecipazionecorsobase_ammissione_c2a4220a_like;
       public         alfioemanuele    false    281            �           1259    621630 +   formazione_partecipazionecorsobase_cb8e6a80    INDEX     ~   CREATE INDEX formazione_partecipazionecorsobase_cb8e6a80 ON formazione_partecipazionecorsobase USING btree (destinazione_id);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_cb8e6a80;
       public         alfioemanuele    false    281            �           1259    621543 +   formazione_partecipazionecorsobase_e8589820    INDEX     y   CREATE INDEX formazione_partecipazionecorsobase_e8589820 ON formazione_partecipazionecorsobase USING btree (persona_id);
 ?   DROP INDEX public.formazione_partecipazionecorsobase_e8589820;
       public         alfioemanuele    false    281            �           1259    621544 <   formazione_partecipazionecorsobase_esito_esame_d95ad7bd_like    INDEX     �   CREATE INDEX formazione_partecipazionecorsobase_esito_esame_d95ad7bd_like ON formazione_partecipazionecorsobase USING btree (esito_esame varchar_pattern_ops);
 P   DROP INDEX public.formazione_partecipazionecorsobase_esito_esame_d95ad7bd_like;
       public         alfioemanuele    false    281            �           1259    621546 >   formazione_partecipazionecorsobase_esito_parte_1_e41db682_like    INDEX     �   CREATE INDEX formazione_partecipazionecorsobase_esito_parte_1_e41db682_like ON formazione_partecipazionecorsobase USING btree (esito_parte_1 varchar_pattern_ops);
 R   DROP INDEX public.formazione_partecipazionecorsobase_esito_parte_1_e41db682_like;
       public         alfioemanuele    false    281            �           1259    621547 >   formazione_partecipazionecorsobase_esito_parte_2_1839556d_like    INDEX     �   CREATE INDEX formazione_partecipazionecorsobase_esito_parte_2_1839556d_like ON formazione_partecipazionecorsobase USING btree (esito_parte_2 varchar_pattern_ops);
 R   DROP INDEX public.formazione_partecipazionecorsobase_esito_parte_2_1839556d_like;
       public         alfioemanuele    false    281            �           1259    621688    gruppi_appartenenza_179ac911    INDEX     ]   CREATE INDEX gruppi_appartenenza_179ac911 ON gruppi_appartenenza USING btree (negato_da_id);
 0   DROP INDEX public.gruppi_appartenenza_179ac911;
       public         alfioemanuele    false    283            �           1259    621682    gruppi_appartenenza_2a93eda0    INDEX     Z   CREATE INDEX gruppi_appartenenza_2a93eda0 ON gruppi_appartenenza USING btree (gruppo_id);
 0   DROP INDEX public.gruppi_appartenenza_2a93eda0;
       public         alfioemanuele    false    283            �           1259    621655    gruppi_appartenenza_36063dc9    INDEX     Z   CREATE INDEX gruppi_appartenenza_36063dc9 ON gruppi_appartenenza USING btree (creazione);
 0   DROP INDEX public.gruppi_appartenenza_36063dc9;
       public         alfioemanuele    false    283            �           1259    621656    gruppi_appartenenza_69bd2e5f    INDEX     `   CREATE INDEX gruppi_appartenenza_69bd2e5f ON gruppi_appartenenza USING btree (ultima_modifica);
 0   DROP INDEX public.gruppi_appartenenza_69bd2e5f;
       public         alfioemanuele    false    283            �           1259    621657    gruppi_appartenenza_7df656af    INDEX     W   CREATE INDEX gruppi_appartenenza_7df656af ON gruppi_appartenenza USING btree (inizio);
 0   DROP INDEX public.gruppi_appartenenza_7df656af;
       public         alfioemanuele    false    283            �           1259    621694    gruppi_appartenenza_e8589820    INDEX     [   CREATE INDEX gruppi_appartenenza_e8589820 ON gruppi_appartenenza USING btree (persona_id);
 0   DROP INDEX public.gruppi_appartenenza_e8589820;
       public         alfioemanuele    false    283            �           1259    621658    gruppi_appartenenza_fff25994    INDEX     U   CREATE INDEX gruppi_appartenenza_fff25994 ON gruppi_appartenenza USING btree (fine);
 0   DROP INDEX public.gruppi_appartenenza_fff25994;
       public         alfioemanuele    false    283            �           1259    621680    gruppi_gruppo_0687f864    INDEX     L   CREATE INDEX gruppi_gruppo_0687f864 ON gruppi_gruppo USING btree (sede_id);
 *   DROP INDEX public.gruppi_gruppo_0687f864;
       public         alfioemanuele    false    285            �           1259    621674    gruppi_gruppo_36063dc9    INDEX     N   CREATE INDEX gruppi_gruppo_36063dc9 ON gruppi_gruppo USING btree (creazione);
 *   DROP INDEX public.gruppi_gruppo_36063dc9;
       public         alfioemanuele    false    285            �           1259    621679    gruppi_gruppo_3abe1833    INDEX     P   CREATE INDEX gruppi_gruppo_3abe1833 ON gruppi_gruppo USING btree (attivita_id);
 *   DROP INDEX public.gruppi_gruppo_3abe1833;
       public         alfioemanuele    false    285            �           1259    621675    gruppi_gruppo_69bd2e5f    INDEX     T   CREATE INDEX gruppi_gruppo_69bd2e5f ON gruppi_gruppo USING btree (ultima_modifica);
 *   DROP INDEX public.gruppi_gruppo_69bd2e5f;
       public         alfioemanuele    false    285            �           1259    621677    gruppi_gruppo_cefdb931    INDEX     N   CREATE INDEX gruppi_gruppo_cefdb931 ON gruppi_gruppo USING btree (obiettivo);
 *   DROP INDEX public.gruppi_gruppo_cefdb931;
       public         alfioemanuele    false    285            �           1259    621678    gruppi_gruppo_d266de13    INDEX     L   CREATE INDEX gruppi_gruppo_d266de13 ON gruppi_gruppo USING btree (area_id);
 *   DROP INDEX public.gruppi_gruppo_d266de13;
       public         alfioemanuele    false    285            �           1259    621676    gruppi_gruppo_dbb9a234    INDEX     O   CREATE INDEX gruppi_gruppo_dbb9a234 ON gruppi_gruppo USING btree (estensione);
 *   DROP INDEX public.gruppi_gruppo_dbb9a234;
       public         alfioemanuele    false    285            �           1259    621681 &   gruppi_gruppo_estensione_0c1e2168_like    INDEX     s   CREATE INDEX gruppi_gruppo_estensione_0c1e2168_like ON gruppi_gruppo USING btree (estensione varchar_pattern_ops);
 :   DROP INDEX public.gruppi_gruppo_estensione_0c1e2168_like;
       public         alfioemanuele    false    285            �           1259    619889    patenti_elemento_36063dc9    INDEX     T   CREATE INDEX patenti_elemento_36063dc9 ON patenti_elemento USING btree (creazione);
 -   DROP INDEX public.patenti_elemento_36063dc9;
       public         alfioemanuele    false    202            �           1259    619891    patenti_elemento_43662d06    INDEX     U   CREATE INDEX patenti_elemento_43662d06 ON patenti_elemento USING btree (confermata);
 -   DROP INDEX public.patenti_elemento_43662d06;
       public         alfioemanuele    false    202            �           1259    619892    patenti_elemento_4a9487af    INDEX     S   CREATE INDEX patenti_elemento_4a9487af ON patenti_elemento USING btree (ritirata);
 -   DROP INDEX public.patenti_elemento_4a9487af;
       public         alfioemanuele    false    202            �           1259    619890    patenti_elemento_69bd2e5f    INDEX     Z   CREATE INDEX patenti_elemento_69bd2e5f ON patenti_elemento USING btree (ultima_modifica);
 -   DROP INDEX public.patenti_elemento_69bd2e5f;
       public         alfioemanuele    false    202            �           1259    619887    patenti_patente_36063dc9    INDEX     R   CREATE INDEX patenti_patente_36063dc9 ON patenti_patente USING btree (creazione);
 ,   DROP INDEX public.patenti_patente_36063dc9;
       public         alfioemanuele    false    200            �           1259    619888    patenti_patente_69bd2e5f    INDEX     X   CREATE INDEX patenti_patente_69bd2e5f ON patenti_patente USING btree (ultima_modifica);
 ,   DROP INDEX public.patenti_patente_69bd2e5f;
       public         alfioemanuele    false    200            �           1259    621736    posta_destinatario_36063dc9    INDEX     X   CREATE INDEX posta_destinatario_36063dc9 ON posta_destinatario USING btree (creazione);
 /   DROP INDEX public.posta_destinatario_36063dc9;
       public         alfioemanuele    false    287            �           1259    621737    posta_destinatario_69bd2e5f    INDEX     ^   CREATE INDEX posta_destinatario_69bd2e5f ON posta_destinatario USING btree (ultima_modifica);
 /   DROP INDEX public.posta_destinatario_69bd2e5f;
       public         alfioemanuele    false    287            �           1259    621754    posta_destinatario_e8589820    INDEX     Y   CREATE INDEX posta_destinatario_e8589820 ON posta_destinatario USING btree (persona_id);
 /   DROP INDEX public.posta_destinatario_e8589820;
       public         alfioemanuele    false    287            �           1259    621774 '   posta_destinatario_errore_676732c7_like    INDEX     u   CREATE INDEX posta_destinatario_errore_676732c7_like ON posta_destinatario USING btree (errore varchar_pattern_ops);
 ;   DROP INDEX public.posta_destinatario_errore_676732c7_like;
       public         alfioemanuele    false    287            �           1259    621773 '   posta_destinatario_errore_676732c7_uniq    INDEX     a   CREATE INDEX posta_destinatario_errore_676732c7_uniq ON posta_destinatario USING btree (errore);
 ;   DROP INDEX public.posta_destinatario_errore_676732c7_uniq;
       public         alfioemanuele    false    287            �           1259    621748    posta_destinatario_f7a5b550    INDEX     [   CREATE INDEX posta_destinatario_f7a5b550 ON posta_destinatario USING btree (messaggio_id);
 /   DROP INDEX public.posta_destinatario_f7a5b550;
       public         alfioemanuele    false    287            �           1259    621775 (   posta_destinatario_inviato_b20d2d83_uniq    INDEX     c   CREATE INDEX posta_destinatario_inviato_b20d2d83_uniq ON posta_destinatario USING btree (inviato);
 <   DROP INDEX public.posta_destinatario_inviato_b20d2d83_uniq;
       public         alfioemanuele    false    287            �           1259    621776 *   posta_destinatario_tentativo_4685f3b8_uniq    INDEX     g   CREATE INDEX posta_destinatario_tentativo_4685f3b8_uniq ON posta_destinatario USING btree (tentativo);
 >   DROP INDEX public.posta_destinatario_tentativo_4685f3b8_uniq;
       public         alfioemanuele    false    287            �           1259    621743    posta_messaggio_36063dc9    INDEX     R   CREATE INDEX posta_messaggio_36063dc9 ON posta_messaggio USING btree (creazione);
 ,   DROP INDEX public.posta_messaggio_36063dc9;
       public         alfioemanuele    false    289            �           1259    621778    posta_messaggio_4ca5d3ec    INDEX     P   CREATE INDEX posta_messaggio_4ca5d3ec ON posta_messaggio USING btree (oggetto);
 ,   DROP INDEX public.posta_messaggio_4ca5d3ec;
       public         alfioemanuele    false    289            �           1259    621744    posta_messaggio_69bd2e5f    INDEX     X   CREATE INDEX posta_messaggio_69bd2e5f ON posta_messaggio USING btree (ultima_modifica);
 ,   DROP INDEX public.posta_messaggio_69bd2e5f;
       public         alfioemanuele    false    289            �           1259    621746    posta_messaggio_a8472066    INDEX     T   CREATE INDEX posta_messaggio_a8472066 ON posta_messaggio USING btree (mittente_id);
 ,   DROP INDEX public.posta_messaggio_a8472066;
       public         alfioemanuele    false    289            �           1259    621767    posta_messaggio_db29de29    INDEX     V   CREATE INDEX posta_messaggio_db29de29 ON posta_messaggio USING btree (rispondi_a_id);
 ,   DROP INDEX public.posta_messaggio_db29de29;
       public         alfioemanuele    false    289            �           1259    621777 %   posta_messaggio_oggetto_a0c88b4e_like    INDEX     q   CREATE INDEX posta_messaggio_oggetto_a0c88b4e_like ON posta_messaggio USING btree (oggetto varchar_pattern_ops);
 9   DROP INDEX public.posta_messaggio_oggetto_a0c88b4e_like;
       public         alfioemanuele    false    289            �           1259    621821    sangue_donatore_2ca2c264    INDEX     S   CREATE INDEX sangue_donatore_2ca2c264 ON sangue_donatore USING btree (fattore_rh);
 ,   DROP INDEX public.sangue_donatore_2ca2c264;
       public         alfioemanuele    false    291            �           1259    621818    sangue_donatore_36063dc9    INDEX     R   CREATE INDEX sangue_donatore_36063dc9 ON sangue_donatore USING btree (creazione);
 ,   DROP INDEX public.sangue_donatore_36063dc9;
       public         alfioemanuele    false    291            �           1259    621822    sangue_donatore_458a48a0    INDEX     T   CREATE INDEX sangue_donatore_458a48a0 ON sangue_donatore USING btree (fanotipo_rh);
 ,   DROP INDEX public.sangue_donatore_458a48a0;
       public         alfioemanuele    false    291            �           1259    621819    sangue_donatore_69bd2e5f    INDEX     X   CREATE INDEX sangue_donatore_69bd2e5f ON sangue_donatore USING btree (ultima_modifica);
 ,   DROP INDEX public.sangue_donatore_69bd2e5f;
       public         alfioemanuele    false    291            �           1259    621856    sangue_donatore_8ab2456d    INDEX     T   CREATE INDEX sangue_donatore_8ab2456d ON sangue_donatore USING btree (sede_sit_id);
 ,   DROP INDEX public.sangue_donatore_8ab2456d;
       public         alfioemanuele    false    291            �           1259    621823    sangue_donatore_921254a0    INDEX     S   CREATE INDEX sangue_donatore_921254a0 ON sangue_donatore USING btree (codice_sit);
 ,   DROP INDEX public.sangue_donatore_921254a0;
       public         alfioemanuele    false    291            �           1259    621827 (   sangue_donatore_codice_sit_44e79323_like    INDEX     w   CREATE INDEX sangue_donatore_codice_sit_44e79323_like ON sangue_donatore USING btree (codice_sit varchar_pattern_ops);
 <   DROP INDEX public.sangue_donatore_codice_sit_44e79323_like;
       public         alfioemanuele    false    291            �           1259    621820    sangue_donatore_d456622a    INDEX     Y   CREATE INDEX sangue_donatore_d456622a ON sangue_donatore USING btree (gruppo_sanguigno);
 ,   DROP INDEX public.sangue_donatore_d456622a;
       public         alfioemanuele    false    291            �           1259    621826 )   sangue_donatore_fanotipo_rh_ce13bb26_like    INDEX     y   CREATE INDEX sangue_donatore_fanotipo_rh_ce13bb26_like ON sangue_donatore USING btree (fanotipo_rh varchar_pattern_ops);
 =   DROP INDEX public.sangue_donatore_fanotipo_rh_ce13bb26_like;
       public         alfioemanuele    false    291            �           1259    621825 (   sangue_donatore_fattore_rh_e988c055_like    INDEX     w   CREATE INDEX sangue_donatore_fattore_rh_e988c055_like ON sangue_donatore USING btree (fattore_rh varchar_pattern_ops);
 <   DROP INDEX public.sangue_donatore_fattore_rh_e988c055_like;
       public         alfioemanuele    false    291            �           1259    621824 .   sangue_donatore_gruppo_sanguigno_493a48ff_like    INDEX     �   CREATE INDEX sangue_donatore_gruppo_sanguigno_493a48ff_like ON sangue_donatore USING btree (gruppo_sanguigno varchar_pattern_ops);
 B   DROP INDEX public.sangue_donatore_gruppo_sanguigno_493a48ff_like;
       public         alfioemanuele    false    291            �           1259    621850    sangue_donazione_0687f864    INDEX     R   CREATE INDEX sangue_donazione_0687f864 ON sangue_donazione USING btree (sede_id);
 -   DROP INDEX public.sangue_donazione_0687f864;
       public         alfioemanuele    false    293            �           1259    621833    sangue_donazione_36063dc9    INDEX     T   CREATE INDEX sangue_donazione_36063dc9 ON sangue_donazione USING btree (creazione);
 -   DROP INDEX public.sangue_donazione_36063dc9;
       public         alfioemanuele    false    293            �           1259    621837    sangue_donazione_401281b0    INDEX     O   CREATE INDEX sangue_donazione_401281b0 ON sangue_donazione USING btree (tipo);
 -   DROP INDEX public.sangue_donazione_401281b0;
       public         alfioemanuele    false    293            �           1259    621835    sangue_donazione_43662d06    INDEX     U   CREATE INDEX sangue_donazione_43662d06 ON sangue_donazione USING btree (confermata);
 -   DROP INDEX public.sangue_donazione_43662d06;
       public         alfioemanuele    false    293            �           1259    621836    sangue_donazione_4a9487af    INDEX     S   CREATE INDEX sangue_donazione_4a9487af ON sangue_donazione USING btree (ritirata);
 -   DROP INDEX public.sangue_donazione_4a9487af;
       public         alfioemanuele    false    293            �           1259    621834    sangue_donazione_69bd2e5f    INDEX     Z   CREATE INDEX sangue_donazione_69bd2e5f ON sangue_donazione USING btree (ultima_modifica);
 -   DROP INDEX public.sangue_donazione_69bd2e5f;
       public         alfioemanuele    false    293            �           1259    621838    sangue_donazione_e8589820    INDEX     U   CREATE INDEX sangue_donazione_e8589820 ON sangue_donazione USING btree (persona_id);
 -   DROP INDEX public.sangue_donazione_e8589820;
       public         alfioemanuele    false    293            �           1259    621839 #   sangue_donazione_tipo_4067a24a_like    INDEX     m   CREATE INDEX sangue_donazione_tipo_4067a24a_like ON sangue_donazione USING btree (tipo varchar_pattern_ops);
 7   DROP INDEX public.sangue_donazione_tipo_4067a24a_like;
       public         alfioemanuele    false    293            �           1259    621845    sangue_merito_36063dc9    INDEX     N   CREATE INDEX sangue_merito_36063dc9 ON sangue_merito USING btree (creazione);
 *   DROP INDEX public.sangue_merito_36063dc9;
       public         alfioemanuele    false    295            �           1259    621846    sangue_merito_69bd2e5f    INDEX     T   CREATE INDEX sangue_merito_69bd2e5f ON sangue_merito USING btree (ultima_modifica);
 *   DROP INDEX public.sangue_merito_69bd2e5f;
       public         alfioemanuele    false    295            �           1259    621847    sangue_merito_bd4ddd0a    INDEX     N   CREATE INDEX sangue_merito_bd4ddd0a ON sangue_merito USING btree (donazione);
 *   DROP INDEX public.sangue_merito_bd4ddd0a;
       public         alfioemanuele    false    295            �           1259    621849 %   sangue_merito_donazione_7fbd7550_like    INDEX     q   CREATE INDEX sangue_merito_donazione_7fbd7550_like ON sangue_merito USING btree (donazione varchar_pattern_ops);
 9   DROP INDEX public.sangue_merito_donazione_7fbd7550_like;
       public         alfioemanuele    false    295            �           1259    621848    sangue_merito_e8589820    INDEX     O   CREATE INDEX sangue_merito_e8589820 ON sangue_merito USING btree (persona_id);
 *   DROP INDEX public.sangue_merito_e8589820;
       public         alfioemanuele    false    295            �           1259    621927    social_commento_36063dc9    INDEX     R   CREATE INDEX social_commento_36063dc9 ON social_commento USING btree (creazione);
 ,   DROP INDEX public.social_commento_36063dc9;
       public         alfioemanuele    false    302            �           1259    621928    social_commento_69bd2e5f    INDEX     X   CREATE INDEX social_commento_69bd2e5f ON social_commento USING btree (ultima_modifica);
 ,   DROP INDEX public.social_commento_69bd2e5f;
       public         alfioemanuele    false    302            �           1259    621929    social_commento_9c82ce86    INDEX     S   CREATE INDEX social_commento_9c82ce86 ON social_commento USING btree (oggetto_id);
 ,   DROP INDEX public.social_commento_9c82ce86;
       public         alfioemanuele    false    302            �           1259    621930    social_commento_fa6f1f24    INDEX     R   CREATE INDEX social_commento_fa6f1f24 ON social_commento USING btree (autore_id);
 ,   DROP INDEX public.social_commento_fa6f1f24;
       public         alfioemanuele    false    302            �           1259    621931    social_commento_fe2a0979    INDEX     X   CREATE INDEX social_commento_fe2a0979 ON social_commento USING btree (oggetto_tipo_id);
 ,   DROP INDEX public.social_commento_fe2a0979;
       public         alfioemanuele    false    302            �           1259    621944    social_giudizio_20e6d3fc    INDEX     Q   CREATE INDEX social_giudizio_20e6d3fc ON social_giudizio USING btree (positivo);
 ,   DROP INDEX public.social_giudizio_20e6d3fc;
       public         alfioemanuele    false    304            �           1259    621942    social_giudizio_36063dc9    INDEX     R   CREATE INDEX social_giudizio_36063dc9 ON social_giudizio USING btree (creazione);
 ,   DROP INDEX public.social_giudizio_36063dc9;
       public         alfioemanuele    false    304            �           1259    621943    social_giudizio_69bd2e5f    INDEX     X   CREATE INDEX social_giudizio_69bd2e5f ON social_giudizio USING btree (ultima_modifica);
 ,   DROP INDEX public.social_giudizio_69bd2e5f;
       public         alfioemanuele    false    304            �           1259    621945    social_giudizio_9c82ce86    INDEX     S   CREATE INDEX social_giudizio_9c82ce86 ON social_giudizio USING btree (oggetto_id);
 ,   DROP INDEX public.social_giudizio_9c82ce86;
       public         alfioemanuele    false    304            �           1259    621946    social_giudizio_fa6f1f24    INDEX     R   CREATE INDEX social_giudizio_fa6f1f24 ON social_giudizio USING btree (autore_id);
 ,   DROP INDEX public.social_giudizio_fa6f1f24;
       public         alfioemanuele    false    304            �           1259    621947    social_giudizio_fe2a0979    INDEX     X   CREATE INDEX social_giudizio_fe2a0979 ON social_giudizio USING btree (oggetto_tipo_id);
 ,   DROP INDEX public.social_giudizio_fe2a0979;
       public         alfioemanuele    false    304            �           1259    619893 #   thumbnail_kvstore_key_3f850178_like    INDEX     m   CREATE INDEX thumbnail_kvstore_key_3f850178_like ON thumbnail_kvstore USING btree (key varchar_pattern_ops);
 7   DROP INDEX public.thumbnail_kvstore_key_3f850178_like;
       public         alfioemanuele    false    203            �           1259    622030    ufficio_soci_quota_0687f864    INDEX     V   CREATE INDEX ufficio_soci_quota_0687f864 ON ufficio_soci_quota USING btree (sede_id);
 /   DROP INDEX public.ufficio_soci_quota_0687f864;
       public         alfioemanuele    false    306            �           1259    622021    ufficio_soci_quota_36063dc9    INDEX     X   CREATE INDEX ufficio_soci_quota_36063dc9 ON ufficio_soci_quota USING btree (creazione);
 /   DROP INDEX public.ufficio_soci_quota_36063dc9;
       public         alfioemanuele    false    306            �           1259    622027    ufficio_soci_quota_530b0ac8    INDEX     ^   CREATE INDEX ufficio_soci_quota_530b0ac8 ON ufficio_soci_quota USING btree (appartenenza_id);
 /   DROP INDEX public.ufficio_soci_quota_530b0ac8;
       public         alfioemanuele    false    306            �           1259    622029    ufficio_soci_quota_5744ea4d    INDEX     _   CREATE INDEX ufficio_soci_quota_5744ea4d ON ufficio_soci_quota USING btree (registrato_da_id);
 /   DROP INDEX public.ufficio_soci_quota_5744ea4d;
       public         alfioemanuele    false    306            �           1259    622022    ufficio_soci_quota_69bd2e5f    INDEX     ^   CREATE INDEX ufficio_soci_quota_69bd2e5f ON ufficio_soci_quota USING btree (ultima_modifica);
 /   DROP INDEX public.ufficio_soci_quota_69bd2e5f;
       public         alfioemanuele    false    306            �           1259    622023    ufficio_soci_quota_6b81ba8e    INDEX     Z   CREATE INDEX ufficio_soci_quota_6b81ba8e ON ufficio_soci_quota USING btree (progressivo);
 /   DROP INDEX public.ufficio_soci_quota_6b81ba8e;
       public         alfioemanuele    false    306            �           1259    622026    ufficio_soci_quota_7b84f719    INDEX     ^   CREATE INDEX ufficio_soci_quota_7b84f719 ON ufficio_soci_quota USING btree (annullato_da_id);
 /   DROP INDEX public.ufficio_soci_quota_7b84f719;
       public         alfioemanuele    false    306            �           1259    622075    ufficio_soci_quota_d6ef5c1f    INDEX     Y   CREATE INDEX ufficio_soci_quota_d6ef5c1f ON ufficio_soci_quota USING btree (vecchio_id);
 /   DROP INDEX public.ufficio_soci_quota_d6ef5c1f;
       public         alfioemanuele    false    306                        1259    622024    ufficio_soci_quota_ddc70b20    INDEX     S   CREATE INDEX ufficio_soci_quota_ddc70b20 ON ufficio_soci_quota USING btree (anno);
 /   DROP INDEX public.ufficio_soci_quota_ddc70b20;
       public         alfioemanuele    false    306                       1259    622025    ufficio_soci_quota_e0b406f5    INDEX     T   CREATE INDEX ufficio_soci_quota_e0b406f5 ON ufficio_soci_quota USING btree (stato);
 /   DROP INDEX public.ufficio_soci_quota_e0b406f5;
       public         alfioemanuele    false    306                       1259    622028    ufficio_soci_quota_e8589820    INDEX     Y   CREATE INDEX ufficio_soci_quota_e8589820 ON ufficio_soci_quota USING btree (persona_id);
 /   DROP INDEX public.ufficio_soci_quota_e8589820;
       public         alfioemanuele    false    306                       1259    622031 &   ufficio_soci_quota_stato_d1d379cb_like    INDEX     s   CREATE INDEX ufficio_soci_quota_stato_d1d379cb_like ON ufficio_soci_quota USING btree (stato varchar_pattern_ops);
 :   DROP INDEX public.ufficio_soci_quota_stato_d1d379cb_like;
       public         alfioemanuele    false    306                       1259    622032 "   ufficio_soci_tesseramento_36063dc9    INDEX     f   CREATE INDEX ufficio_soci_tesseramento_36063dc9 ON ufficio_soci_tesseramento USING btree (creazione);
 6   DROP INDEX public.ufficio_soci_tesseramento_36063dc9;
       public         alfioemanuele    false    308            	           1259    622033 "   ufficio_soci_tesseramento_69bd2e5f    INDEX     l   CREATE INDEX ufficio_soci_tesseramento_69bd2e5f ON ufficio_soci_tesseramento USING btree (ultima_modifica);
 6   DROP INDEX public.ufficio_soci_tesseramento_69bd2e5f;
       public         alfioemanuele    false    308            
           1259    622034 "   ufficio_soci_tesseramento_7df656af    INDEX     c   CREATE INDEX ufficio_soci_tesseramento_7df656af ON ufficio_soci_tesseramento USING btree (inizio);
 6   DROP INDEX public.ufficio_soci_tesseramento_7df656af;
       public         alfioemanuele    false    308                       1259    622067    ufficio_soci_tesserino_029da785    INDEX     g   CREATE INDEX ufficio_soci_tesserino_029da785 ON ufficio_soci_tesserino USING btree (confermato_da_id);
 3   DROP INDEX public.ufficio_soci_tesserino_029da785;
       public         alfioemanuele    false    310                       1259    622066    ufficio_soci_tesserino_1b671890    INDEX     f   CREATE INDEX ufficio_soci_tesserino_1b671890 ON ufficio_soci_tesserino USING btree (data_riconsegna);
 3   DROP INDEX public.ufficio_soci_tesserino_1b671890;
       public         alfioemanuele    false    310                       1259    622060    ufficio_soci_tesserino_36063dc9    INDEX     `   CREATE INDEX ufficio_soci_tesserino_36063dc9 ON ufficio_soci_tesserino USING btree (creazione);
 3   DROP INDEX public.ufficio_soci_tesserino_36063dc9;
       public         alfioemanuele    false    310                       1259    622064    ufficio_soci_tesserino_39d25c20    INDEX     ]   CREATE INDEX ufficio_soci_tesserino_39d25c20 ON ufficio_soci_tesserino USING btree (valido);
 3   DROP INDEX public.ufficio_soci_tesserino_39d25c20;
       public         alfioemanuele    false    310                       1259    622062    ufficio_soci_tesserino_41fbc503    INDEX     e   CREATE INDEX ufficio_soci_tesserino_41fbc503 ON ufficio_soci_tesserino USING btree (tipo_richiesta);
 3   DROP INDEX public.ufficio_soci_tesserino_41fbc503;
       public         alfioemanuele    false    310                       1259    622065    ufficio_soci_tesserino_630672f9    INDEX     d   CREATE INDEX ufficio_soci_tesserino_630672f9 ON ufficio_soci_tesserino USING btree (data_conferma);
 3   DROP INDEX public.ufficio_soci_tesserino_630672f9;
       public         alfioemanuele    false    310                       1259    622061    ufficio_soci_tesserino_69bd2e5f    INDEX     f   CREATE INDEX ufficio_soci_tesserino_69bd2e5f ON ufficio_soci_tesserino USING btree (ultima_modifica);
 3   DROP INDEX public.ufficio_soci_tesserino_69bd2e5f;
       public         alfioemanuele    false    310                       1259    622070    ufficio_soci_tesserino_7b64dbf8    INDEX     f   CREATE INDEX ufficio_soci_tesserino_7b64dbf8 ON ufficio_soci_tesserino USING btree (richiesto_da_id);
 3   DROP INDEX public.ufficio_soci_tesserino_7b64dbf8;
       public         alfioemanuele    false    310                       1259    622063    ufficio_soci_tesserino_89d87e51    INDEX     f   CREATE INDEX ufficio_soci_tesserino_89d87e51 ON ufficio_soci_tesserino USING btree (stato_richiesta);
 3   DROP INDEX public.ufficio_soci_tesserino_89d87e51;
       public         alfioemanuele    false    310                       1259    622068    ufficio_soci_tesserino_9aa329e5    INDEX     c   CREATE INDEX ufficio_soci_tesserino_9aa329e5 ON ufficio_soci_tesserino USING btree (emesso_da_id);
 3   DROP INDEX public.ufficio_soci_tesserino_9aa329e5;
       public         alfioemanuele    false    310                       1259    622071    ufficio_soci_tesserino_b8ae2251    INDEX     h   CREATE INDEX ufficio_soci_tesserino_b8ae2251 ON ufficio_soci_tesserino USING btree (riconsegnato_a_id);
 3   DROP INDEX public.ufficio_soci_tesserino_b8ae2251;
       public         alfioemanuele    false    310                       1259    622074 +   ufficio_soci_tesserino_codice_2c7aee6f_like    INDEX     }   CREATE INDEX ufficio_soci_tesserino_codice_2c7aee6f_like ON ufficio_soci_tesserino USING btree (codice varchar_pattern_ops);
 ?   DROP INDEX public.ufficio_soci_tesserino_codice_2c7aee6f_like;
       public         alfioemanuele    false    310                       1259    622069    ufficio_soci_tesserino_e8589820    INDEX     a   CREATE INDEX ufficio_soci_tesserino_e8589820 ON ufficio_soci_tesserino USING btree (persona_id);
 3   DROP INDEX public.ufficio_soci_tesserino_e8589820;
       public         alfioemanuele    false    310                        1259    622073 4   ufficio_soci_tesserino_stato_richiesta_d92e7f2f_like    INDEX     �   CREATE INDEX ufficio_soci_tesserino_stato_richiesta_d92e7f2f_like ON ufficio_soci_tesserino USING btree (stato_richiesta varchar_pattern_ops);
 H   DROP INDEX public.ufficio_soci_tesserino_stato_richiesta_d92e7f2f_like;
       public         alfioemanuele    false    310            !           1259    622072 3   ufficio_soci_tesserino_tipo_richiesta_2f5d7706_like    INDEX     �   CREATE INDEX ufficio_soci_tesserino_tipo_richiesta_2f5d7706_like ON ufficio_soci_tesserino USING btree (tipo_richiesta varchar_pattern_ops);
 G   DROP INDEX public.ufficio_soci_tesserino_tipo_richiesta_2f5d7706_like;
       public         alfioemanuele    false    310            "           1259    622212    veicoli_autoparco_0687f864    INDEX     T   CREATE INDEX veicoli_autoparco_0687f864 ON veicoli_autoparco USING btree (sede_id);
 .   DROP INDEX public.veicoli_autoparco_0687f864;
       public         alfioemanuele    false    312            #           1259    622211    veicoli_autoparco_29a104e3    INDEX     Y   CREATE INDEX veicoli_autoparco_29a104e3 ON veicoli_autoparco USING btree (locazione_id);
 .   DROP INDEX public.veicoli_autoparco_29a104e3;
       public         alfioemanuele    false    312            $           1259    622208    veicoli_autoparco_36063dc9    INDEX     V   CREATE INDEX veicoli_autoparco_36063dc9 ON veicoli_autoparco USING btree (creazione);
 .   DROP INDEX public.veicoli_autoparco_36063dc9;
       public         alfioemanuele    false    312            %           1259    622209    veicoli_autoparco_69bd2e5f    INDEX     \   CREATE INDEX veicoli_autoparco_69bd2e5f ON veicoli_autoparco USING btree (ultima_modifica);
 .   DROP INDEX public.veicoli_autoparco_69bd2e5f;
       public         alfioemanuele    false    312            &           1259    622210    veicoli_autoparco_dbb9a234    INDEX     W   CREATE INDEX veicoli_autoparco_dbb9a234 ON veicoli_autoparco USING btree (estensione);
 .   DROP INDEX public.veicoli_autoparco_dbb9a234;
       public         alfioemanuele    false    312            '           1259    622213 *   veicoli_autoparco_estensione_202ee0fc_like    INDEX     {   CREATE INDEX veicoli_autoparco_estensione_202ee0fc_like ON veicoli_autoparco USING btree (estensione varchar_pattern_ops);
 >   DROP INDEX public.veicoli_autoparco_estensione_202ee0fc_like;
       public         alfioemanuele    false    312            (           1259    622323 $   veicoli_autoparco_nome_067f35a6_like    INDEX     o   CREATE INDEX veicoli_autoparco_nome_067f35a6_like ON veicoli_autoparco USING btree (nome varchar_pattern_ops);
 8   DROP INDEX public.veicoli_autoparco_nome_067f35a6_like;
       public         alfioemanuele    false    312            )           1259    622322 $   veicoli_autoparco_nome_067f35a6_uniq    INDEX     [   CREATE INDEX veicoli_autoparco_nome_067f35a6_uniq ON veicoli_autoparco USING btree (nome);
 8   DROP INDEX public.veicoli_autoparco_nome_067f35a6_uniq;
       public         alfioemanuele    false    312            ,           1259    622228    veicoli_collocazione_2371601c    INDEX     _   CREATE INDEX veicoli_collocazione_2371601c ON veicoli_collocazione USING btree (autoparco_id);
 1   DROP INDEX public.veicoli_collocazione_2371601c;
       public         alfioemanuele    false    314            -           1259    622224    veicoli_collocazione_36063dc9    INDEX     \   CREATE INDEX veicoli_collocazione_36063dc9 ON veicoli_collocazione USING btree (creazione);
 1   DROP INDEX public.veicoli_collocazione_36063dc9;
       public         alfioemanuele    false    314            .           1259    622225    veicoli_collocazione_69bd2e5f    INDEX     b   CREATE INDEX veicoli_collocazione_69bd2e5f ON veicoli_collocazione USING btree (ultima_modifica);
 1   DROP INDEX public.veicoli_collocazione_69bd2e5f;
       public         alfioemanuele    false    314            /           1259    622226    veicoli_collocazione_7df656af    INDEX     Y   CREATE INDEX veicoli_collocazione_7df656af ON veicoli_collocazione USING btree (inizio);
 1   DROP INDEX public.veicoli_collocazione_7df656af;
       public         alfioemanuele    false    314            0           1259    622229    veicoli_collocazione_910c7f61    INDEX     _   CREATE INDEX veicoli_collocazione_910c7f61 ON veicoli_collocazione USING btree (creato_da_id);
 1   DROP INDEX public.veicoli_collocazione_910c7f61;
       public         alfioemanuele    false    314            1           1259    622309    veicoli_collocazione_9431c155    INDEX     ]   CREATE INDEX veicoli_collocazione_9431c155 ON veicoli_collocazione USING btree (veicolo_id);
 1   DROP INDEX public.veicoli_collocazione_9431c155;
       public         alfioemanuele    false    314            2           1259    622227    veicoli_collocazione_fff25994    INDEX     W   CREATE INDEX veicoli_collocazione_fff25994 ON veicoli_collocazione USING btree (fine);
 1   DROP INDEX public.veicoli_collocazione_fff25994;
       public         alfioemanuele    false    314            5           1259    622235    veicoli_fermotecnico_36063dc9    INDEX     \   CREATE INDEX veicoli_fermotecnico_36063dc9 ON veicoli_fermotecnico USING btree (creazione);
 1   DROP INDEX public.veicoli_fermotecnico_36063dc9;
       public         alfioemanuele    false    316            6           1259    622236    veicoli_fermotecnico_69bd2e5f    INDEX     b   CREATE INDEX veicoli_fermotecnico_69bd2e5f ON veicoli_fermotecnico USING btree (ultima_modifica);
 1   DROP INDEX public.veicoli_fermotecnico_69bd2e5f;
       public         alfioemanuele    false    316            7           1259    622237    veicoli_fermotecnico_7df656af    INDEX     Y   CREATE INDEX veicoli_fermotecnico_7df656af ON veicoli_fermotecnico USING btree (inizio);
 1   DROP INDEX public.veicoli_fermotecnico_7df656af;
       public         alfioemanuele    false    316            8           1259    622239    veicoli_fermotecnico_910c7f61    INDEX     _   CREATE INDEX veicoli_fermotecnico_910c7f61 ON veicoli_fermotecnico USING btree (creato_da_id);
 1   DROP INDEX public.veicoli_fermotecnico_910c7f61;
       public         alfioemanuele    false    316            9           1259    622303    veicoli_fermotecnico_9431c155    INDEX     ]   CREATE INDEX veicoli_fermotecnico_9431c155 ON veicoli_fermotecnico USING btree (veicolo_id);
 1   DROP INDEX public.veicoli_fermotecnico_9431c155;
       public         alfioemanuele    false    316            :           1259    622238    veicoli_fermotecnico_fff25994    INDEX     W   CREATE INDEX veicoli_fermotecnico_fff25994 ON veicoli_fermotecnico USING btree (fine);
 1   DROP INDEX public.veicoli_fermotecnico_fff25994;
       public         alfioemanuele    false    316            =           1259    622245    veicoli_manutenzione_36063dc9    INDEX     \   CREATE INDEX veicoli_manutenzione_36063dc9 ON veicoli_manutenzione USING btree (creazione);
 1   DROP INDEX public.veicoli_manutenzione_36063dc9;
       public         alfioemanuele    false    318            >           1259    622247    veicoli_manutenzione_401281b0    INDEX     W   CREATE INDEX veicoli_manutenzione_401281b0 ON veicoli_manutenzione USING btree (tipo);
 1   DROP INDEX public.veicoli_manutenzione_401281b0;
       public         alfioemanuele    false    318            ?           1259    622246    veicoli_manutenzione_69bd2e5f    INDEX     b   CREATE INDEX veicoli_manutenzione_69bd2e5f ON veicoli_manutenzione USING btree (ultima_modifica);
 1   DROP INDEX public.veicoli_manutenzione_69bd2e5f;
       public         alfioemanuele    false    318            @           1259    622248    veicoli_manutenzione_8d777f38    INDEX     W   CREATE INDEX veicoli_manutenzione_8d777f38 ON veicoli_manutenzione USING btree (data);
 1   DROP INDEX public.veicoli_manutenzione_8d777f38;
       public         alfioemanuele    false    318            A           1259    622249    veicoli_manutenzione_910c7f61    INDEX     _   CREATE INDEX veicoli_manutenzione_910c7f61 ON veicoli_manutenzione USING btree (creato_da_id);
 1   DROP INDEX public.veicoli_manutenzione_910c7f61;
       public         alfioemanuele    false    318            B           1259    622297    veicoli_manutenzione_9431c155    INDEX     ]   CREATE INDEX veicoli_manutenzione_9431c155 ON veicoli_manutenzione USING btree (veicolo_id);
 1   DROP INDEX public.veicoli_manutenzione_9431c155;
       public         alfioemanuele    false    318            E           1259    622250 '   veicoli_manutenzione_tipo_8709d1fd_like    INDEX     u   CREATE INDEX veicoli_manutenzione_tipo_8709d1fd_like ON veicoli_manutenzione USING btree (tipo varchar_pattern_ops);
 ;   DROP INDEX public.veicoli_manutenzione_tipo_8709d1fd_like;
       public         alfioemanuele    false    318            F           1259    622258    veicoli_rifornimento_201b1ff3    INDEX     [   CREATE INDEX veicoli_rifornimento_201b1ff3 ON veicoli_rifornimento USING btree (ricevuta);
 1   DROP INDEX public.veicoli_rifornimento_201b1ff3;
       public         alfioemanuele    false    320            G           1259    622254    veicoli_rifornimento_311a4e62    INDEX     b   CREATE INDEX veicoli_rifornimento_311a4e62 ON veicoli_rifornimento USING btree (contachilometri);
 1   DROP INDEX public.veicoli_rifornimento_311a4e62;
       public         alfioemanuele    false    320            H           1259    622251    veicoli_rifornimento_36063dc9    INDEX     \   CREATE INDEX veicoli_rifornimento_36063dc9 ON veicoli_rifornimento USING btree (creazione);
 1   DROP INDEX public.veicoli_rifornimento_36063dc9;
       public         alfioemanuele    false    320            I           1259    622252    veicoli_rifornimento_69bd2e5f    INDEX     b   CREATE INDEX veicoli_rifornimento_69bd2e5f ON veicoli_rifornimento USING btree (ultima_modifica);
 1   DROP INDEX public.veicoli_rifornimento_69bd2e5f;
       public         alfioemanuele    false    320            J           1259    622253    veicoli_rifornimento_8d777f38    INDEX     W   CREATE INDEX veicoli_rifornimento_8d777f38 ON veicoli_rifornimento USING btree (data);
 1   DROP INDEX public.veicoli_rifornimento_8d777f38;
       public         alfioemanuele    false    320            K           1259    622349    veicoli_rifornimento_910c7f61    INDEX     _   CREATE INDEX veicoli_rifornimento_910c7f61 ON veicoli_rifornimento USING btree (creato_da_id);
 1   DROP INDEX public.veicoli_rifornimento_910c7f61;
       public         alfioemanuele    false    320            L           1259    622291    veicoli_rifornimento_9431c155    INDEX     ]   CREATE INDEX veicoli_rifornimento_9431c155 ON veicoli_rifornimento USING btree (veicolo_id);
 1   DROP INDEX public.veicoli_rifornimento_9431c155;
       public         alfioemanuele    false    320            M           1259    622255    veicoli_rifornimento_a60e15d9    INDEX     X   CREATE INDEX veicoli_rifornimento_a60e15d9 ON veicoli_rifornimento USING btree (costo);
 1   DROP INDEX public.veicoli_rifornimento_a60e15d9;
       public         alfioemanuele    false    320            N           1259    622257    veicoli_rifornimento_ad33195f    INDEX     ]   CREATE INDEX veicoli_rifornimento_ad33195f ON veicoli_rifornimento USING btree (contalitri);
 1   DROP INDEX public.veicoli_rifornimento_ad33195f;
       public         alfioemanuele    false    320            O           1259    622256    veicoli_rifornimento_da1f0ca4    INDEX     e   CREATE INDEX veicoli_rifornimento_da1f0ca4 ON veicoli_rifornimento USING btree (consumo_carburante);
 1   DROP INDEX public.veicoli_rifornimento_da1f0ca4;
       public         alfioemanuele    false    320            R           1259    622259 +   veicoli_rifornimento_ricevuta_bd9a2b26_like    INDEX     }   CREATE INDEX veicoli_rifornimento_ricevuta_bd9a2b26_like ON veicoli_rifornimento USING btree (ricevuta varchar_pattern_ops);
 ?   DROP INDEX public.veicoli_rifornimento_ricevuta_bd9a2b26_like;
       public         alfioemanuele    false    320            S           1259    622273    veicoli_segnalazione_1694eff9    INDEX     b   CREATE INDEX veicoli_segnalazione_1694eff9 ON veicoli_segnalazione USING btree (manutenzione_id);
 1   DROP INDEX public.veicoli_segnalazione_1694eff9;
       public         alfioemanuele    false    322            T           1259    622270    veicoli_segnalazione_36063dc9    INDEX     \   CREATE INDEX veicoli_segnalazione_36063dc9 ON veicoli_segnalazione USING btree (creazione);
 1   DROP INDEX public.veicoli_segnalazione_36063dc9;
       public         alfioemanuele    false    322            U           1259    622271    veicoli_segnalazione_69bd2e5f    INDEX     b   CREATE INDEX veicoli_segnalazione_69bd2e5f ON veicoli_segnalazione USING btree (ultima_modifica);
 1   DROP INDEX public.veicoli_segnalazione_69bd2e5f;
       public         alfioemanuele    false    322            V           1259    622285    veicoli_segnalazione_9431c155    INDEX     ]   CREATE INDEX veicoli_segnalazione_9431c155 ON veicoli_segnalazione USING btree (veicolo_id);
 1   DROP INDEX public.veicoli_segnalazione_9431c155;
       public         alfioemanuele    false    322            W           1259    622272    veicoli_segnalazione_fa6f1f24    INDEX     \   CREATE INDEX veicoli_segnalazione_fa6f1f24 ON veicoli_segnalazione USING btree (autore_id);
 1   DROP INDEX public.veicoli_segnalazione_fa6f1f24;
       public         alfioemanuele    false    322            Z           1259    622277    veicoli_veicolo_0844b6f9    INDEX     N   CREATE INDEX veicoli_veicolo_0844b6f9 ON veicoli_veicolo USING btree (targa);
 ,   DROP INDEX public.veicoli_veicolo_0844b6f9;
       public         alfioemanuele    false    324            [           1259    622280    veicoli_veicolo_256d016a    INDEX     R   CREATE INDEX veicoli_veicolo_256d016a ON veicoli_veicolo USING btree (categoria);
 ,   DROP INDEX public.veicoli_veicolo_256d016a;
       public         alfioemanuele    false    324            \           1259    622276    veicoli_veicolo_351fd66c    INDEX     Q   CREATE INDEX veicoli_veicolo_351fd66c ON veicoli_veicolo USING btree (libretto);
 ,   DROP INDEX public.veicoli_veicolo_351fd66c;
       public         alfioemanuele    false    324            ]           1259    622274    veicoli_veicolo_36063dc9    INDEX     R   CREATE INDEX veicoli_veicolo_36063dc9 ON veicoli_veicolo USING btree (creazione);
 ,   DROP INDEX public.veicoli_veicolo_36063dc9;
       public         alfioemanuele    false    324            ^           1259    622279    veicoli_veicolo_3c04da3f    INDEX     ^   CREATE INDEX veicoli_veicolo_3c04da3f ON veicoli_veicolo USING btree (data_immatricolazione);
 ,   DROP INDEX public.veicoli_veicolo_3c04da3f;
       public         alfioemanuele    false    324            _           1259    622278    veicoli_veicolo_558318fe    INDEX     _   CREATE INDEX veicoli_veicolo_558318fe ON veicoli_veicolo USING btree (prima_immatricolazione);
 ,   DROP INDEX public.veicoli_veicolo_558318fe;
       public         alfioemanuele    false    324            `           1259    622275    veicoli_veicolo_69bd2e5f    INDEX     X   CREATE INDEX veicoli_veicolo_69bd2e5f ON veicoli_veicolo USING btree (ultima_modifica);
 ,   DROP INDEX public.veicoli_veicolo_69bd2e5f;
       public         alfioemanuele    false    324            a           1259    622284 '   veicoli_veicolo_categoria_ae91837d_like    INDEX     u   CREATE INDEX veicoli_veicolo_categoria_ae91837d_like ON veicoli_veicolo USING btree (categoria varchar_pattern_ops);
 ;   DROP INDEX public.veicoli_veicolo_categoria_ae91837d_like;
       public         alfioemanuele    false    324            b           1259    622281 &   veicoli_veicolo_libretto_131fa9ab_like    INDEX     s   CREATE INDEX veicoli_veicolo_libretto_131fa9ab_like ON veicoli_veicolo USING btree (libretto varchar_pattern_ops);
 :   DROP INDEX public.veicoli_veicolo_libretto_131fa9ab_like;
       public         alfioemanuele    false    324            e           1259    622282 #   veicoli_veicolo_targa_4f13d1eb_like    INDEX     m   CREATE INDEX veicoli_veicolo_targa_4f13d1eb_like ON veicoli_veicolo USING btree (targa varchar_pattern_ops);
 7   DROP INDEX public.veicoli_veicolo_targa_4f13d1eb_like;
       public         alfioemanuele    false    324            f           1259    622283 $   veicoli_veicolo_telaio_f2649410_like    INDEX     o   CREATE INDEX veicoli_veicolo_telaio_f2649410_like ON veicoli_veicolo USING btree (telaio varchar_pattern_ops);
 8   DROP INDEX public.veicoli_veicolo_telaio_f2649410_like;
       public         alfioemanuele    false    324            �           2606    620773     D03c7b0530f486d7c5931579030f6ccd    FK CONSTRAINT     �   ALTER TABLE ONLY base_autorizzazione
    ADD CONSTRAINT "D03c7b0530f486d7c5931579030f6ccd" FOREIGN KEY (destinatario_oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 `   ALTER TABLE ONLY public.base_autorizzazione DROP CONSTRAINT "D03c7b0530f486d7c5931579030f6ccd";
       public       alfioemanuele    false    205    4069    247            �           2606    620914 ?   anagrafi_appartenenza_id_04e6f381_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_riserva
    ADD CONSTRAINT anagrafi_appartenenza_id_04e6f381_fk_anagrafica_appartenenza_id FOREIGN KEY (appartenenza_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.anagrafica_riserva DROP CONSTRAINT anagrafi_appartenenza_id_04e6f381_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    213    4111    229            s           2606    620934 ?   anagrafi_appartenenza_id_bbf1065a_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_dimissione
    ADD CONSTRAINT anagrafi_appartenenza_id_bbf1065a_fk_anagrafica_appartenenza_id FOREIGN KEY (appartenenza_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_dimissione DROP CONSTRAINT anagrafi_appartenenza_id_bbf1065a_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    213    4111    217            x           2606    620939 ?   anagrafi_appartenenza_id_d2133a52_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_estensione
    ADD CONSTRAINT anagrafi_appartenenza_id_d2133a52_fk_anagrafica_appartenenza_id FOREIGN KEY (appartenenza_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_estensione DROP CONSTRAINT anagrafi_appartenenza_id_d2133a52_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    213    4111    221            �           2606    620919 ?   anagrafi_appartenenza_id_fac52e73_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_trasferimento
    ADD CONSTRAINT anagrafi_appartenenza_id_fac52e73_fk_anagrafica_appartenenza_id FOREIGN KEY (appartenenza_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_trasferimento DROP CONSTRAINT anagrafi_appartenenza_id_fac52e73_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    4111    235    213            l           2606    620859 ?   anagrafica_appar_vecchia_sede_id_02e00b6e_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_appartenenza
    ADD CONSTRAINT anagrafica_appar_vecchia_sede_id_02e00b6e_fk_anagrafica_sede_id FOREIGN KEY (vecchia_sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_appartenenza DROP CONSTRAINT anagrafica_appar_vecchia_sede_id_02e00b6e_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    213    4241            o           2606    620505 ?   anagrafica_apparte_persona_id_064511d5_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_appartenenza
    ADD CONSTRAINT anagrafica_apparte_persona_id_064511d5_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_appartenenza DROP CONSTRAINT anagrafica_apparte_persona_id_064511d5_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    213    4193            m           2606    620854 >   anagrafica_appartenenza_sede_id_08aaa687_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_appartenenza
    ADD CONSTRAINT anagrafica_appartenenza_sede_id_08aaa687_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_appartenenza DROP CONSTRAINT anagrafica_appartenenza_sede_id_08aaa687_fk_anagrafica_sede_id;
       public       alfioemanuele    false    213    4241    231            p           2606    620869 ?   anagrafica_d_oggetto_tipo_id_525c06dc_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_delega
    ADD CONSTRAINT anagrafica_d_oggetto_tipo_id_525c06dc_fk_django_content_type_id FOREIGN KEY (oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.anagrafica_delega DROP CONSTRAINT anagrafica_d_oggetto_tipo_id_525c06dc_fk_django_content_type_id;
       public       alfioemanuele    false    215    4069    205            q           2606    620864 ?   anagrafica_dele_firmatario_id_8c5c80ff_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_delega
    ADD CONSTRAINT anagrafica_dele_firmatario_id_8c5c80ff_fk_anagrafica_persona_id FOREIGN KEY (firmatario_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.anagrafica_delega DROP CONSTRAINT anagrafica_dele_firmatario_id_8c5c80ff_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    215    4193            r           2606    620499 >   anagrafica_delega_persona_id_41d95896_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_delega
    ADD CONSTRAINT anagrafica_delega_persona_id_41d95896_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.anagrafica_delega DROP CONSTRAINT anagrafica_delega_persona_id_41d95896_fk_anagrafica_persona_id;
       public       alfioemanuele    false    215    4193    225            u           2606    620879 ?   anagrafica_dim_richiedente_id_279215a5_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_dimissione
    ADD CONSTRAINT anagrafica_dim_richiedente_id_279215a5_fk_anagrafica_persona_id FOREIGN KEY (richiedente_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_dimissione DROP CONSTRAINT anagrafica_dim_richiedente_id_279215a5_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    217            v           2606    620469 ?   anagrafica_dimissi_persona_id_85579005_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_dimissione
    ADD CONSTRAINT anagrafica_dimissi_persona_id_85579005_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_dimissione DROP CONSTRAINT anagrafica_dimissi_persona_id_85579005_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    217            t           2606    620884 <   anagrafica_dimissione_sede_id_676796e1_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_dimissione
    ADD CONSTRAINT anagrafica_dimissione_sede_id_676796e1_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.anagrafica_dimissione DROP CONSTRAINT anagrafica_dimissione_sede_id_676796e1_fk_anagrafica_sede_id;
       public       alfioemanuele    false    217    4241    231            w           2606    620457 ?   anagrafica_documen_persona_id_60d1ad0a_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_documento
    ADD CONSTRAINT anagrafica_documen_persona_id_60d1ad0a_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.anagrafica_documento DROP CONSTRAINT anagrafica_documen_persona_id_60d1ad0a_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    219            y           2606    620899 ?   anagrafica_est_richiedente_id_65472ff0_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_estensione
    ADD CONSTRAINT anagrafica_est_richiedente_id_65472ff0_fk_anagrafica_persona_id FOREIGN KEY (richiedente_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_estensione DROP CONSTRAINT anagrafica_est_richiedente_id_65472ff0_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    221            z           2606    620894 ?   anagrafica_esten_destinazione_id_72b0edee_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_estensione
    ADD CONSTRAINT anagrafica_esten_destinazione_id_72b0edee_fk_anagrafica_sede_id FOREIGN KEY (destinazione_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_estensione DROP CONSTRAINT anagrafica_esten_destinazione_id_72b0edee_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    221    4241            {           2606    620445 ?   anagrafica_estensi_persona_id_5d104815_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_estensione
    ADD CONSTRAINT anagrafica_estensi_persona_id_5d104815_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.anagrafica_estensione DROP CONSTRAINT anagrafica_estensi_persona_id_5d104815_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    221            |           2606    620427 ?   anagrafica_fototes_persona_id_5dac709a_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_fototessera
    ADD CONSTRAINT anagrafica_fototes_persona_id_5dac709a_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_fototessera DROP CONSTRAINT anagrafica_fototes_persona_id_5dac709a_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    223            ~           2606    620904 ?   anagrafica_p_registrato_da_id_144bab34_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_provvedimentodisciplinare
    ADD CONSTRAINT anagrafica_p_registrato_da_id_144bab34_fk_anagrafica_persona_id FOREIGN KEY (registrato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_provvedimentodisciplinare DROP CONSTRAINT anagrafica_p_registrato_da_id_144bab34_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    227    4193            n           2606    620511 ?   anagrafica_precedente_id_f35c0bad_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_appartenenza
    ADD CONSTRAINT anagrafica_precedente_id_f35c0bad_fk_anagrafica_appartenenza_id FOREIGN KEY (precedente_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_appartenenza DROP CONSTRAINT anagrafica_precedente_id_f35c0bad_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    4111    213    213                       2606    620415 ?   anagrafica_provved_persona_id_d9bd7c7c_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_provvedimentodisciplinare
    ADD CONSTRAINT anagrafica_provved_persona_id_d9bd7c7c_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_provvedimentodisciplinare DROP CONSTRAINT anagrafica_provved_persona_id_d9bd7c7c_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    227            }           2606    620909 ?   anagrafica_provvedimento_sede_id_f1f5226e_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_provvedimentodisciplinare
    ADD CONSTRAINT anagrafica_provvedimento_sede_id_f1f5226e_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_provvedimentodisciplinare DROP CONSTRAINT anagrafica_provvedimento_sede_id_f1f5226e_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    227    4241            �           2606    620842 ?   anagrafica_riserva_persona_id_292e673a_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_riserva
    ADD CONSTRAINT anagrafica_riserva_persona_id_292e673a_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.anagrafica_riserva DROP CONSTRAINT anagrafica_riserva_persona_id_292e673a_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    229            �           2606    620136 :   anagrafica_sede_genitore_id_abc0e096_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_sede
    ADD CONSTRAINT anagrafica_sede_genitore_id_abc0e096_fk_anagrafica_sede_id FOREIGN KEY (genitore_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.anagrafica_sede DROP CONSTRAINT anagrafica_sede_genitore_id_abc0e096_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    231    4241            �           2606    620409 :   anagrafica_sede_locazione_id_65857ef3_fk_base_locazione_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_sede
    ADD CONSTRAINT anagrafica_sede_locazione_id_65857ef3_fk_base_locazione_id FOREIGN KEY (locazione_id) REFERENCES base_locazione(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.anagrafica_sede DROP CONSTRAINT anagrafica_sede_locazione_id_65857ef3_fk_base_locazione_id;
       public       alfioemanuele    false    4327    249    231            �           2606    620158 ?   anagrafica_telefon_persona_id_ffadc83e_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_telefono
    ADD CONSTRAINT anagrafica_telefon_persona_id_ffadc83e_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.anagrafica_telefono DROP CONSTRAINT anagrafica_telefon_persona_id_ffadc83e_fk_anagrafica_persona_id;
       public       alfioemanuele    false    233    225    4193            �           2606    620929 ?   anagrafica_tra_richiedente_id_fbd9320a_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_trasferimento
    ADD CONSTRAINT anagrafica_tra_richiedente_id_fbd9320a_fk_anagrafica_persona_id FOREIGN KEY (richiedente_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_trasferimento DROP CONSTRAINT anagrafica_tra_richiedente_id_fbd9320a_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    235            �           2606    620924 ?   anagrafica_trasf_destinazione_id_1ca99bfb_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_trasferimento
    ADD CONSTRAINT anagrafica_trasf_destinazione_id_1ca99bfb_fk_anagrafica_sede_id FOREIGN KEY (destinazione_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_trasferimento DROP CONSTRAINT anagrafica_trasf_destinazione_id_1ca99bfb_fk_anagrafica_sede_id;
       public       alfioemanuele    false    235    231    4241            �           2606    620176 ?   anagrafica_trasfer_persona_id_aa5a579b_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY anagrafica_trasferimento
    ADD CONSTRAINT anagrafica_trasfer_persona_id_aa5a579b_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.anagrafica_trasferimento DROP CONSTRAINT anagrafica_trasfer_persona_id_aa5a579b_fk_anagrafica_persona_id;
       public       alfioemanuele    false    235    225    4193            �           2606    621196 4   attivita_area_sede_id_a49ce0f1_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_area
    ADD CONSTRAINT attivita_area_sede_id_a49ce0f1_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.attivita_area DROP CONSTRAINT attivita_area_sede_id_a49ce0f1_fk_anagrafica_sede_id;
       public       alfioemanuele    false    255    231    4241            �           2606    621201 6   attivita_attivita_area_id_a11c4a8d_fk_attivita_area_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_attivita
    ADD CONSTRAINT attivita_attivita_area_id_a11c4a8d_fk_attivita_area_id FOREIGN KEY (area_id) REFERENCES attivita_area(id) DEFERRABLE INITIALLY DEFERRED;
 r   ALTER TABLE ONLY public.attivita_attivita DROP CONSTRAINT attivita_attivita_area_id_a11c4a8d_fk_attivita_area_id;
       public       alfioemanuele    false    257    255    4357            �           2606    621206 >   attivita_attivita_estensione_id_5e2a5b13_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_attivita
    ADD CONSTRAINT attivita_attivita_estensione_id_5e2a5b13_fk_anagrafica_sede_id FOREIGN KEY (estensione_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.attivita_attivita DROP CONSTRAINT attivita_attivita_estensione_id_5e2a5b13_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    4241    257            �           2606    621175 <   attivita_attivita_locazione_id_4639636b_fk_base_locazione_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_attivita
    ADD CONSTRAINT attivita_attivita_locazione_id_4639636b_fk_base_locazione_id FOREIGN KEY (locazione_id) REFERENCES base_locazione(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.attivita_attivita DROP CONSTRAINT attivita_attivita_locazione_id_4639636b_fk_base_locazione_id;
       public       alfioemanuele    false    4327    257    249            �           2606    621211 8   attivita_attivita_sede_id_462d8d23_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_attivita
    ADD CONSTRAINT attivita_attivita_sede_id_462d8d23_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.attivita_attivita DROP CONSTRAINT attivita_attivita_sede_id_462d8d23_fk_anagrafica_sede_id;
       public       alfioemanuele    false    4241    231    257            �           2606    621141 ?   attivita_partecipa_persona_id_903e460a_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_partecipazione
    ADD CONSTRAINT attivita_partecipa_persona_id_903e460a_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.attivita_partecipazione DROP CONSTRAINT attivita_partecipa_persona_id_903e460a_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    259            �           2606    621169 >   attivita_partecipazione_turno_id_345a6a4c_fk_attivita_turno_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_partecipazione
    ADD CONSTRAINT attivita_partecipazione_turno_id_345a6a4c_fk_attivita_turno_id FOREIGN KEY (turno_id) REFERENCES attivita_turno(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.attivita_partecipazione DROP CONSTRAINT attivita_partecipazione_turno_id_345a6a4c_fk_attivita_turno_id;
       public       alfioemanuele    false    259    261    4410            �           2606    621153 ;   attivita_turno_attivita_id_4ac33164_fk_attivita_attivita_id    FK CONSTRAINT     �   ALTER TABLE ONLY attivita_turno
    ADD CONSTRAINT attivita_turno_attivita_id_4ac33164_fk_attivita_attivita_id FOREIGN KEY (attivita_id) REFERENCES attivita_attivita(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.attivita_turno DROP CONSTRAINT attivita_turno_attivita_id_4ac33164_fk_attivita_attivita_id;
       public       alfioemanuele    false    4375    257    261            �           2606    620244 ?   autenticazione_u_utenza_id_1f5e16e3_fk_autenticazione_utenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_user_permissions
    ADD CONSTRAINT autenticazione_u_utenza_id_1f5e16e3_fk_autenticazione_utenza_id FOREIGN KEY (utenza_id) REFERENCES autenticazione_utenza(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.autenticazione_utenza_user_permissions DROP CONSTRAINT autenticazione_u_utenza_id_1f5e16e3_fk_autenticazione_utenza_id;
       public       alfioemanuele    false    237    241    4268            �           2606    620230 ?   autenticazione_u_utenza_id_5278b250_fk_autenticazione_utenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_groups
    ADD CONSTRAINT autenticazione_u_utenza_id_5278b250_fk_autenticazione_utenza_id FOREIGN KEY (utenza_id) REFERENCES autenticazione_utenza(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.autenticazione_utenza_groups DROP CONSTRAINT autenticazione_u_utenza_id_5278b250_fk_autenticazione_utenza_id;
       public       alfioemanuele    false    239    4268    237            �           2606    620249 ?   autenticazione_ute_permission_id_7c96147d_fk_auth_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_user_permissions
    ADD CONSTRAINT autenticazione_ute_permission_id_7c96147d_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.autenticazione_utenza_user_permissions DROP CONSTRAINT autenticazione_ute_permission_id_7c96147d_fk_auth_permission_id;
       public       alfioemanuele    false    4074    207    241            �           2606    620222 ?   autenticazione_ute_persona_id_b4c4ae3f_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza
    ADD CONSTRAINT autenticazione_ute_persona_id_b4c4ae3f_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.autenticazione_utenza DROP CONSTRAINT autenticazione_ute_persona_id_b4c4ae3f_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    237    225            �           2606    620235 ?   autenticazione_utenza_groups_group_id_8a1692dc_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY autenticazione_utenza_groups
    ADD CONSTRAINT autenticazione_utenza_groups_group_id_8a1692dc_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.autenticazione_utenza_groups DROP CONSTRAINT autenticazione_utenza_groups_group_id_8a1692dc_fk_auth_group_id;
       public       alfioemanuele    false    4079    209    239            j           2606    619944 ?   auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id;
       public       alfioemanuele    false    211    4074    207            k           2606    619939 9   auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public       alfioemanuele    false    4079    211    209            i           2606    619930 ?   auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id;
       public       alfioemanuele    false    4069    205    207            �           2606    620768 ?   base_allegat_oggetto_tipo_id_109eb587_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_allegato
    ADD CONSTRAINT base_allegat_oggetto_tipo_id_109eb587_fk_django_content_type_id FOREIGN KEY (oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 w   ALTER TABLE ONLY public.base_allegato DROP CONSTRAINT base_allegat_oggetto_tipo_id_109eb587_fk_django_content_type_id;
       public       alfioemanuele    false    205    245    4069            �           2606    620783 ?   base_autoriz_oggetto_tipo_id_3bfdf02a_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_autorizzazione
    ADD CONSTRAINT base_autoriz_oggetto_tipo_id_3bfdf02a_fk_django_content_type_id FOREIGN KEY (oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.base_autorizzazione DROP CONSTRAINT base_autoriz_oggetto_tipo_id_3bfdf02a_fk_django_content_type_id;
       public       alfioemanuele    false    4069    247    205            �           2606    620363 ?   base_autorizza_richiedente_id_6c655591_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_autorizzazione
    ADD CONSTRAINT base_autorizza_richiedente_id_6c655591_fk_anagrafica_persona_id FOREIGN KEY (richiedente_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.base_autorizzazione DROP CONSTRAINT base_autorizza_richiedente_id_6c655591_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    247    225            �           2606    620778 ?   base_autorizzaz_firmatario_id_fe723741_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_autorizzazione
    ADD CONSTRAINT base_autorizzaz_firmatario_id_fe723741_fk_anagrafica_persona_id FOREIGN KEY (firmatario_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.base_autorizzazione DROP CONSTRAINT base_autorizzaz_firmatario_id_fe723741_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    247    225            �           2606    620788 5   base_log_persona_id_0c624ba4_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_log
    ADD CONSTRAINT base_log_persona_id_0c624ba4_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 h   ALTER TABLE ONLY public.base_log DROP CONSTRAINT base_log_persona_id_0c624ba4_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    251            �           2606    620762 7   base_token_persona_id_957fc0b3_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY base_token
    ADD CONSTRAINT base_token_persona_id_957fc0b3_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.base_token DROP CONSTRAINT base_token_persona_id_957fc0b3_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    253            �           2606    621344 ?   centrale_opera_smontato_da_id_b603ce13_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY centrale_operativa_turno
    ADD CONSTRAINT centrale_opera_smontato_da_id_b603ce13_fk_anagrafica_persona_id FOREIGN KEY (smontato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.centrale_operativa_turno DROP CONSTRAINT centrale_opera_smontato_da_id_b603ce13_fk_anagrafica_persona_id;
       public       alfioemanuele    false    265    225    4193            �           2606    621334 ?   centrale_operat_montato_da_id_4d1ed35d_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY centrale_operativa_turno
    ADD CONSTRAINT centrale_operat_montato_da_id_4d1ed35d_fk_anagrafica_persona_id FOREIGN KEY (montato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.centrale_operativa_turno DROP CONSTRAINT centrale_operat_montato_da_id_4d1ed35d_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    265    225            �           2606    621324 ?   centrale_operativa_persona_id_0ac5aa99_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY centrale_operativa_reperibilita
    ADD CONSTRAINT centrale_operativa_persona_id_0ac5aa99_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.centrale_operativa_reperibilita DROP CONSTRAINT centrale_operativa_persona_id_0ac5aa99_fk_anagrafica_persona_id;
       public       alfioemanuele    false    263    225    4193            �           2606    621339 ?   centrale_operativa_persona_id_f7807a87_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY centrale_operativa_turno
    ADD CONSTRAINT centrale_operativa_persona_id_f7807a87_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.centrale_operativa_turno DROP CONSTRAINT centrale_operativa_persona_id_f7807a87_fk_anagrafica_persona_id;
       public       alfioemanuele    false    265    225    4193            �           2606    621349 ?   centrale_operativa_turno_turno_id_ba156072_fk_attivita_turno_id    FK CONSTRAINT     �   ALTER TABLE ONLY centrale_operativa_turno
    ADD CONSTRAINT centrale_operativa_turno_turno_id_ba156072_fk_attivita_turno_id FOREIGN KEY (turno_id) REFERENCES attivita_turno(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.centrale_operativa_turno DROP CONSTRAINT centrale_operativa_turno_turno_id_ba156072_fk_attivita_turno_id;
       public       alfioemanuele    false    4410    265    261            �           2606    621411 ?   curriculum__certificato_da_id_ec5bd165_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY curriculum_titolopersonale
    ADD CONSTRAINT curriculum__certificato_da_id_ec5bd165_fk_anagrafica_persona_id FOREIGN KEY (certificato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.curriculum_titolopersonale DROP CONSTRAINT curriculum__certificato_da_id_ec5bd165_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    269            �           2606    621389 ?   curriculum_titolop_persona_id_b8b0fd80_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY curriculum_titolopersonale
    ADD CONSTRAINT curriculum_titolop_persona_id_b8b0fd80_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.curriculum_titolopersonale DROP CONSTRAINT curriculum_titolop_persona_id_b8b0fd80_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    269    4193            �           2606    621394 ?   curriculum_titoloper_titolo_id_81c03310_fk_curriculum_titolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY curriculum_titolopersonale
    ADD CONSTRAINT curriculum_titoloper_titolo_id_81c03310_fk_curriculum_titolo_id FOREIGN KEY (titolo_id) REFERENCES curriculum_titolo(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.curriculum_titolopersonale DROP CONSTRAINT curriculum_titoloper_titolo_id_81c03310_fk_curriculum_titolo_id;
       public       alfioemanuele    false    267    269    4432            �           2606    620270 ?   django_admin_content_type_id_c4bce8eb_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id;
       public       alfioemanuele    false    205    4069    243            �           2606    620275 =   django_admin_log_user_id_c564eba6_fk_autenticazione_utenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_autenticazione_utenza_id FOREIGN KEY (user_id) REFERENCES autenticazione_utenza(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_autenticazione_utenza_id;
       public       alfioemanuele    false    243    237    4268            �           2606    621549 ?   formazion_lezione_id_7b39bf48_fk_formazione_lezionecorsobase_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_assenzacorsobase
    ADD CONSTRAINT formazion_lezione_id_7b39bf48_fk_formazione_lezionecorsobase_id FOREIGN KEY (lezione_id) REFERENCES formazione_lezionecorsobase(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_assenzacorsobase DROP CONSTRAINT formazion_lezione_id_7b39bf48_fk_formazione_lezionecorsobase_id;
       public       alfioemanuele    false    4487    279    275            �           2606    621572 ?   formazione_a_registrata_da_id_c68d3670_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_assenzacorsobase
    ADD CONSTRAINT formazione_a_registrata_da_id_c68d3670_fk_anagrafica_persona_id FOREIGN KEY (registrata_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_assenzacorsobase DROP CONSTRAINT formazione_a_registrata_da_id_c68d3670_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    275            �           2606    621488 ?   formazione_aspiran_persona_id_777d488d_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_aspirante
    ADD CONSTRAINT formazione_aspiran_persona_id_777d488d_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.formazione_aspirante DROP CONSTRAINT formazione_aspiran_persona_id_777d488d_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    273    4193            �           2606    621483 ?   formazione_aspirante_locazione_id_9fbeb61b_fk_base_locazione_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_aspirante
    ADD CONSTRAINT formazione_aspirante_locazione_id_9fbeb61b_fk_base_locazione_id FOREIGN KEY (locazione_id) REFERENCES base_locazione(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.formazione_aspirante DROP CONSTRAINT formazione_aspirante_locazione_id_9fbeb61b_fk_base_locazione_id;
       public       alfioemanuele    false    249    273    4327            �           2606    621555 ?   formazione_assenza_persona_id_69cb4e91_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_assenzacorsobase
    ADD CONSTRAINT formazione_assenza_persona_id_69cb4e91_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_assenzacorsobase DROP CONSTRAINT formazione_assenza_persona_id_69cb4e91_fk_anagrafica_persona_id;
       public       alfioemanuele    false    275    4193    225            �           2606    621498 ?   formazione_corsobase_locazione_id_2497cb8d_fk_base_locazione_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_corsobase
    ADD CONSTRAINT formazione_corsobase_locazione_id_2497cb8d_fk_base_locazione_id FOREIGN KEY (locazione_id) REFERENCES base_locazione(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.formazione_corsobase DROP CONSTRAINT formazione_corsobase_locazione_id_2497cb8d_fk_base_locazione_id;
       public       alfioemanuele    false    4327    249    277            �           2606    621503 ;   formazione_corsobase_sede_id_e343ef3e_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_corsobase
    ADD CONSTRAINT formazione_corsobase_sede_id_e343ef3e_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.formazione_corsobase DROP CONSTRAINT formazione_corsobase_sede_id_e343ef3e_fk_anagrafica_sede_id;
       public       alfioemanuele    false    4241    277    231            �           2606    621577 ?   formazione_lezione_corso_id_aea20fa3_fk_formazione_corsobase_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_lezionecorsobase
    ADD CONSTRAINT formazione_lezione_corso_id_aea20fa3_fk_formazione_corsobase_id FOREIGN KEY (corso_id) REFERENCES formazione_corsobase(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_lezionecorsobase DROP CONSTRAINT formazione_lezione_corso_id_aea20fa3_fk_formazione_corsobase_id;
       public       alfioemanuele    false    279    277    4480            �           2606    621631 ?   formazione_parte_destinazione_id_08e97af7_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_partecipazionecorsobase
    ADD CONSTRAINT formazione_parte_destinazione_id_08e97af7_fk_anagrafica_sede_id FOREIGN KEY (destinazione_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_partecipazionecorsobase DROP CONSTRAINT formazione_parte_destinazione_id_08e97af7_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    4241    281            �           2606    621582 ?   formazione_parteci_corso_id_74c27279_fk_formazione_corsobase_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_partecipazionecorsobase
    ADD CONSTRAINT formazione_parteci_corso_id_74c27279_fk_formazione_corsobase_id FOREIGN KEY (corso_id) REFERENCES formazione_corsobase(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_partecipazionecorsobase DROP CONSTRAINT formazione_parteci_corso_id_74c27279_fk_formazione_corsobase_id;
       public       alfioemanuele    false    4480    281    277            �           2606    621529 ?   formazione_parteci_persona_id_541e6502_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY formazione_partecipazionecorsobase
    ADD CONSTRAINT formazione_parteci_persona_id_541e6502_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.formazione_partecipazionecorsobase DROP CONSTRAINT formazione_parteci_persona_id_541e6502_fk_anagrafica_persona_id;
       public       alfioemanuele    false    281    4193    225            �           2606    621702 ?   gruppi_appartene_negato_da_id_803face3_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_appartenenza
    ADD CONSTRAINT gruppi_appartene_negato_da_id_803face3_fk_anagrafica_persona_id FOREIGN KEY (negato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.gruppi_appartenenza DROP CONSTRAINT gruppi_appartene_negato_da_id_803face3_fk_anagrafica_persona_id;
       public       alfioemanuele    false    283    225    4193            �           2606    621695 ?   gruppi_appartenenz_persona_id_898d6042_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_appartenenza
    ADD CONSTRAINT gruppi_appartenenz_persona_id_898d6042_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.gruppi_appartenenza DROP CONSTRAINT gruppi_appartenenz_persona_id_898d6042_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    283            �           2606    621683 :   gruppi_appartenenza_gruppo_id_3aa60b25_fk_gruppi_gruppo_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_appartenenza
    ADD CONSTRAINT gruppi_appartenenza_gruppo_id_3aa60b25_fk_gruppi_gruppo_id FOREIGN KEY (gruppo_id) REFERENCES gruppi_gruppo(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.gruppi_appartenenza DROP CONSTRAINT gruppi_appartenenza_gruppo_id_3aa60b25_fk_gruppi_gruppo_id;
       public       alfioemanuele    false    4523    285    283            �           2606    621707 2   gruppi_gruppo_area_id_4ebcf904_fk_attivita_area_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_gruppo
    ADD CONSTRAINT gruppi_gruppo_area_id_4ebcf904_fk_attivita_area_id FOREIGN KEY (area_id) REFERENCES attivita_area(id) DEFERRABLE INITIALLY DEFERRED;
 j   ALTER TABLE ONLY public.gruppi_gruppo DROP CONSTRAINT gruppi_gruppo_area_id_4ebcf904_fk_attivita_area_id;
       public       alfioemanuele    false    285    255    4357            �           2606    621712 :   gruppi_gruppo_attivita_id_ad6907c3_fk_attivita_attivita_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_gruppo
    ADD CONSTRAINT gruppi_gruppo_attivita_id_ad6907c3_fk_attivita_attivita_id FOREIGN KEY (attivita_id) REFERENCES attivita_attivita(id) DEFERRABLE INITIALLY DEFERRED;
 r   ALTER TABLE ONLY public.gruppi_gruppo DROP CONSTRAINT gruppi_gruppo_attivita_id_ad6907c3_fk_attivita_attivita_id;
       public       alfioemanuele    false    285    4375    257            �           2606    621669 4   gruppi_gruppo_sede_id_47ea3ef7_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY gruppi_gruppo
    ADD CONSTRAINT gruppi_gruppo_sede_id_47ea3ef7_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.gruppi_gruppo DROP CONSTRAINT gruppi_gruppo_sede_id_47ea3ef7_fk_anagrafica_sede_id;
       public       alfioemanuele    false    4241    231    285            �           2606    621749 >   posta_destinatario_messaggio_id_42be8327_fk_posta_messaggio_id    FK CONSTRAINT     �   ALTER TABLE ONLY posta_destinatario
    ADD CONSTRAINT posta_destinatario_messaggio_id_42be8327_fk_posta_messaggio_id FOREIGN KEY (messaggio_id) REFERENCES posta_messaggio(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.posta_destinatario DROP CONSTRAINT posta_destinatario_messaggio_id_42be8327_fk_posta_messaggio_id;
       public       alfioemanuele    false    4541    287    289            �           2606    621762 ?   posta_destinatario_persona_id_b9084daa_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY posta_destinatario
    ADD CONSTRAINT posta_destinatario_persona_id_b9084daa_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.posta_destinatario DROP CONSTRAINT posta_destinatario_persona_id_b9084daa_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    287            �           2606    621738 =   posta_messaggio_mittente_id_6879a1ee_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY posta_messaggio
    ADD CONSTRAINT posta_messaggio_mittente_id_6879a1ee_fk_anagrafica_persona_id FOREIGN KEY (mittente_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 w   ALTER TABLE ONLY public.posta_messaggio DROP CONSTRAINT posta_messaggio_mittente_id_6879a1ee_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    289    225            �           2606    621768 ?   posta_messaggio_rispondi_a_id_3d32e584_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY posta_messaggio
    ADD CONSTRAINT posta_messaggio_rispondi_a_id_3d32e584_fk_anagrafica_persona_id FOREIGN KEY (rispondi_a_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.posta_messaggio DROP CONSTRAINT posta_messaggio_rispondi_a_id_3d32e584_fk_anagrafica_persona_id;
       public       alfioemanuele    false    289    4193    225            �           2606    621813 <   sangue_donatore_persona_id_a00315ba_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY sangue_donatore
    ADD CONSTRAINT sangue_donatore_persona_id_a00315ba_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.sangue_donatore DROP CONSTRAINT sangue_donatore_persona_id_a00315ba_fk_anagrafica_persona_id;
       public       alfioemanuele    false    291    225    4193            �           2606    621865 6   sangue_donatore_sede_sit_id_2c3f1209_fk_sangue_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY sangue_donatore
    ADD CONSTRAINT sangue_donatore_sede_sit_id_2c3f1209_fk_sangue_sede_id FOREIGN KEY (sede_sit_id) REFERENCES sangue_sede(id) DEFERRABLE INITIALLY DEFERRED;
 p   ALTER TABLE ONLY public.sangue_donatore DROP CONSTRAINT sangue_donatore_sede_sit_id_2c3f1209_fk_sangue_sede_id;
       public       alfioemanuele    false    291    297    4575            �           2606    621828 =   sangue_donazione_persona_id_6447a25f_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY sangue_donazione
    ADD CONSTRAINT sangue_donazione_persona_id_6447a25f_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.sangue_donazione DROP CONSTRAINT sangue_donazione_persona_id_6447a25f_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    293    225            �           2606    621870 3   sangue_donazione_sede_id_119898bb_fk_sangue_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY sangue_donazione
    ADD CONSTRAINT sangue_donazione_sede_id_119898bb_fk_sangue_sede_id FOREIGN KEY (sede_id) REFERENCES sangue_sede(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.sangue_donazione DROP CONSTRAINT sangue_donazione_sede_id_119898bb_fk_sangue_sede_id;
       public       alfioemanuele    false    297    293    4575            �           2606    621840 :   sangue_merito_persona_id_7d0173ef_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY sangue_merito
    ADD CONSTRAINT sangue_merito_persona_id_7d0173ef_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 r   ALTER TABLE ONLY public.sangue_merito DROP CONSTRAINT sangue_merito_persona_id_7d0173ef_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    295    4193            �           2606    621950 ?   social_comme_oggetto_tipo_id_31ea5d6b_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY social_commento
    ADD CONSTRAINT social_comme_oggetto_tipo_id_31ea5d6b_fk_django_content_type_id FOREIGN KEY (oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.social_commento DROP CONSTRAINT social_comme_oggetto_tipo_id_31ea5d6b_fk_django_content_type_id;
       public       alfioemanuele    false    302    205    4069            �           2606    621917 ;   social_commento_autore_id_601127ed_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY social_commento
    ADD CONSTRAINT social_commento_autore_id_601127ed_fk_anagrafica_persona_id FOREIGN KEY (autore_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.social_commento DROP CONSTRAINT social_commento_autore_id_601127ed_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    302    225            �           2606    621955 ?   social_giudi_oggetto_tipo_id_ccf20414_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY social_giudizio
    ADD CONSTRAINT social_giudi_oggetto_tipo_id_ccf20414_fk_django_content_type_id FOREIGN KEY (oggetto_tipo_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.social_giudizio DROP CONSTRAINT social_giudi_oggetto_tipo_id_ccf20414_fk_django_content_type_id;
       public       alfioemanuele    false    304    205    4069            �           2606    621932 ;   social_giudizio_autore_id_dc0341db_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY social_giudizio
    ADD CONSTRAINT social_giudizio_autore_id_dc0341db_fk_anagrafica_persona_id FOREIGN KEY (autore_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.social_giudizio DROP CONSTRAINT social_giudizio_autore_id_dc0341db_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    304            �           2606    622084 ?   ufficio__appartenenza_id_5e262408_fk_anagrafica_appartenenza_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio__appartenenza_id_5e262408_fk_anagrafica_appartenenza_id FOREIGN KEY (appartenenza_id) REFERENCES anagrafica_appartenenza(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio__appartenenza_id_5e262408_fk_anagrafica_appartenenza_id;
       public       alfioemanuele    false    306    4111    213            �           2606    622109 ?   ufficio_soc_riconsegnato_a_id_cc867051_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soc_riconsegnato_a_id_cc867051_fk_anagrafica_persona_id FOREIGN KEY (riconsegnato_a_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soc_riconsegnato_a_id_cc867051_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    310    225            �           2606    622079 ?   ufficio_soci__annullato_da_id_aeb6d74c_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci__annullato_da_id_aeb6d74c_fk_anagrafica_persona_id FOREIGN KEY (annullato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci__annullato_da_id_aeb6d74c_fk_anagrafica_persona_id;
       public       alfioemanuele    false    306    225    4193            �           2606    622050 ?   ufficio_soci__richiesto_da_id_e6ee13c8_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci__richiesto_da_id_e6ee13c8_fk_anagrafica_persona_id FOREIGN KEY (richiesto_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci__richiesto_da_id_e6ee13c8_fk_anagrafica_persona_id;
       public       alfioemanuele    false    310    225    4193            �           2606    622099 ?   ufficio_soci_confermato_da_id_15a2fad3_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci_confermato_da_id_15a2fad3_fk_anagrafica_persona_id FOREIGN KEY (confermato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci_confermato_da_id_15a2fad3_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    310            �           2606    622006 ?   ufficio_soci_quota_persona_id_1055e386_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci_quota_persona_id_1055e386_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci_quota_persona_id_1055e386_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    306            �           2606    622094 9   ufficio_soci_quota_sede_id_29ade660_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci_quota_sede_id_29ade660_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci_quota_sede_id_29ade660_fk_anagrafica_sede_id;
       public       alfioemanuele    false    4241    306    231            �           2606    622089 ?   ufficio_soci_registrato_da_id_99ea06f3_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_quota
    ADD CONSTRAINT ufficio_soci_registrato_da_id_99ea06f3_fk_anagrafica_persona_id FOREIGN KEY (registrato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.ufficio_soci_quota DROP CONSTRAINT ufficio_soci_registrato_da_id_99ea06f3_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    306    225            �           2606    622045 ?   ufficio_soci_tesse_persona_id_0be95188_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci_tesse_persona_id_0be95188_fk_anagrafica_persona_id FOREIGN KEY (persona_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci_tesse_persona_id_0be95188_fk_anagrafica_persona_id;
       public       alfioemanuele    false    310    4193    225            �           2606    622104 ?   ufficio_soci_tesser_emesso_da_id_6be4cdf3_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY ufficio_soci_tesserino
    ADD CONSTRAINT ufficio_soci_tesser_emesso_da_id_6be4cdf3_fk_anagrafica_sede_id FOREIGN KEY (emesso_da_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.ufficio_soci_tesserino DROP CONSTRAINT ufficio_soci_tesser_emesso_da_id_6be4cdf3_fk_anagrafica_sede_id;
       public       alfioemanuele    false    231    4241    310            �           2606    622198 <   veicoli_autoparco_locazione_id_04b9637c_fk_base_locazione_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_autoparco
    ADD CONSTRAINT veicoli_autoparco_locazione_id_04b9637c_fk_base_locazione_id FOREIGN KEY (locazione_id) REFERENCES base_locazione(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.veicoli_autoparco DROP CONSTRAINT veicoli_autoparco_locazione_id_04b9637c_fk_base_locazione_id;
       public       alfioemanuele    false    312    4327    249            �           2606    622203 8   veicoli_autoparco_sede_id_857db6e7_fk_anagrafica_sede_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_autoparco
    ADD CONSTRAINT veicoli_autoparco_sede_id_857db6e7_fk_anagrafica_sede_id FOREIGN KEY (sede_id) REFERENCES anagrafica_sede(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.veicoli_autoparco DROP CONSTRAINT veicoli_autoparco_sede_id_857db6e7_fk_anagrafica_sede_id;
       public       alfioemanuele    false    312    4241    231            �           2606    622355 ?   veicoli_collocaz_creato_da_id_ae51cb5c_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_collocazione
    ADD CONSTRAINT veicoli_collocaz_creato_da_id_ae51cb5c_fk_anagrafica_persona_id FOREIGN KEY (creato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_collocazione DROP CONSTRAINT veicoli_collocaz_creato_da_id_ae51cb5c_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    314    225            �           2606    622324 ?   veicoli_collocazi_autoparco_id_371a448a_fk_veicoli_autoparco_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_collocazione
    ADD CONSTRAINT veicoli_collocazi_autoparco_id_371a448a_fk_veicoli_autoparco_id FOREIGN KEY (autoparco_id) REFERENCES veicoli_autoparco(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_collocazione DROP CONSTRAINT veicoli_collocazi_autoparco_id_371a448a_fk_veicoli_autoparco_id;
       public       alfioemanuele    false    4651    312    314            �           2606    622310 >   veicoli_collocazione_veicolo_id_067437cb_fk_veicoli_veicolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_collocazione
    ADD CONSTRAINT veicoli_collocazione_veicolo_id_067437cb_fk_veicoli_veicolo_id FOREIGN KEY (veicolo_id) REFERENCES veicoli_veicolo(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.veicoli_collocazione DROP CONSTRAINT veicoli_collocazione_veicolo_id_067437cb_fk_veicoli_veicolo_id;
       public       alfioemanuele    false    4708    324    314            �           2606    622360 ?   veicoli_fermotec_creato_da_id_8498d659_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_fermotecnico
    ADD CONSTRAINT veicoli_fermotec_creato_da_id_8498d659_fk_anagrafica_persona_id FOREIGN KEY (creato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_fermotecnico DROP CONSTRAINT veicoli_fermotec_creato_da_id_8498d659_fk_anagrafica_persona_id;
       public       alfioemanuele    false    225    4193    316            �           2606    622304 >   veicoli_fermotecnico_veicolo_id_2d46096c_fk_veicoli_veicolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_fermotecnico
    ADD CONSTRAINT veicoli_fermotecnico_veicolo_id_2d46096c_fk_veicoli_veicolo_id FOREIGN KEY (veicolo_id) REFERENCES veicoli_veicolo(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.veicoli_fermotecnico DROP CONSTRAINT veicoli_fermotecnico_veicolo_id_2d46096c_fk_veicoli_veicolo_id;
       public       alfioemanuele    false    324    4708    316            �           2606    622365 ?   veicoli_manutenz_creato_da_id_ebaa78d2_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_manutenzione
    ADD CONSTRAINT veicoli_manutenz_creato_da_id_ebaa78d2_fk_anagrafica_persona_id FOREIGN KEY (creato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_manutenzione DROP CONSTRAINT veicoli_manutenz_creato_da_id_ebaa78d2_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    225    318            �           2606    622298 >   veicoli_manutenzione_veicolo_id_1a700888_fk_veicoli_veicolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_manutenzione
    ADD CONSTRAINT veicoli_manutenzione_veicolo_id_1a700888_fk_veicoli_veicolo_id FOREIGN KEY (veicolo_id) REFERENCES veicoli_veicolo(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.veicoli_manutenzione DROP CONSTRAINT veicoli_manutenzione_veicolo_id_1a700888_fk_veicoli_veicolo_id;
       public       alfioemanuele    false    318    4708    324            �           2606    622370 ?   veicoli_rifornim_creato_da_id_abf7ab3b_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_rifornimento
    ADD CONSTRAINT veicoli_rifornim_creato_da_id_abf7ab3b_fk_anagrafica_persona_id FOREIGN KEY (creato_da_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_rifornimento DROP CONSTRAINT veicoli_rifornim_creato_da_id_abf7ab3b_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    320    225            �           2606    622292 >   veicoli_rifornimento_veicolo_id_81607143_fk_veicoli_veicolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_rifornimento
    ADD CONSTRAINT veicoli_rifornimento_veicolo_id_81607143_fk_veicoli_veicolo_id FOREIGN KEY (veicolo_id) REFERENCES veicoli_veicolo(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.veicoli_rifornimento DROP CONSTRAINT veicoli_rifornimento_veicolo_id_81607143_fk_veicoli_veicolo_id;
       public       alfioemanuele    false    320    4708    324            �           2606    622344 ?   veicoli_seg_manutenzione_id_c425b9c1_fk_veicoli_manutenzione_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_segnalazione
    ADD CONSTRAINT veicoli_seg_manutenzione_id_c425b9c1_fk_veicoli_manutenzione_id FOREIGN KEY (manutenzione_id) REFERENCES veicoli_manutenzione(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_segnalazione DROP CONSTRAINT veicoli_seg_manutenzione_id_c425b9c1_fk_veicoli_manutenzione_id;
       public       alfioemanuele    false    318    4676    322            �           2606    622260 ?   veicoli_segnalazion_autore_id_942ad54b_fk_anagrafica_persona_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_segnalazione
    ADD CONSTRAINT veicoli_segnalazion_autore_id_942ad54b_fk_anagrafica_persona_id FOREIGN KEY (autore_id) REFERENCES anagrafica_persona(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.veicoli_segnalazione DROP CONSTRAINT veicoli_segnalazion_autore_id_942ad54b_fk_anagrafica_persona_id;
       public       alfioemanuele    false    4193    322    225            �           2606    622286 >   veicoli_segnalazione_veicolo_id_8f05da98_fk_veicoli_veicolo_id    FK CONSTRAINT     �   ALTER TABLE ONLY veicoli_segnalazione
    ADD CONSTRAINT veicoli_segnalazione_veicolo_id_8f05da98_fk_veicoli_veicolo_id FOREIGN KEY (veicolo_id) REFERENCES veicoli_veicolo(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.veicoli_segnalazione DROP CONSTRAINT veicoli_segnalazione_veicolo_id_8f05da98_fk_veicoli_veicolo_id;
       public       alfioemanuele    false    324    322    4708            f      x������ � �      h      x������ � �      j      x������ � �      l      x������ � �      n      x������ � �      p      x������ � �      r      x������ � �      t      x������ � �      v      x������ � �      x      x������ � �      z      x������ � �      |      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      ~      x������ � �      �      x������ � �      �      x������ � �      b      x������ � �      d      x������ � �      `   o  x���ݎ�6������Y��e��E��(�\(Y몱EW��>Mߥ/֑8Ù��JD~����sD:)���e��ctv��n���f��P�o�0^o��0R��e{��m��G�X��~��6�a�k�]�ۭq�f�זmǶ d��[�\�i(�Թ�u���
������yz�S�gh&�\��]����z�/���mh"vog��<9*����+AE�5}�9�c�����H?O�$�3
�31������R��OR�H)�+�L�����0iy�]׼����C����J��-a��Jf��-h.�f��]t�C&ˍ���Jzu�PL�� ��ڦi�ݗ����8�xA݉� <�@��$@<�@����>���v���5AOpc'�T��L��mTT]뵹ʬ�_���^���O�PS�˨���ǯK�ئx�"<�P`AJ�LB��\��2����u�W�n�qwu����>��c��n0�@ȟ�xJ��`Hm�'W��<��v��|n�rs�<�dd�-k����Κ.,թ���^�M�M�_ ��0p �xƀ��P��\KP*�6\�c(�3�c�AƠ����Kݹ��D=AϮu�ܛ�\N��WP�ϲH\"�v�HGW���e�{W
��3�uX
`���Ʃ�ײ�����i#kk��k"�B�:���XGo?������Gzcw�c�	�8b�f�8b�iC��
�Y�j���Ԕ�;/��br�S[{v��)��@�Ye����<;
��&�j����������v����~q�'4�<�\�d0��#�ʙ��/�O���m��(�w����X����F{�WkF�Ā�&��v=��rSx��K���:���TU�Z�Qqy�2�ܹ�����1�nUs=7m����Nm	�8���;0�������)�Np�-����8>
���T��V��@+&a��FÛ�o^����7����7�s�! ?V�X1be5�{G�U�@/�� ����,e��ˋbLzx�c(| `+��Kd>��o�1��3C޲�"���
�2�� �/��#��S�G���L��g��" �By(�AH(&�E0��Oc�|_��>f��L��%�b�KJ(�*5N��zu�$���b�$��@�b���p᠂9�q��I�d�͔�`�3��GS���4K_MY��K9c���ý9"�m�A0��"�H��%am�D���s흏;��N[s�ೋ�cՀ�.j$��&����EԴ.zs���)������K�d�p�#]6��1¾A�P���*%�Δ\��v=@�A�=�@IA�f�����k�}{��~�kE� �����)�2�{���j���Ɩm���jή�F#�Y	���R7��I�]���[�Ϯ$8�%yf%՜ߺs�����j'���W����`Ы�p�
Z������hK\��pS���C+7~=W��D��\$����H~ѽ������+��O���HZ����sɓ���c�2�z���Dy�O�����������i���}1Iy;�"B���0&���3l�ã1�g׵aCUe��ޕ^��nJ��h��ag#h�G�,;Щ����I#DA� (�-�B� +�.�jpT��~���..R#��Al���j@���(O�f�oWwL>�iq�.@b�hdyDȊL֔�i���H�}c_v(��!��f;��ue811$κ8�#�X����u���H�܇W0�D�E<�ъ$)ӊ*�-�θ�q��_�AX��^�ۣ=ٓ�lw@�y��G�N��B�U�K����D@(�r��C�.�c�i��<������.���#4$	�������>*���l�@M���@�	l@q��	�@qk��{�$�v�v���?j���6��ǣ-���j�?�!���x�?�3)���Z~� ��>��"4@���#�.3*Q̿�N���X���\������^S��]��t��rq.��┆LA:���Fɗ��6X"�>=��ܼE�����BL ʓ+��Pu���p��_Ó����Hm�O�Y�0�e�[��L!�*̯����ss�Ի�����񇅙B>�P��%�D�%�"��O��d���3����cά �W
�9�f���U)�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      ^   y  x�mTђ� |��������b��!� �n��/��X�/�IHBǶej��1��q��V2��w�?C���]�&���۞it����bBy�b"��˥`�l!±�fL
�^/�"�L�S\��>�C���Z3��\���>�eF�r��˧e�������6�w"�@y����K�fʩɫ��ԅ��ЦD��fD������z�)$��Wˢ<E��ے
f0���(&ʻ�G�H}��_r�*��C���J��5l=�EIx�HO��k��O3�P��<y_�'��"�1��:7���q�ԧ��B�^P���zYD���;�W�A�v�Y�������m�ᢪH��@^�q ���w���ݜ�>7RT7��T.�[@,w\��?Q�pl���c�X���6�SN:w'�ׄ�'F�/�Q���L��R!NbVn��Q�D0��՜�����#č���e��9a��8v-[0Л�T����N��@�#�D�7�cA�i54 �O���M����<S���(����&����j$��&�)���J�[if�7�^򊞕DS��_��MB�d�}�N�e�!WYwl��"�M{t,}>��q�&A�.��-)Y��\��l#�T?�����s�d��      �      x������ � �      W   �  x���ˎ�8E׮����F�����T�ҥ�-�$����~.I�-Q��z�pf:����E������~���N!�]�ݻ�r`A�!!��_���uE�xo�)��Xr=���G[����꾹�e��T@�C���p/���B=-�n.�v�o�x���������^_���o�P,�6:��%g�c��t��l��@1O�ZR���v��)���O�^".�t�/ù����cX���D���G7>#�RV&(r����9��Gwl���Ҧg�Ǔ`�'��}o���NthN׮�a�ș�������Z��9����	"_�i�Z����h�2qzX�D�Ƒ��l*㕳Q.�3�w�5#���6���x��5�ԞJ�c*�@����j9�&)}��S:m�f�ah*0lEH�#�e�34�"C#f���9ð)2�7Q�,2����
W�Bǜ��T���Фl���Z��>��Y�JIG2J�_�\�$��AU���",�u.N��?�/H�x
���Ć�JCk2222Umrː�N[J��������} �l�Q�2�"��@��0�%Ÿ�L��v���JeS]ˤH��5!!'b:��1�\�B^o���l��U�����U`X�|��!u>wC,m=`]l����y�!�:������t���>�����E*?6�JQ%��&�))S}-@�<9H�]}�&x��QH��g���6d&X^>�ZS F@�1�e&X�9�#;�Vjec%��ty�<J�.��*(�F��L����BPJ�*�.��A��d JeEe�e�eB&<0&��݆A��(o������Q*M`Hc}�PT&])r��	˔�f�2)2��R���P&�{��T.u�PB��Sz�>T�S)s��CBƺ��L�R�f��:���~-��v^ƴ�2�ʥD%z1�>�f-S��L���.�����ҙD�R�8����!�C�������5�03���с0^���"A�V����]��R���)Qh�"�p Hԭ4� �,	�D�(p�D�*��	vE0���
��=���"l�L9ab�4HUI~Eئ�b�����#V�m�)*c�5ZB�5�V�`�\�َ��QR)J�jV���?g��K�det�Yi���E)�K�[��Y{��-M�{�Z���YլD�j��"�A�lt�Mat����c��)7��o��:�z�q
�hݎ�0��v��s[�8�>�7㞓@�+�|��ͳa��
e����5ۺ�X`�a�bv��i�;��3��X���iI(w��JѬ+4�2M0�5=���*�X]!+�V���Am�Sy��L*�V=��b|A�ê�cs
sx��b�Z�4�q}n��'�)��
�SFL%�¸�p|����u�!2�J�v��Nś
zG��1��`h���%:�1T}Gq	�;�ǩ+�8���& N�5�y�����
	�F8�"�qn���|����p���/�{������e6�S��u��1��]wa�V�*zԩ̌c�Ahs�b�*\k�s"ݍ9�Qv6��<;�d��b	k���ʡ�J��ٌ����Uh�D�����ݪU���U,0z&��v_���ƥ�Q�16m�(����Z�>��1�)�� &zPbz��f��g~�&��$Sy�8i�$�*�ط1��L��Y����_!���g2]�Ӡ��I��2|�Y+��a��q�u�b�WNJ�*����y�W������r�;X��N��j��a/!Ҕ%H��m��0��w'#z��4��xN7�H�����$�O�=�0]~��9�����n�=�}�V��k5���L$��d�����x�d�_��$�H L�k�`��y�0�Z<ޥsX9v����.�v��������Sl\a�i�����wc���;v.5D�q��k�`�F�dD/�ϗs���t}���B� LA�ޕ��pOz�X9�B�����e��X� � ����19�C!}x||tG(:�ޭ^�Ƥ2�yc����po���b����d_��K��#a���b@c(���yK~�YǬ�ɋB�ֺJF�f�����Մ���J�p�6�¸�n�P6���`�W���1T�9�Q��|R,7��G��� ���>�52V��S�iz���B}��/�ρ���c}��vG���Dk*kh.��fi�3�l���:$�:��%M�&�_4��ݒ�S���B�8���7}a��_�J��(Œ`�Us_�F]Iꔴ$�������;�6�K��?��17\«��\�`����R�[}����>Kx0      �      x������ � �      �      x�3�L�H�-�I�K��Efs��qqq �<	�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      [      x������ � �      Y      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      }      x������ � �      \      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     