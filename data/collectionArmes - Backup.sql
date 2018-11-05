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

--
-- Name: calculerdonneejournaliere(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION calculerdonneejournaliere() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    donneeArme RECORD;
    donneeExemplaire RECORD;
    donneeAggreagatArme RECORD;

    checksumAggreagatArme text;
    nombreMoyenExemplaireParArme real;
    nombreTotalExemplaireArme integer;

BEGIN
	Select into donneeArme
    	MD5(string_agg(id,'-')) as checksum,
        AVG(quantite) as quantiteMoyenne,
        SUM(quantite) as quantiteTotal
        FROM public."Arme";
    Select into donneeExemplaire
    	MD5(string_agg(id,'-')) as checksum,
        AVG(id) as idMoyen,
        COUNT(nom) as nombreExemplaire
        FROM public."Exemplaire";
    for donneeAggreagatArme in Select string_agg(e.id,'-') as aggregatExemplaire,
        Count(e.id) as nombreExemplaireParArme, a.nom as nomArme
        FROM public."Exemplaire" as e join public."Arme" as a on e.arme = a.id group by a.nom loop
        checksumAggreagatArme := checksumAggreagatArme || '//' || donneeAggreagatArme.nomArme || ':' || donneeAggreagatArme.aggregatExemplaire;
        nombreTotalExemplaireArme := nombreTotalExemplaireArme + donneeAggreagatArme.nombreExemplaireParArme;
        end loop;
        nombreMoyenExemplaireParArme := nombreMoyenExemplaireParArme/donneeArme.nombreArme;
        checksumAggreagatArme := MD5(checksumAggreagatArme);


    Insert into public."DonneeJournaliereExemplaire" (checksum_noms, quantite_moyenne, quantites_total, date)
    Values (donneeExemplaire.checksum, donneeExemplaire.quantiteMoyenne, donneeExemplaire.quantiteTotal, NOW());

    Insert into public."DonneeJournaliereArme" (checksum_noms, id_moyen, nombre_arme, date)
    Values (donneeArme.checksum, donneeArme.idMoyen, donneeArme.nombreArme, NOW());

    Insert into public."DonneeJournaliereAgreggatArme" (checksum_id_exemplaire, nombre_moyen_exemplaire_par_arme, nombre_total_exemplaire_arme, date)
    Values (checksumAggreagatArme, nombreMoyenExemplaireParArme, nombreTotalExemplaireArme, NOW());
END

$$;


ALTER FUNCTION public.calculerdonneejournaliere() OWNER TO postgres;

--
-- Name: journaliserarme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION journaliserarme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
	description text;
    exemplaireAvant text;
    exemplaireApres text;
    operation text;
BEGIN
	exemplaireAvant := '';
	exemplaireApres := '';

	IF TG_OP = 'UPDATE' THEN
    	exemplaireAvant := '{'||OLD.id||','||OLD.classification||','||OLD.materiau||','||OLD.prixAchat||','||OLD.arme||'}';
   		exemplaireApres := '{'||NEW.id||','||NEW.classification||','||NEW.materiau||','||NEW.prixAchat||','||NEW.arme||'}';
        operation := 'MODIFIER';
    END IF;
	IF TG_OP = 'INSERT' THEN
    	exemplaireAvant := '{}';
   		exemplaireApres := '{'||NEW.id||','||NEW.classification||','||NEW.materiau||','||NEW.prixAchat||','||NEW.arme||'}';
        operation := 'AJOUTER';
    END IF;
	IF TG_OP = 'DELETE' THEN
    	exemplaireAvant := '{'||OLD.id||','||OLD.classification||','||OLD.materiau||','||OLD.prixAchat||','||OLD.arme||'}';
    	exemplaireApres := '{}';
        operation := 'EFFACER';
    END IF;

	description := exemplaireAvant || ' -> ' || exemplaireApres;
    -- https://www.postgresql.org/docs/9.1/static/plpgsql-trigger.html
	INSERT into journal(moment, operation, exemplaire, donnee) VALUES(NOW(), operation, 'exemplaire', description);

	IF TG_OP = 'DELETE' THEN
		return OLD;
	END IF;
    return NEW;
END
$$;


ALTER FUNCTION public.journaliserexemplaire() OWNER TO postgres;

--
-- Name: supprimerexemplairepararme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION supprimerExemplaireParArme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	DELETE FROM public."Exemplaire" where arme = OLD.id;
	return OLD;
END
$$;


ALTER FUNCTION public.supprimerExemplaireParArme() OWNER TO postgres;

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
-- Name: DonneeJournaliereAgreggatArme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "DonneeJournaliereAgreggatArme" (
    id integer NOT NULL,
    checksum_id_exemplaires text,
    nombre_moyen_exemplaire_par_arme real,
    nombre_total_exemplaire_arme integer,
    date date
);


ALTER TABLE "DonneeJournaliereAgreggatArme" OWNER TO postgres;

--
-- Name: DonneeJournaliereAgreggatArme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "DonneeJournaliereAgreggatArme_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DonneeJournaliereAgreggatArme_id_seq" OWNER TO postgres;

--
-- Name: DonneeJournaliereAgreggatArme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "DonneeJournaliereAgreggatArme_id_seq" OWNED BY "DonneeJournaliereAgreggatArme".id;


--
-- Name: DonneeJournaliereArme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "DonneeJournaliereArme" (
    id integer NOT NULL,
    checksum_id text,
    id_moyen real,
    nombre_exemplaire integer,
    date date
);


ALTER TABLE "DonneeJournaliereArme" OWNER TO postgres;

--
-- Name: DonneeJournaliereArme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "DonneeJournaliereArme_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DonneeJournaliereArme_id_seq" OWNER TO postgres;

--
-- Name: DonneeJournaliereArme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "DonneeJournaliereArme_id_seq" OWNED BY "DonneeJournaliereArme".id;


--
-- Name: DonneeJournaliereExemplaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "DonneeJournaliereExemplaire" (
    id integer NOT NULL,
    checksum_noms text,
    quantite_moyenne real,
    quantite_total integer,
    date date
);


ALTER TABLE "DonneeJournaliereExemplaire" OWNER TO postgres;

--
-- Name: DonneeJournaliereExemplaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "DonneeJournaliereExemplaire_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "DonneeJournaliereExemplaire_id_seq" OWNER TO postgres;

--
-- Name: DonneeJournaliereExemplaire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "DonneeJournaliereExemplaire_id_seq" OWNED BY "DonneeJournaliereExemplaire".id;


--
-- Name: Arme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Arme" (
    id integer NOT NULL,
    nom text,
    famille text,
    type text,
    origine text,
    epoque integer,
    id_exemplaire integer
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
-- Name: id_journal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_journal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999
    CACHE 1;


ALTER TABLE id_journal_seq OWNER TO postgres;

--
-- Name: journal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE journal (
    id_journal bigint DEFAULT nextval('id_journal_seq'::regclass) NOT NULL,
    operation text,
    exemplaire text,
    donnee text,
    moment timestamp without time zone
);


ALTER TABLE journal OWNER TO postgres;


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
-- Name: DonneeJournaliereAgreggatArme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereAgreggatArme" ALTER COLUMN id SET DEFAULT nextval('"DonneeJournaliereAgreggatArme_id_seq"'::regclass);


--
-- Name: DonneeJournaliereArme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereArme" ALTER COLUMN id SET DEFAULT nextval('"DonneeJournaliereArme_id_seq"'::regclass);


--
-- Name: DonneeJournaliereExemplaire id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereExemplaire" ALTER COLUMN id SET DEFAULT nextval('"DonneeJournaliereExemplaire_id_seq"'::regclass);


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
-- Name: DonneeJournaliereAgreggatArme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"DonneeJournaliereAgreggatArme_id_seq"', 2, true);

--
-- Name: DonneeJournaliereArme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"DonneeJournaliereArme_id_seq"', 4, true);

--
-- Name: DonneeJournaliereExemplaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"DonneeJournaliereExemplaire_id_seq"', 5, true);



--
-- Name: distinction distinction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Exemplaire"
    ADD CONSTRAINT "Exemplaire_pkey" PRIMARY KEY (ID);


--
-- Name: DonneeJournaliereAgreggatArme DonneeJournaliereAgreggatArme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereAgreggatArme"
    ADD CONSTRAINT "DonneeJournaliereAgreggatArme_pkey" PRIMARY KEY (id);


--
-- Name: DonneeJournaliereArme DonneeJournaliereArme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereArme"
    ADD CONSTRAINT "DonneeJournaliereArme_pkey" PRIMARY KEY (id);


--
-- Name: DonneeJournaliereExemplaire DonneeJournaliereExemplaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DonneeJournaliereExemplaire"
    ADD CONSTRAINT "DonneeJournaliereExemplaire_pkey" PRIMARY KEY (id);

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
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (id_journal);


--
-- Name: Arme netoyageavantsupressionarme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER netoyageavantsupressionarme BEFORE DELETE ON "Arme" FOR EACH ROW EXECUTE PROCEDURE supprimerexemplairepararme();


--
-- Name: Exemplaire suiviexemplaire; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER suiviexemplaire AFTER INSERT OR UPDATE ON "Exemplaire" FOR EACH ROW EXECUTE PROCEDURE journaliserexemplaire();


--
-- Name: distinction one_arme_to_many_exemplaire; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distinction
    ADD CONSTRAINT one_arme_to_many_exemplaire FOREIGN KEY (arme) REFERENCES "Arme"(id);

--
-- PostgreSQL database dump complete
--
