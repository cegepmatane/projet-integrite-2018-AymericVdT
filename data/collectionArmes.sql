--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: CollectionArmes; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "CollectionArmes" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'French_Canada.1252' LC_CTYPE = 'French_Canada.1252';


ALTER DATABASE "CollectionArmes" OWNER TO postgres;

\connect "CollectionArmes"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Armes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Armes" (
    id integer NOT NULL,
    nom text,
    famille text,
    type text,
    origine text,
    epoque integer
);


ALTER TABLE "Armes" OWNER TO postgres;

--
-- Name: Armes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Armes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Armes_id_seq" OWNER TO postgres;

--
-- Name: Armes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Armes_id_seq" OWNED BY "Armes".id;


--
-- Name: Armes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Armes" ALTER COLUMN id SET DEFAULT nextval('"Armes_id_seq"'::regclass);


--
-- Data for Name: Armes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Armes" VALUES (1, 'Hallebarde', 'Hast', 'Lance', 'Suisse', 14);
INSERT INTO "Armes" VALUES (2, 'Claymore', 'Epee', 'Tranchante', 'Ecosse', 14);
INSERT INTO "Armes" VALUES (3, 'Chu Ko Nu', 'Arbalete', 'Distance', 'Chine', 4);


--
-- Name: Armes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Armes_id_seq"', 3, true);


--
-- Name: Armes Armes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Armes"
    ADD CONSTRAINT "Armes_pkey" PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

