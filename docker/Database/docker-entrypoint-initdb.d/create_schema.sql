--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.3

-- Started on 2020-08-18 19:58:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 4 (class 3079 OID 16393)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- TOC entry 3 (class 3079 OID 16470)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 206 (class 1259 OID 16973)
-- Name: mm_cron; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_cron (
    mm_cron_guid uuid NOT NULL,
    mm_cron_name text,
    mm_cron_description text,
    mm_cron_enabled boolean,
    mm_cron_schedule text,
    mm_cron_last_run timestamp without time zone,
    mm_cron_json jsonb
);


ALTER TABLE public.mm_cron OWNER TO postgres;





--
-- TOC entry 231 (class 1259 OID 17126)
-- Name: mm_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_notification (
    mm_notification_guid uuid NOT NULL,
    mm_notification_text text,
    mm_notification_time timestamp without time zone,
    mm_notification_dismissable boolean
);


ALTER TABLE public.mm_notification OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17132)
-- Name: mm_options_and_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_options_and_status (
    mm_options_and_status_guid uuid NOT NULL,
    mm_options_json jsonb,
    mm_status_json jsonb
);


ALTER TABLE public.mm_options_and_status OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17174)
-- Name: mm_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_user (
    id integer NOT NULL,
    username text,
    email text,
    password text,
    created_at timestamp with time zone,
    active boolean,
    is_admin boolean,
    user_json jsonb,
    lang text
);


ALTER TABLE public.mm_user OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17180)
-- Name: mm_user_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_user_activity (
    mm_activity_guid uuid NOT NULL,
    mm_activity_name text,
    mm_activity_overview text,
    mm_activity_short_overview text,
    mm_activity_type text,
    mm_activity_itemid uuid,
    mm_activity_userid uuid,
    mm_activity_datecreated timestamp without time zone,
    mm_activity_log_severity text
);


ALTER TABLE public.mm_user_activity OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17186)
-- Name: mm_user_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_user_group (
    mm_user_group_guid uuid NOT NULL,
    mm_user_group_name text,
    mm_user_group_description text,
    mm_user_group_rights_json jsonb
);


ALTER TABLE public.mm_user_group OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17192)
-- Name: mm_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mm_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mm_user_id_seq OWNER TO postgres;

--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 242
-- Name: mm_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mm_user_id_seq OWNED BY public.mm_user.id;


--
-- TOC entry 243 (class 1259 OID 17194)
-- Name: mm_user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mm_user_profile (
    mm_user_profile_guid uuid NOT NULL,
    mm_user_profile_name text,
    mm_user_profile_json jsonb
);


ALTER TABLE public.mm_user_profile OWNER TO postgres;

--
-- TOC entry 2972 (class 2604 OID 17203)
-- Name: mm_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_user ALTER COLUMN id SET DEFAULT nextval('public.mm_user_id_seq'::regclass);


--
-- TOC entry 3305 (class 0 OID 16967)
-- Dependencies: 205
-- Data for Name: mm_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_channel (mm_channel_guid, mm_channel_name, mm_channel_media_id, mm_channel_country_guid, mm_channel_logo_guid) FROM stdin;
\.


--
-- TOC entry 3306 (class 0 OID 16973)
-- Dependencies: 206
-- Data for Name: mm_cron; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_cron (mm_cron_guid, mm_cron_name, mm_cron_description, mm_cron_enabled, mm_cron_schedule, mm_cron_last_run, mm_cron_json) FROM stdin;
47cad101-9e87-4596-ba02-2bcea8ce3575	Anime	Match anime via Scudlee and Manami data	f	Days 1	1970-01-01 00:00:01	{"Type": "Anime Xref", "program": "/mediakraken/subprogram_match_anime_id.py", "route_key": "Z", "exchange_key": "mkque_metadata_ex"}
631ea52e-2807-4342-8b59-2f8263da0ef2	Collections	Create and update collection(s)	f	Days 1	1970-01-01 00:00:01	{"Type": "Update Collection", "program": "/mediakraken/subprogram_metadata_update_create_collections.py", "route_key": "themoviedb", "exchange_key": "mkque_metadata_ex"}
f82f2aa4-3b4b-4a78-ab5a-5564c414ab1d	Schedules Direct	Fetch TV schedules from Schedules Direct	f	Days 1	1970-01-01 00:00:01	{"Type": "Update", "program": "/mediakraken/subprogram_schedules_direct_updates.py", "route_key": "schedulesdirect", "exchange_key": "mkque_metadata_ex"}
0d6f545f-2682-4bfd-8d9a-620eaae36690	The Movie Database	Grab updated metadata for movie(s) and TV show(s)	f	Days 1	1970-01-01 00:00:01	{"Type": "Update Metadata", "program": "/mediakraken/async_metadata_themoviedb_updates.py", "route_key": "themoviedb", "exchange_key": "mkque_metadata_ex"}
9e07954c-26e5-4752-863b-f6142b5f6e6a	Trailer	Download new trailer(s)	f	Days 1	1970-01-01 00:00:01	{"Type": "HDTrailers", "route_key": "mkdownload", "exchange_key": "mkque_download_ex"}
f039f4d3-ec26-491a-a498-60ea2b1f314b	Backup	Backup PostgreSQL DB	f	Days 1	1970-01-01 00:00:01	{"Type": "Cron Run", "program": "/mediakraken/subprogram_postgresql_backup.py", "route_key": "mkque", "exchange_key": "mkque_ex"}
128d11cd-c0c2-44d7-ae16-cf5de96207d7	DB Vacuum	PostgreSQL Vacuum Analyze all tables	f	Days 1	1970-01-01 00:00:01	{"Type": "Cron Run", "program": "/mediakraken/subprogram_postgresql_vacuum.py", "route_key": "mkque", "exchange_key": "mkque_ex"}
de374320-56f7-45cd-b42c-9c8147feb81f	Media Scan	Scan for new media	f	Days 1	1970-01-01 00:00:01	{"Type": "Library Scan", "route_key": "mkque", "exchange_key": "mkque_ex"}
c1f8e43d-c657-435c-a6e1-ac296b3bfba9	Sync	Sync and transcode media	f	Days 1	1970-01-01 00:00:01	{"Type": "Cron Run", "program": "/mediakraken/subprogram_sync.py", "route_key": "mkque", "exchange_key": "mkque_ex"}
3da17df9-fae9-4a3a-a70b-5f429d5c1821	Retro game data	Grab updated metadata for retro game(s)	f	Days 1	1970-01-01 00:00:01	{"Type": "Cron Run", "program": "/mediakraken/subprogram_metadata_games.py", "route_key": "mkque", "exchange_key": "mkque_ex"}
\.

