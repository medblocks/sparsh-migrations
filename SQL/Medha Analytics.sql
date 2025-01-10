--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-10 12:28:00

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
-- TOC entry 224 (class 1259 OID 17072)
-- Name: consultant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultant (
    consultant_id integer NOT NULL,
    consultant_name character varying(100),
    consultant_type character varying(50)
);


ALTER TABLE public.consultant OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17071)
-- Name: consultant_consultant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultant_consultant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consultant_consultant_id_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 223
-- Name: consultant_consultant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultant_consultant_id_seq OWNED BY public.consultant.consultant_id;


--
-- TOC entry 222 (class 1259 OID 17065)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    department_name character varying(100),
    department_type character varying(50)
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17064)
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_department_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 221
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;


--
-- TOC entry 227 (class 1259 OID 17085)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    invoice_no character varying(50) NOT NULL,
    invoice_line_id character varying(50),
    invoice_approved_date timestamp without time zone,
    invoice_status character varying(20),
    primary_date date,
    unit_id character varying(50),
    visit_id integer,
    patient_id character varying(50)
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17106)
-- Name: invoice_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_detail (
    invoice_detail_id integer NOT NULL,
    invoice_no character varying(50),
    service_id integer,
    quantity integer,
    gross_revenue numeric(12,2),
    net_revenue numeric(12,2),
    mrp_per_unit numeric(12,2),
    total_mrp numeric(12,2),
    cost_price_per_unit numeric(12,2),
    total_cost_price numeric(12,2),
    ordered_date date,
    revenue_consultant_id integer,
    revenue_department_id integer,
    total_tax numeric(12,2),
    discretionary_discount numeric(12,2),
    non_discretionary_discount numeric(12,2),
    patient_payable numeric(12,2),
    sponsor_payable numeric(12,2)
);


ALTER TABLE public.invoice_detail OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17105)
-- Name: invoice_detail_invoice_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_detail_invoice_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_detail_invoice_detail_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 228
-- Name: invoice_detail_invoice_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_detail_invoice_detail_id_seq OWNED BY public.invoice_detail.invoice_detail_id;


--
-- TOC entry 232 (class 1259 OID 17142)
-- Name: invoice_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_plan (
    invoice_no character varying(50) NOT NULL,
    plan_id character varying(50) NOT NULL
);


ALTER TABLE public.invoice_plan OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17162)
-- Name: package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package (
    package_id character varying(50) NOT NULL,
    package_name character varying(100),
    service_package_identifier character varying(50)
);


ALTER TABLE public.package OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17057)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    patient_id character varying(50) NOT NULL,
    mrno_uhid character varying(50),
    geography_key character varying(50)
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17137)
-- Name: plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan (
    plan_id character varying(50) NOT NULL,
    plan_name character varying(100)
);


ALTER TABLE public.plan OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17079)
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    service_id integer NOT NULL,
    service_billed character varying(100),
    service_rendered_date timestamp without time zone
);


ALTER TABLE public.service OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17157)
-- Name: service_center; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_center (
    service_center_id character varying(50) NOT NULL,
    center_name character varying(100)
);


ALTER TABLE public.service_center OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17078)
-- Name: service_service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_service_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 225
-- Name: service_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_service_id_seq OWNED BY public.service.service_id;


--
-- TOC entry 230 (class 1259 OID 17132)
-- Name: sponsor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sponsor (
    sponsor_key character varying(50) NOT NULL,
    sponsor_name character varying(100)
);


ALTER TABLE public.sponsor OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17038)
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit (
    unit_id character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.unit OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17046)
-- Name: visit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visit (
    visit_id integer NOT NULL,
    visit_no character varying(50),
    visit_type character varying(20),
    visit_date date,
    patient_id character varying(50),
    unit_id character varying(50)
);


ALTER TABLE public.visit OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17045)
-- Name: visit_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visit_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.visit_visit_id_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 218
-- Name: visit_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visit_visit_id_seq OWNED BY public.visit.visit_id;


