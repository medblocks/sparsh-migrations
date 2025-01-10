--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-10 12:31:38

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
-- TOC entry 224 (class 1259 OID 16905)
-- Name: consultant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultant (
    consultant_id character varying(50) NOT NULL,
    consultant_name character varying(100),
    consultant_type character varying(50)
);


ALTER TABLE public.consultant OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16899)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    department_name character varying(100),
    department_type character varying(50)
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16898)
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
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 222
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;


--
-- TOC entry 229 (class 1259 OID 16930)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    invoice_id character varying(50) NOT NULL,
    inv_approved_date timestamp without time zone NOT NULL,
    inv_approved_hour integer GENERATED ALWAYS AS (EXTRACT(hour FROM inv_approved_date)) STORED,
    visit_id character varying(50),
    patient_id character varying(50),
    unit_id character varying(50),
    multiplier numeric(10,2),
    inv_plan_id character varying(50)
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16956)
-- Name: invoice_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_line (
    invoice_line_id character varying(50) NOT NULL,
    invoice_id character varying(50),
    service_id character varying(50),
    item_id character varying(50),
    serviceqty integer NOT NULL,
    gross_revenue numeric(12,2) NOT NULL,
    net_revenue numeric(12,2) NOT NULL,
    unit_mrp numeric(12,2) NOT NULL,
    total_mrp numeric(12,2) NOT NULL,
    unit_cp numeric(12,2) NOT NULL,
    total_cp numeric(12,2) NOT NULL,
    ordered_date date NOT NULL,
    revenue_consultant_id character varying(50),
    revenue_department_id integer,
    ref_consultant_id character varying(50),
    ren_consultant_id character varying(50),
    ord_dept_id integer,
    ref_dept_id integer,
    ren_department_id integer,
    unit_purchase_tax numeric(12,2),
    total_purchase_tax numeric(12,2),
    total_tax numeric(12,2),
    disc_discount numeric(12,2),
    non_disc_discount numeric(12,2),
    patient_payable numeric(12,2),
    sponsor_payable numeric(12,2),
    sponsor_id character varying(50),
    plan_id character varying(50),
    service_center_id character varying(50),
    pkg_tariff_group_id character varying(50),
    in_package_id character varying(50)
);


ALTER TABLE public.invoice_line OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16893)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    item_id character varying(50) NOT NULL
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16925)
-- Name: package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package (
    in_package_id character varying(50) NOT NULL,
    pkg_service_id character varying(50)
);


ALTER TABLE public.package OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16880)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    patient_id character varying(50) NOT NULL,
    mrno character varying(50) NOT NULL,
    geography_key character varying(50) NOT NULL
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16915)
-- Name: plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan (
    plan_id character varying(50) NOT NULL
);


ALTER TABLE public.plan OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16887)
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    service_id character varying(50) NOT NULL,
    rendered_date timestamp without time zone,
    rendered_hour integer GENERATED ALWAYS AS (EXTRACT(hour FROM rendered_date)) STORED
);


ALTER TABLE public.service OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16920)
-- Name: service_center; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_center (
    service_center_id character varying(50) NOT NULL
);


ALTER TABLE public.service_center OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16910)
-- Name: sponsor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sponsor (
    sponsor_id character varying(50) NOT NULL
);


ALTER TABLE public.sponsor OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16865)
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit (
    unit_id character varying(50) NOT NULL
);


ALTER TABLE public.unit OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16870)
-- Name: visit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visit (
    visit_id character varying(50) NOT NULL,
    visit_type character varying(20) NOT NULL,
    date_key date NOT NULL,
    visit_no character varying(50) NOT NULL,
    unit_id character varying(50)
);


ALTER TABLE public.visit OWNER TO postgres;

--
-- TOC entry 4744 (class 2604 OID 16902)
-- Name: department department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);


--
-- TOC entry 4761 (class 2606 OID 16909)
-- Name: consultant consultant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultant
    ADD CONSTRAINT consultant_pkey PRIMARY KEY (consultant_id);


--
-- TOC entry 4759 (class 2606 OID 16904)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 4777 (class 2606 OID 16962)
-- Name: invoice_line invoice_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_pkey PRIMARY KEY (invoice_line_id);


--
-- TOC entry 4773 (class 2606 OID 16935)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 4757 (class 2606 OID 16897)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- TOC entry 4769 (class 2606 OID 16929)
-- Name: package package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (in_package_id);


--
-- TOC entry 4751 (class 2606 OID 16886)
-- Name: patient patient_mrno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_mrno_key UNIQUE (mrno);


--
-- TOC entry 4753 (class 2606 OID 16884)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 4765 (class 2606 OID 16919)
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (plan_id);