--
-- TOC entry 3331 (class 0 OID 17126)
-- Dependencies: 231
-- Data for Name: mm_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_notification (mm_notification_guid, mm_notification_text, mm_notification_time, mm_notification_dismissable) FROM stdin;
\.


--
-- TOC entry 3332 (class 0 OID 17132)
-- Dependencies: 232
-- Data for Name: mm_options_and_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_options_and_status (mm_options_and_status_guid, mm_options_json, mm_status_json) FROM stdin;
df641592-2c6a-4ffa-816d-5f24dcea1ddd	{"API": {"anidb": null, "imvdb": null, "google": "AIzaSyCwMkNYp8E4H19BDzlM7-IDkNCQtw0R9lY", "isbndb": "25C8IT4I", "tvmaze": "mknotneeded", "thetvdb": "147CB43DCA8B61B7", "shoutcast": null, "thelogodb": null, "soundcloud": null, "themoviedb": "f72118d1e84b8a1438935972a9c37cac", "globalcache": null, "musicbrainz": null, "thesportsdb": "4352761817344", "opensubtitles": null, "openweathermap": "575b4ae4615e4e2a4c34fb9defa17ceb", "rottentomatoes": "f4tnu5dn9r7f28gjth3ftqaj"}, "User": {"Password Lock": null, "Activity Purge": null}, "Cloud": {}, "Trakt": {"ApiKey": null, "ClientID": null, "SecretKey": null}, "Backup": {"Interval": 0, "BackupType": "local"}, "Docker": {"Nodes": 0, "SwarmID": null, "Instances": 0}, "LastFM": {"api_key": null, "password": null, "username": null, "api_secret": null}, "Twitch": {"OAuth": null, "ClientID": null}, "Account": {"ScheduleDirect": {"User": null, "Password": null}}, "Metadata": {"Trailer": {"Clip": false, "Behind": false, "Carpool": false, "Trailer": false, "Featurette": false}, "DL Subtitle": false, "MusicBrainz": {"Host": null, "Port": 5000, "User": null, "Password": null}, "MetadataImageLocal": false}, "Transmission": {"Host": null, "Port": 9091, "Password": "metaman", "Username": "spootdev"}, "Docker Instances": {"elk": false, "smtp": false, "mumble": false, "pgadmin": false, "portainer": false, "teamspeak": false, "wireshark": false, "musicbrainz": false, "transmission": false}, "MediaKrakenServer": {"MOTD": null, "Maintenance": null, "Server Name": "MediaKraken", "MaxResumePct": 5}}	{"thetvdb_Updated_Epoc": 0}
\.


--
-- TOC entry 3339 (class 0 OID 17174)
-- Dependencies: 239
-- Data for Name: mm_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_user (id, username, email, password, created_at, active, is_admin, user_json, lang) FROM stdin;
\.


--
-- TOC entry 3340 (class 0 OID 17180)
-- Dependencies: 240
-- Data for Name: mm_user_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_user_activity (mm_activity_guid, mm_activity_name, mm_activity_overview, mm_activity_short_overview, mm_activity_type, mm_activity_itemid, mm_activity_userid, mm_activity_datecreated, mm_activity_log_severity) FROM stdin;
\.