--
-- TOC entry 4749 (class 2604 OID 17075)
-- Name: consultant consultant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultant ALTER COLUMN consultant_id SET DEFAULT nextval('public.consultant_consultant_id_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 17068)
-- Name: department department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 17109)
-- Name: invoice_detail invoice_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail ALTER COLUMN invoice_detail_id SET DEFAULT nextval('public.invoice_detail_invoice_detail_id_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 17082)
-- Name: service service_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service ALTER COLUMN service_id SET DEFAULT nextval('public.service_service_id_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 17049)
-- Name: visit visit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visit ALTER COLUMN visit_id SET DEFAULT nextval('public.visit_visit_id_seq'::regclass);


--
-- TOC entry 4763 (class 2606 OID 17077)
-- Name: consultant consultant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultant
    ADD CONSTRAINT consultant_pkey PRIMARY KEY (consultant_id);


--
-- TOC entry 4761 (class 2606 OID 17070)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 4769 (class 2606 OID 17111)
-- Name: invoice_detail invoice_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT invoice_detail_pkey PRIMARY KEY (invoice_detail_id);


--
-- TOC entry 4767 (class 2606 OID 17089)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_no);


--
-- TOC entry 4775 (class 2606 OID 17146)
-- Name: invoice_plan invoice_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_plan
    ADD CONSTRAINT invoice_plan_pkey PRIMARY KEY (invoice_no, plan_id);


--
-- TOC entry 4779 (class 2606 OID 17166)
-- Name: package package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (package_id);


--
-- TOC entry 4757 (class 2606 OID 17063)
-- Name: patient patient_mrno_uhid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_mrno_uhid_key UNIQUE (mrno_uhid);


--
-- TOC entry 4759 (class 2606 OID 17061)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 4773 (class 2606 OID 17141)
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (plan_id);


--
-- TOC entry 4777 (class 2606 OID 17161)
-- Name: service_center service_center_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_center
    ADD CONSTRAINT service_center_pkey PRIMARY KEY (service_center_id);


--
-- TOC entry 4765 (class 2606 OID 17084)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- TOC entry 4771 (class 2606 OID 17136)
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (sponsor_key);


--
-- TOC entry 4753 (class 2606 OID 17044)
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 4755 (class 2606 OID 17051)
-- Name: visit visit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (visit_id);


--
-- TOC entry 4784 (class 2606 OID 17112)
-- Name: invoice_detail invoice_detail_invoice_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT invoice_detail_invoice_no_fkey FOREIGN KEY (invoice_no) REFERENCES public.invoice(invoice_no);


--
-- TOC entry 4785 (class 2606 OID 17122)
-- Name: invoice_detail invoice_detail_revenue_consultant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT invoice_detail_revenue_consultant_id_fkey FOREIGN KEY (revenue_consultant_id) REFERENCES public.consultant(consultant_id);


--
-- TOC entry 4786 (class 2606 OID 17127)
-- Name: invoice_detail invoice_detail_revenue_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT invoice_detail_revenue_department_id_fkey FOREIGN KEY (revenue_department_id) REFERENCES public.department(department_id);


--
-- TOC entry 4787 (class 2606 OID 17117)
-- Name: invoice_detail invoice_detail_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT invoice_detail_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- TOC entry 4781 (class 2606 OID 17100)
-- Name: invoice invoice_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- TOC entry 4788 (class 2606 OID 17147)
-- Name: invoice_plan invoice_plan_invoice_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_plan
    ADD CONSTRAINT invoice_plan_invoice_no_fkey FOREIGN KEY (invoice_no) REFERENCES public.invoice(invoice_no);


--
-- TOC entry 4789 (class 2606 OID 17152)
-- Name: invoice_plan invoice_plan_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_plan
    ADD CONSTRAINT invoice_plan_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plan(plan_id);


--
-- TOC entry 4782 (class 2606 OID 17090)
-- Name: invoice invoice_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


--
-- TOC entry 4783 (class 2606 OID 17095)
-- Name: invoice invoice_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES public.visit(visit_id);


--
-- TOC entry 4780 (class 2606 OID 17052)
-- Name: visit visit_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


-- Completed on 2025-01-10 12:28:00

--
-- PostgreSQL database dump complete
--

