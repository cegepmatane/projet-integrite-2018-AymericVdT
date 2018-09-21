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
-- Name: Arme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Exemplaire"(
    id integer NOT NULL,
    classification text,
    materiau text,
    prixAchat integer,
    arme integer
);


ALTER TABLE "Exemplaire" OWNER TO postgres;

--
-- Name: Exemplaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres;
--

CREATE SEQUENCE Exemplaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    
    
ALTER TABLE Exemplaire_id_seq OWNER TO postgres;

--
-- Name: Exemplempaire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE Exemplaire_id_seq OWNER BY exemplaire.id;


--
-- Name: Arme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Arme" (
    id integer NOT NULL,
    nom text,
    famille text,
    type text,
    origine text,
    epoque integer
);


ALTER TABLE "Arme" OWNER TO postgres;

--
-- Name: Arme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Arme_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Arme_id_seq" OWNER TO postgres;

--
-- Name: Arme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Arme_id_seq" OWNED BY "Arme".id;

--
-- Name: Exemplaire id; Type: DEFAULT; Schema: public; Owner postgres
--

ALTER TABLE ONLY "Exemplaire" ALTER COLUMN id SET DEFAULT nextval('Exemplaire_id_seq'::regclass);


--
-- Name: Arme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Arme" ALTER COLUMN id SET DEFAULT nextval('"Arme_id_seq"'::regclass);


--
-- Daya for Name: Exemplaire; Type: TABLE DATA; Schema: public; Owner postgres
--



--
-- Name: Exemplaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('Exemplaire_id_seq', 1, false);


-- Data for Name: Arme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Arme" VALUES (1, 'Hallebarde', 'Hast', 'Lance', 'Suisse', 14);
INSERT INTO "Arme" VALUES (2, 'Claymore', 'Epee', 'Tranchante', 'Ecosse', 14);
INSERT INTO "Arme" VALUES (3, 'Chu Ko Nu', 'Arbalete', 'Distance', 'Chine', 4);


--
-- Name: Arme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Arme_id_seq"', 3, true);


--
-- Name: distinction distinction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Exemplaire"
    ADD CONSTRAINT "Exemplaire_pkey" PRIMARY KEY (ID);


--
-- Name: Arme Arme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Arme"
    ADD CONSTRAINT "Arme_pkey" PRIMARY KEY (id);


--
-- Name: fki_one_arme_to_many_exemplaire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_one_arme_to_many_exemplaire ON "Exemplaire" USING btree ("Arme");


--
-- Name: distinction one_arme_to_many_exemplaire; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distinction
    ADD CONSTRAINT one_arme_to_many_exemplaire FOREIGN KEY (arme) REFERENCES "Arme"(id);

--
-- PostgreSQL database dump complete
--

