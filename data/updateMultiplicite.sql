\connect "collectionArmes"

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

SET default_with_oids = false;

--
-- Name: Categorie; Type: TABLE; Schema: public; Owner: postgres
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
-- Name: Exemplaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Exemplaire_id_seq"
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Exemplaire_id_seq" OWNER TO postgres;

--
-- Name: Exemplaire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Exemplaire_id_seq" OWNED BY "Exemplaire".id;


--
-- Name: Objet; Type: TABLE; Schema: public; Owner: postgres
--

ALTER TABLE "Arme" ADD COLUMN id_categorie integer;

--
-- Name: Exemplaire id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Exemplaire" ALTER COLUMN id SET DEFAULT nextval('"Exemplaire_id_seq"'::regclass);

--
-- Data for Name: Exemplaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Exemplaire" VALUES (1,'Factice','Mousse',150,1);
INSERT INTO "Exemplaire" VALUES (2,'Reel','Acier',1100,2);

--
-- Name: Exemplaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Exemplaire_id_seq"', 3, true);

--
-- Data for Name: Arme; Type: TABLE DATA; Schema: public; Owner: postgres
--

UPDATE "Arme" SET id_exemplaire = 1 WHERE id=1;
UPDATE "Arme" SET id_exemplaire = 2 WHERE id=2;

--
-- Name: Exemplaire Exemplaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Exemplaire"
    ADD CONSTRAINT "Exemplaire_pkey" PRIMARY KEY (id);

--
-- Name: Exemplaire one_arme_to_many_object_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Exemplaire"
    ADD CONSTRAINT one_arme_to_many_object_fkey FOREIGN KEY (id_arme) REFERENCES "Arme"(id);