--
-- TOC entry 3341 (class 0 OID 17186)
-- Dependencies: 241
-- Data for Name: mm_user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_user_group (mm_user_group_guid, mm_user_group_name, mm_user_group_description, mm_user_group_rights_json) FROM stdin;
38117775-93b4-47d6-9a42-fc886ab6580c	Administrator	Server administrator	{"Admin": true, "PreviewOnly": false}
6666956c-a4d8-45bc-9c56-deaa1c2b68d3	User	General user	{"Admin": false, "PreviewOnly": false}
bea39ac2-505e-4cdd-9a3b-9c7da2cb28b2	Guest	Guest (Preview only)	{"Admin": false, "PreviewOnly": true}
\.


--
-- TOC entry 3343 (class 0 OID 17194)
-- Dependencies: 243
-- Data for Name: mm_user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mm_user_profile (mm_user_profile_guid, mm_user_profile_name, mm_user_profile_json) FROM stdin;
0863c596-3d62-4409-83c2-0515d3465adc	Adult	{"3D": true, "TV": true, "Home": true, "Lang": "en", "Sync": true, "Adult": true, "Books": true, "Games": true, "MaxBR": 100, "Movie": true, "Music": true, "IRadio": true, "Images": true, "LiveTV": true, "Sports": true, "Internet": true, "MaxRating": 5}
2bf39eb6-8192-4c2d-88cf-6341bbec1cd8	Teen	{"3D": true, "TV": true, "Home": true, "Lang": "en", "Sync": false, "Adult": false, "Books": true, "Games": true, "MaxBR": 50, "Movie": true, "Music": true, "IRadio": true, "Images": true, "LiveTV": true, "Sports": true, "Internet": true, "MaxRating": 3}
2bcbbd3e-8e2e-4fdc-92a9-471e5d018539	Child	{"3D": false, "TV": true, "Home": true, "Lang": "en", "Sync": false, "Adult": false, "Books": true, "Games": true, "MaxBR": 20, "Movie": true, "Music": true, "IRadio": false, "Images": true, "LiveTV": false, "Sports": true, "Internet": false, "MaxRating": 0}
\.


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 242
-- Name: mm_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mm_user_id_seq', 1, false);

--
-- TOC entry 3162 (class 2606 OID 17213)
-- Name: mm_user_activity mm_activity_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_user_activity
    ADD CONSTRAINT mm_activity_pk PRIMARY KEY (mm_activity_guid);


--
-- TOC entry 2980 (class 2606 OID 17217)
-- Name: mm_cron mm_cron_guid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_cron
    ADD CONSTRAINT mm_cron_guid_pk PRIMARY KEY (mm_cron_guid);

--
-- TOC entry 3135 (class 2606 OID 17257)
-- Name: mm_notification mm_notification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_notification
    ADD CONSTRAINT mm_notification_pk PRIMARY KEY (mm_notification_guid);


--
-- TOC entry 3137 (class 2606 OID 17259)
-- Name: mm_options_and_status mm_options_and_status_guid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_options_and_status
    ADD CONSTRAINT mm_options_and_status_guid_pk PRIMARY KEY (mm_options_and_status_guid);


--
-- TOC entry 3166 (class 2606 OID 17273)
-- Name: mm_user_group mm_user_group_guid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_user_group
    ADD CONSTRAINT mm_user_group_guid_pk PRIMARY KEY (mm_user_group_guid);


--
-- TOC entry 3160 (class 2606 OID 17275)
-- Name: mm_user mm_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_user
    ADD CONSTRAINT mm_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3169 (class 2606 OID 17277)
-- Name: mm_user_profile mm_user_profile_guid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_user_profile
    ADD CONSTRAINT mm_user_profile_guid_pk PRIMARY KEY (mm_user_profile_guid);

--
-- TOC entry 3103 (class 2606 OID 17279)
-- Name: mm_metadata_person mmp_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mm_metadata_person
    ADD CONSTRAINT mmp_id_pk PRIMARY KEY (mmp_id);

--
-- TOC entry 3132 (class 1259 OID 17388)
-- Name: mm_notification_idx_dismissable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_notification_idx_dismissable ON public.mm_notification USING btree (mm_notification_dismissable);


--
-- TOC entry 3133 (class 1259 OID 17389)
-- Name: mm_notification_idx_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_notification_idx_time ON public.mm_notification USING btree (mm_notification_time);


--
-- TOC entry 3163 (class 1259 OID 17396)
-- Name: mm_user_activity_idx_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_user_activity_idx_date ON public.mm_user_activity USING btree (mm_activity_datecreated);


--
-- TOC entry 3164 (class 1259 OID 17397)
-- Name: mm_user_activity_idx_user_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_user_activity_idx_user_guid ON public.mm_user_activity USING btree (mm_activity_userid);


--
-- TOC entry 3167 (class 1259 OID 17398)
-- Name: mm_user_group_idx_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_user_group_idx_name ON public.mm_user_group USING btree (mm_user_group_name);


--
-- TOC entry 3158 (class 1259 OID 17399)
-- Name: mm_user_idx_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_user_idx_username ON public.mm_user USING btree (username);


--
-- TOC entry 3170 (class 1259 OID 17400)
-- Name: mm_user_profile_idx_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mm_user_profile_idx_name ON public.mm_user_profile USING btree (mm_user_profile_name);

-- Completed on 2020-08-18 19:58:06

--
-- PostgreSQL database dump complete
--

