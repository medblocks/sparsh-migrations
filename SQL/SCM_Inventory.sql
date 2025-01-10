--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-10 12:32:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 222 (class 1259 OID 17199)
-- Name: consumption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consumption (
    consumption_id integer NOT NULL,
    hospital_id character varying(50),
    department_id character varying(50),
    store_id character varying(50),
    item_id character varying(50),
    consumed_qty numeric(12,2) NOT NULL,
    cost_price numeric(12,2) NOT NULL,
    consumption_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_cost numeric(12,2) GENERATED ALWAYS AS ((consumed_qty * cost_price)) STORED
);


ALTER TABLE public.consumption OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17198)
-- Name: consumption_consumption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consumption_consumption_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consumption_consumption_id_seq OWNER TO postgres;

--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 221
-- Name: consumption_consumption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consumption_consumption_id_seq OWNED BY public.consumption.consumption_id;


--
-- TOC entry 218 (class 1259 OID 17173)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id character varying(50) NOT NULL,
    hospital_id character varying(50),
    department_name character varying(100)
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17168)
-- Name: hospital; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hospital (
    hospital_id character varying(50) NOT NULL,
    hospital_name character varying(100)
);


ALTER TABLE public.hospital OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17193)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    item_id character varying(50) NOT NULL,
    item_name character varying(100)
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17183)
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store (
    store_id character varying(50) NOT NULL,
    hospital_id character varying(50),
    store_name character varying(100)
);


ALTER TABLE public.store OWNER TO postgres;

--
-- TOC entry 4711 (class 2604 OID 17202)
-- Name: consumption consumption_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption ALTER COLUMN consumption_id SET DEFAULT nextval('public.consumption_consumption_id_seq'::regclass);


--
-- TOC entry 4723 (class 2606 OID 17206)
-- Name: consumption consumption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption
    ADD CONSTRAINT consumption_pkey PRIMARY KEY (consumption_id);


--
-- TOC entry 4717 (class 2606 OID 17177)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 4715 (class 2606 OID 17172)
-- Name: hospital hospital_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital
    ADD CONSTRAINT hospital_pkey PRIMARY KEY (hospital_id);


--
-- TOC entry 4721 (class 2606 OID 17197)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- TOC entry 4719 (class 2606 OID 17187)
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- TOC entry 4724 (class 1259 OID 17230)
-- Name: idx_consumption_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_consumption_date ON public.consumption USING btree (consumption_date);


--
-- TOC entry 4725 (class 1259 OID 17228)
-- Name: idx_consumption_department; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_consumption_department ON public.consumption USING btree (department_id);


--
-- TOC entry 4726 (class 1259 OID 17227)
-- Name: idx_consumption_hospital; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_consumption_hospital ON public.consumption USING btree (hospital_id);


--
-- TOC entry 4727 (class 1259 OID 17229)
-- Name: idx_consumption_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_consumption_item ON public.consumption USING btree (item_id);


--
-- TOC entry 4730 (class 2606 OID 17212)
-- Name: consumption consumption_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption
    ADD CONSTRAINT consumption_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- TOC entry 4731 (class 2606 OID 17207)
-- Name: consumption consumption_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption
    ADD CONSTRAINT consumption_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.hospital(hospital_id);


--
-- TOC entry 4732 (class 2606 OID 17222)
-- Name: consumption consumption_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption
    ADD CONSTRAINT consumption_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4733 (class 2606 OID 17217)
-- Name: consumption consumption_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumption
    ADD CONSTRAINT consumption_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(store_id);


--
-- TOC entry 4728 (class 2606 OID 17178)
-- Name: department department_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.hospital(hospital_id);


--
-- TOC entry 4729 (class 2606 OID 17188)
-- Name: store store_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.hospital(hospital_id);


-- Completed on 2025-01-10 12:32:14

--
-- PostgreSQL database dump complete
--

