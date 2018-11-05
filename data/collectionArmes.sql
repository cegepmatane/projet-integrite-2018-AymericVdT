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
-- Name: armes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE armes (
    id integer NOT NULL,
    nom text,
    famille text,
    type text,
    origine text,
    epoque integer
);


ALTER TABLE armes OWNER TO postgres;

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

ALTER SEQUENCE "Armes_id_seq" OWNED BY armes.id;


--
-- Name: exemplaires; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE exemplaires (
    "idExemplaire" integer NOT NULL,
    "prixAchat" integer,
    classification text,
    materiau text,
    "idArme" integer NOT NULL
);


ALTER TABLE exemplaires OWNER TO postgres;

--
-- Name: armes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY armes ALTER COLUMN id SET DEFAULT nextval('"Armes_id_seq"'::regclass);


--
-- Name: Armes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Armes_id_seq"', 3, true);


--
-- Data for Name: armes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO armes VALUES (1, 'Hallebarde', 'Hast', 'Lance', 'Suisse', 14);
INSERT INTO armes VALUES (2, 'Claymore', 'Epee', 'Tranchante', 'Ecosse', 14);
INSERT INTO armes VALUES (3, 'Chu Ko Nu', 'Arbalete', 'Distance', 'Chine', 4);


--
-- Data for Name: exemplaires; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: armes Armes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY armes
    ADD CONSTRAINT "Armes_pkey" PRIMARY KEY (id);


--
-- Name: exemplaires exemplaires_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exemplaires
    ADD CONSTRAINT exemplaires_pkey PRIMARY KEY ("idExemplaire");


--
-- Name: fki_fk_idArme; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_idArme" ON exemplaires USING btree ("idArme");


--
-- Name: exemplaires fk_idArme; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exemplaires
    ADD CONSTRAINT "fk_idArme" FOREIGN KEY ("idArme") REFERENCES armes(id);


--
-- PostgreSQL database dump complete
--

