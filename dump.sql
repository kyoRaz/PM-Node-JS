--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2023-06-06 16:05:28

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
-- TOC entry 3057 (class 1262 OID 58432)
-- Name: task; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE task WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_Madagascar.1252';


ALTER DATABASE task OWNER TO postgres;

\connect task

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 644 (class 1247 OID 58464)
-- Name: etat; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.etat AS ENUM (
    'Actif',
    'D‚sactiv‚'
);


ALTER TYPE public.etat OWNER TO postgres;

--
-- TOC entry 637 (class 1247 OID 58444)
-- Name: mood; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.mood AS ENUM (
    'sad',
    'ok',
    'happy'
);


ALTER TYPE public.mood OWNER TO postgres;

--
-- TOC entry 662 (class 1247 OID 69455)
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role AS ENUM (
    'user',
    'admin'
);


ALTER TYPE public.role OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 69459)
-- Name: seqclient; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqclient
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqclient OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 69461)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer DEFAULT nextval('public.seqclient'::regclass) NOT NULL,
    nom character varying(50),
    email character varying(50),
    password character varying(100),
    role public.role,
    salt character varying(100)
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 69436)
-- Name: seqtask; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtask
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtask OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 69438)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id integer DEFAULT nextval('public.seqtask'::regclass) NOT NULL,
    idtype integer,
    idutilisateur integer,
    libelle character varying(50)
);


ALTER TABLE public.task OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 58477)
-- Name: tasktype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasktype (
    id integer NOT NULL,
    nom character varying NOT NULL
);


ALTER TABLE public.tasktype OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 58469)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    nom character varying,
    prenom character varying,
    cin character varying,
    email character varying,
    numero character varying,
    password character varying,
    status character varying,
    sexe character varying
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 69467)
-- Name: detailstask; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.detailstask AS
 SELECT t.id,
    t.libelle,
    t.idtype,
    t2.nom AS type,
    t.idutilisateur,
    u.prenom AS auteur
   FROM ((public.task t
     JOIN public.tasktype t2 ON ((t.idtype = t2.id)))
     JOIN public.utilisateur u ON ((t.idutilisateur = u.id)));


ALTER TABLE public.detailstask OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 58451)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    name text,
    current_mood public.mood
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 58475)
-- Name: seqtasktype; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtasktype
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtasktype OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 58433)
-- Name: seqtest; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtest
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtest OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 58438)
-- Name: sequser; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sequser
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequser OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 69390)
-- Name: tasktype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasktype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasktype_id_seq OWNER TO postgres;

--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 207
-- Name: tasktype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasktype_id_seq OWNED BY public.tasktype.id;


--
-- TOC entry 206 (class 1259 OID 68135)
-- Name: utilisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilisateur_id_seq OWNER TO postgres;

--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 206
-- Name: utilisateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;


--
-- TOC entry 2895 (class 2604 OID 69402)
-- Name: tasktype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasktype ALTER COLUMN id SET DEFAULT nextval('public.tasktype_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 68141)
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- TOC entry 3051 (class 0 OID 69461)
-- Dependencies: 211
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client VALUES (1, 'KYO', 'Kyo@gmail.com', '$2a$10$PaerXekApmX4HQsN61.Ccu/zFXRHQpkm8PmgFmW7W9RNNVa8senAa', 'admin', '$2a$10$PaerXekApmX4HQsN61.Ccu');


--
-- TOC entry 3042 (class 0 OID 58451)
-- Dependencies: 202
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES ('Moe', 'happy');


--
-- TOC entry 3049 (class 0 OID 69438)
-- Dependencies: 209
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task VALUES (1, 1, 8, 'Test');
INSERT INTO public.task VALUES (2, 2, 8, 'Test 2');


--
-- TOC entry 3045 (class 0 OID 58477)
-- Dependencies: 205
-- Data for Name: tasktype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tasktype VALUES (1, '2D');
INSERT INTO public.tasktype VALUES (2, '3D');


--
-- TOC entry 3043 (class 0 OID 58469)
-- Dependencies: 203
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utilisateur VALUES (8, 'User2', 'Fab', NULL, 'Fab@gmail.com', '0345266492', NULL, 'Activé', NULL);
INSERT INTO public.utilisateur VALUES (9, 'User3', 'Koto', NULL, 'Koto@gmail.com', '0345266492', NULL, 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (13, 'User7', 'Tahina', NULL, 'Tahna@gmail.com', '0345266492', NULL, 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (14, 'User8', 'Tina ', NULL, 'steeve@gmail.com', '0345266492', NULL, 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (12, 'User', 'Hery', NULL, 'Hery@gmail.com', '0345266492', NULL, 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (1, 'User1', 'Hery', '123456789', 'Hery@gmail.com', NULL, 'mdp1234', 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (10, 'User4', 'Zafy', NULL, 'Zafy@gmail.com', '0345266492', NULL, 'Désactivé', NULL);
INSERT INTO public.utilisateur VALUES (11, 'User5', 'Naivo', NULL, 'Naivo@gmail.com', '0345266492', NULL, 'Désactivé', NULL);


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 210
-- Name: seqclient; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqclient', 2, true);


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 208
-- Name: seqtask; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtask', 2, true);


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 204
-- Name: seqtasktype; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtasktype', 2, true);


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 200
-- Name: seqtest; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtest', 2, true);


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 201
-- Name: sequser; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sequser', 56, true);


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 207
-- Name: tasktype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasktype_id_seq', 1, false);


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 206
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 1, true);


--
-- TOC entry 2905 (class 2606 OID 69466)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 2903 (class 2606 OID 69443)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 58482)
-- Name: tasktype tasktype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasktype
    ADD CONSTRAINT tasktype_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 58473)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- TOC entry 2908 (class 2606 OID 69471)
-- Name: task task_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_fk FOREIGN KEY (idtype) REFERENCES public.tasktype(id);


--
-- TOC entry 2906 (class 2606 OID 69444)
-- Name: task task_idtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_idtype_fkey FOREIGN KEY (idtype) REFERENCES public.tasktype(id);


--
-- TOC entry 2907 (class 2606 OID 69449)
-- Name: task task_idutilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_idutilisateur_fkey FOREIGN KEY (idutilisateur) REFERENCES public.utilisateur(id);


-- Completed on 2023-06-06 16:05:30

--
-- PostgreSQL database dump complete
--

