--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-02-13 15:01:25

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16394)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id smallint NOT NULL,
    nombre character varying(256),
    email character varying(256),
    contrasena character varying(256),
    activo boolean
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16400)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 203
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 204 (class 1259 OID 16402)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    id smallint DEFAULT nextval('public.cliente_id_seq'::regclass) NOT NULL,
    nombre character varying(256),
    email character varying(256),
    contrasena character varying(256),
    activo boolean
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16409)
-- Name: carro_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carro_compra (
    id smallint NOT NULL,
    cliente_id smallint,
    foto_id smallint
);


ALTER TABLE public.carro_compra OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16412)
-- Name: carro_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carro_compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carro_compra_id_seq OWNER TO postgres;

--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 206
-- Name: carro_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carro_compra_id_seq OWNED BY public.carro_compra.id;


--
-- TOC entry 207 (class 1259 OID 16414)
-- Name: foto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foto (
    id smallint NOT NULL,
    contenido character varying(256),
    titulo character varying,
    activa boolean DEFAULT true
);


ALTER TABLE public.foto OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16421)
-- Name: foto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.foto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foto_id_seq OWNER TO postgres;

--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 208
-- Name: foto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.foto_id_seq OWNED BY public.foto.id;


--
-- TOC entry 209 (class 1259 OID 16423)
-- Name: lista_deseo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lista_deseo (
    id smallint DEFAULT nextval('public.carro_compra_id_seq'::regclass) NOT NULL,
    cliente_id smallint,
    foto_id smallint
);


ALTER TABLE public.lista_deseo OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16427)
-- Name: orden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orden (
    id smallint NOT NULL,
    fecha date,
    cliente_id smallint,
    total smallint
);


ALTER TABLE public.orden OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16430)
-- Name: orden_detalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orden_detalle (
    id smallint NOT NULL,
    orden_id smallint,
    foto_id smallint
);


ALTER TABLE public.orden_detalle OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16433)
-- Name: orden_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orden_detalle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orden_detalle_id_seq OWNER TO postgres;

--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 212
-- Name: orden_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orden_detalle_id_seq OWNED BY public.orden_detalle.id;


--
-- TOC entry 213 (class 1259 OID 16435)
-- Name: orden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orden_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orden_id_seq OWNER TO postgres;

--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 213
-- Name: orden_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orden_id_seq OWNED BY public.orden.id;


--
-- TOC entry 2724 (class 2604 OID 16437)
-- Name: carro_compra id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carro_compra ALTER COLUMN id SET DEFAULT nextval('public.carro_compra_id_seq'::regclass);


--
-- TOC entry 2722 (class 2604 OID 16438)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 2726 (class 2604 OID 16439)
-- Name: foto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foto ALTER COLUMN id SET DEFAULT nextval('public.foto_id_seq'::regclass);


--
-- TOC entry 2728 (class 2604 OID 16440)
-- Name: orden id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden ALTER COLUMN id SET DEFAULT nextval('public.orden_id_seq'::regclass);


--
-- TOC entry 2729 (class 2604 OID 16441)
-- Name: orden_detalle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_detalle ALTER COLUMN id SET DEFAULT nextval('public.orden_detalle_id_seq'::regclass);


--
-- TOC entry 2872 (class 0 OID 16402)
-- Dependencies: 204
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id, nombre, email, contrasena, activo) FROM stdin;
3	pedro	pedro@fotosparati.com	123123	t
4	Hugo	hugososa29@gmail.com	123456	t
\.


--
-- TOC entry 2873 (class 0 OID 16409)
-- Dependencies: 205
-- Data for Name: carro_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carro_compra (id, cliente_id, foto_id) FROM stdin;
\.


--
-- TOC entry 2870 (class 0 OID 16394)
-- Dependencies: 202
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, nombre, email, contrasena, activo) FROM stdin;
2	Luis	luis@gmail.com	123123	t
1	Hugo Sosa	hugososa29@gmail.com	123456	t
\.


--
-- TOC entry 2875 (class 0 OID 16414)
-- Dependencies: 207
-- Data for Name: foto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foto (id, contenido, titulo, activa) FROM stdin;
1	1.jpg	Verde	t
2	2.jpg	Olas	t
3	3.jpg	Árboles	t
4	4.jpg	ByN	t
12	12.JPG	Luna	t
\.


--
-- TOC entry 2877 (class 0 OID 16423)
-- Dependencies: 209
-- Data for Name: lista_deseo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lista_deseo (id, cliente_id, foto_id) FROM stdin;
1	2	2
\.


--
-- TOC entry 2878 (class 0 OID 16427)
-- Dependencies: 210
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orden (id, fecha, cliente_id, total) FROM stdin;
40	2018-11-08	2	1
41	2018-11-07	2	2
42	2018-11-07	2	3
1	2020-02-13	2	2
2	2020-02-13	1	2
3	2020-02-13	1	2
\.


--
-- TOC entry 2879 (class 0 OID 16430)
-- Dependencies: 211
-- Data for Name: orden_detalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orden_detalle (id, orden_id, foto_id) FROM stdin;
40	40	2
41	41	1
42	41	2
43	42	2
44	42	1
45	42	4
1	1	3
2	1	4
3	2	2
4	2	3
5	3	1
6	3	2
\.


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 206
-- Name: carro_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carro_compra_id_seq', 7, true);


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 203
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 1, true);


--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 208
-- Name: foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.foto_id_seq', 1, false);


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 212
-- Name: orden_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orden_detalle_id_seq', 6, true);


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 213
-- Name: orden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orden_id_seq', 3, true);


--
-- TOC entry 2739 (class 2606 OID 16443)
-- Name: lista_deseo carro_compra_copy1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_deseo
    ADD CONSTRAINT carro_compra_copy1_pkey PRIMARY KEY (id);


--
-- TOC entry 2735 (class 2606 OID 16445)
-- Name: carro_compra carro_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carro_compra
    ADD CONSTRAINT carro_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2733 (class 2606 OID 16447)
-- Name: admin cliente_copy1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT cliente_copy1_pkey PRIMARY KEY (id);


--
-- TOC entry 2731 (class 2606 OID 16449)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2737 (class 2606 OID 16451)
-- Name: foto foto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foto
    ADD CONSTRAINT foto_pkey PRIMARY KEY (id);


--
-- TOC entry 2743 (class 2606 OID 16453)
-- Name: orden_detalle orden_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_detalle
    ADD CONSTRAINT orden_detalle_pkey PRIMARY KEY (id);


--
-- TOC entry 2741 (class 2606 OID 16455)
-- Name: orden orden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (id);


-- Completed on 2020-02-13 15:01:25

--
-- PostgreSQL database dump complete
--