--
-- TOC entry 4767 (class 2606 OID 16924)
-- Name: service_center service_center_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_center
    ADD CONSTRAINT service_center_pkey PRIMARY KEY (service_center_id);


--
-- TOC entry 4755 (class 2606 OID 16892)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- TOC entry 4763 (class 2606 OID 16914)
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (sponsor_id);


--
-- TOC entry 4747 (class 2606 OID 16869)
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 4749 (class 2606 OID 16874)
-- Name: visit visit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (visit_id);


--
-- TOC entry 4770 (class 1259 OID 17033)
-- Name: idx_invoice_approved_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_approved_date ON public.invoice USING btree (inv_approved_date);


--
-- TOC entry 4774 (class 1259 OID 17036)
-- Name: idx_invoice_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_line_item_id ON public.invoice_line USING btree (item_id);


--
-- TOC entry 4775 (class 1259 OID 17035)
-- Name: idx_invoice_line_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_line_service_id ON public.invoice_line USING btree (service_id);


--
-- TOC entry 4771 (class 1259 OID 17034)
-- Name: idx_invoice_unit_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_unit_id ON public.invoice USING btree (unit_id);


--
-- TOC entry 4779 (class 2606 OID 16951)
-- Name: invoice invoice_inv_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_inv_plan_id_fkey FOREIGN KEY (inv_plan_id) REFERENCES public.plan(plan_id);


--
-- TOC entry 4783 (class 2606 OID 17028)
-- Name: invoice_line invoice_line_in_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_in_package_id_fkey FOREIGN KEY (in_package_id) REFERENCES public.package(in_package_id);


--
-- TOC entry 4784 (class 2606 OID 16963)
-- Name: invoice_line invoice_line_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id);


--
-- TOC entry 4785 (class 2606 OID 16973)
-- Name: invoice_line invoice_line_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4786 (class 2606 OID 16998)
-- Name: invoice_line invoice_line_ord_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_ord_dept_id_fkey FOREIGN KEY (ord_dept_id) REFERENCES public.department(department_id);


--
-- TOC entry 4787 (class 2606 OID 17018)
-- Name: invoice_line invoice_line_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plan(plan_id);


--
-- TOC entry 4788 (class 2606 OID 16988)
-- Name: invoice_line invoice_line_ref_consultant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_ref_consultant_id_fkey FOREIGN KEY (ref_consultant_id) REFERENCES public.consultant(consultant_id);


--
-- TOC entry 4789 (class 2606 OID 17003)
-- Name: invoice_line invoice_line_ref_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_ref_dept_id_fkey FOREIGN KEY (ref_dept_id) REFERENCES public.department(department_id);


--
-- TOC entry 4790 (class 2606 OID 16993)
-- Name: invoice_line invoice_line_ren_consultant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_ren_consultant_id_fkey FOREIGN KEY (ren_consultant_id) REFERENCES public.consultant(consultant_id);


--
-- TOC entry 4791 (class 2606 OID 17008)
-- Name: invoice_line invoice_line_ren_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_ren_department_id_fkey FOREIGN KEY (ren_department_id) REFERENCES public.department(department_id);


--
-- TOC entry 4792 (class 2606 OID 16978)
-- Name: invoice_line invoice_line_revenue_consultant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_revenue_consultant_id_fkey FOREIGN KEY (revenue_consultant_id) REFERENCES public.consultant(consultant_id);


--
-- TOC entry 4793 (class 2606 OID 16983)
-- Name: invoice_line invoice_line_revenue_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_revenue_department_id_fkey FOREIGN KEY (revenue_department_id) REFERENCES public.department(department_id);


--
-- TOC entry 4794 (class 2606 OID 17023)
-- Name: invoice_line invoice_line_service_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_service_center_id_fkey FOREIGN KEY (service_center_id) REFERENCES public.service_center(service_center_id);


--
-- TOC entry 4795 (class 2606 OID 16968)
-- Name: invoice_line invoice_line_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- TOC entry 4796 (class 2606 OID 17013)
-- Name: invoice_line invoice_line_sponsor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_line
    ADD CONSTRAINT invoice_line_sponsor_id_fkey FOREIGN KEY (sponsor_id) REFERENCES public.sponsor(sponsor_id);


--
-- TOC entry 4780 (class 2606 OID 16941)
-- Name: invoice invoice_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- TOC entry 4781 (class 2606 OID 16946)
-- Name: invoice invoice_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


--
-- TOC entry 4782 (class 2606 OID 16936)
-- Name: invoice invoice_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES public.visit(visit_id);


--
-- TOC entry 4778 (class 2606 OID 16875)
-- Name: visit visit_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


-- Completed on 2025-01-10 12:31:38

--
-- PostgreSQL database dump complete
--

