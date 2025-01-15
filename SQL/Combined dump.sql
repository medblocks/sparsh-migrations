
-- Unit table
CREATE TABLE Unit (
    unit_id VARCHAR(50) PRIMARY KEY,
    unit_key VARCHAR(50) UNIQUE,
    unit_code VARCHAR(50),
    hospital_id VARCHAR(50)
);

-- Consultant table
CREATE TABLE Consultant (
    consultant_id VARCHAR(50) PRIMARY KEY,
    consultant_key VARCHAR(50) UNIQUE,
    name VARCHAR(100),
    specialization VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Department table
CREATE TABLE Department (
    department_id VARCHAR(50) PRIMARY KEY,
    department_key VARCHAR(50) UNIQUE,
    name VARCHAR(100),
    unit_id VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (unit_id) REFERENCES Unit(unit_id)
);

-- Plan table
CREATE TABLE Plan (
    plan_id VARCHAR(50) PRIMARY KEY,
    plan_name VARCHAR(100),
    invoice_plan_id VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Sponsor table
CREATE TABLE Sponsor (
    sponsor_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Service Center table
CREATE TABLE Service_Center (
    service_center_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    unit_id VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (unit_id) REFERENCES Unit(unit_id)
);

-- Patient table
CREATE TABLE Patient (
    patient_id VARCHAR(50) PRIMARY KEY,
    mrn VARCHAR(50) UNIQUE,
    name VARCHAR(100),
    gender VARCHAR(20),
    date_of_birth DATE,
    age INT,
    mobile_no VARCHAR(20),
    registration_date DATE,
    address TEXT,
    city VARCHAR(100),
    district VARCHAR(100),
    country VARCHAR(100),
    pin VARCHAR(20),
    email VARCHAR(100)
);

-- Encounter table
CREATE TABLE Encounter (
    visit_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    visit_date DATE,
    ip_no VARCHAR(50),
    visit_type_id VARCHAR(50),
    visit_no VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Bed table
CREATE TABLE Bed (
    bed_id VARCHAR(50) PRIMARY KEY,
    bed_no VARCHAR(50),
    bed_type_id VARCHAR(50),
    current_bed_no VARCHAR(50),
    current_bed_key VARCHAR(50),
    unit_id VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (unit_id) REFERENCES Unit(unit_id)
);

-- Admission table
CREATE TABLE Admission (
    admission_id VARCHAR(50) PRIMARY KEY,
    admission_no VARCHAR(50) UNIQUE,
    admission_category VARCHAR(50),
    admission_receive_date DATE,
    admission_date DATE,
    admission_status VARCHAR(50),
    patient_id VARCHAR(50),
    consultant_id VARCHAR(50),
    department_id VARCHAR(50),
    bed_id VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (consultant_id) REFERENCES Consultant(consultant_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (bed_id) REFERENCES Bed(bed_id)
);

-- Discharge table
CREATE TABLE Discharge (
    discharge_id VARCHAR(50) PRIMARY KEY,
    admission_id VARCHAR(50),
    mark_discharge_date DATE,
    expected_discharge_date DATE,
    discharge_date DATE,
    discharge_status VARCHAR(50),
    los INT,
    consultant_id VARCHAR(50),
    department_id VARCHAR(50),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (consultant_id) REFERENCES Consultant(consultant_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- EMR table
CREATE TABLE EMR (
    emr_id VARCHAR(50) PRIMARY KEY,
    visit_id VARCHAR(50),
    consultation_start_records DATE,
    atleast_one_usage BOOLEAN DEFAULT FALSE,
    overall_usage INT,
    chiefcomplaintrecord TEXT,
    medicalhistoryrecord TEXT,
    vitalsignrecord TEXT,
    generalexaminationrecord TEXT,
    systemicexaminationrecord TEXT,
    investigationorderrecord TEXT,
    lab_service_records TEXT,
    non_lab_service_records TEXT,
    imaging_records TEXT,
    medicationorderrecord TEXT,
    followuprecord TEXT,
    crossconsultationrecord TEXT,
    activemedication TEXT,
    allergyrecord TEXT,
    diagnosisrecord TEXT,
    notesrecord TEXT,
    admissionrequest TEXT,
    diagnosticresultrecord TEXT,
    familyhistoryrecord TEXT,
    surgicalhistoryrecord TEXT,
    socialhistoryrecord TEXT,
    fall_score DECIMAL(5,2),
    created_datetime DATE,
    modified_datetime DATE,
    FOREIGN KEY (visit_id) REFERENCES Encounter(visit_id)
);

-- Estimate table
CREATE TABLE Estimate (
    estimate_code VARCHAR(50) PRIMARY KEY,
    estimate_type VARCHAR(50),
    total_estimated_amount DECIMAL(12,2),
    estimated_los INT,
    patient_id VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Service table
CREATE TABLE Service (
    service_id VARCHAR(50) PRIMARY KEY,
    service_name VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Item table
CREATE TABLE Item (
    item_id VARCHAR(50) PRIMARY KEY,
    batch_number VARCHAR(50),
    item_expiry_date DATE
);

-- Store table
CREATE TABLE Store (
    store_id VARCHAR(50) PRIMARY KEY,
    unit_id VARCHAR(50),
    name VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (unit_id) REFERENCES Unit(unit_id)
);

-- Inventory table
CREATE TABLE Inventory (
    inventory_id VARCHAR(50) PRIMARY KEY,
    transaction_date DATE,
    item_stock_qty INT,
    item_stock_value DECIMAL(12,2),
    item_id VARCHAR(50),
    store_id VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

-- Consumption table
CREATE TABLE Consumption (
    consumption_id VARCHAR(50) PRIMARY KEY,
    consumed_qty INT,
    cost_price DECIMAL(12,2),
    consumption_qty INT,
    consumption_value DECIMAL(12,2),
    issue_qty INT,
    issue_value DECIMAL(12,2),
    item_id VARCHAR(50),
    store_id VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

-- Transfer table
CREATE TABLE Transfer (
    transfer_id VARCHAR(50) PRIMARY KEY,
    transfer_qty INT,
    return_qty INT,
    receipt_qty INT,
    transfer_value DECIMAL(12,2),
    return_value DECIMAL(12,2),
    receipt_value DECIMAL(12,2),
    item_id VARCHAR(50),
    source_store_id VARCHAR(50),
    destination_store_id VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (source_store_id) REFERENCES Store(store_id),
    FOREIGN KEY (destination_store_id) REFERENCES Store(store_id)
);



-- Vendor table
CREATE TABLE Vendor (
    vendor_id VARCHAR(50) PRIMARY KEY,
    quality_segment_1 VARCHAR(50),
    quality_segment_2 VARCHAR(50),
    quality_segment_3 VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Purchase table
CREATE TABLE Purchase (
    purchase_id VARCHAR(50) PRIMARY KEY,
    po_date DATE,
    qty_ordered INT,
    cost_price DECIMAL(12,2),
    po_uom VARCHAR(50),
    po_number VARCHAR(50),
    version VARCHAR(20),
    po_status VARCHAR(50),
    po_type VARCHAR(50),
    grn_date DATE,
    supplier_invoice_date DATE,
    qty_received INT,
    tax_amount DECIMAL(12,2),
    grn_number VARCHAR(50),
    item_id VARCHAR(50),
    vendor_id VARCHAR(50),
    store_id VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

-- Revenue table
CREATE TABLE Revenue (
    revenue_id VARCHAR(50) PRIMARY KEY,
    gross_revenue DECIMAL(12,2),
    net_revenue DECIMAL(12,2),
    patient_payable DECIMAL(12,2),
    sponsor_payable DECIMAL(12,2),
    encounter_id VARCHAR(50),
    FOREIGN KEY (encounter_id) REFERENCES Encounter(visit_id)
);

-- Invoice table
CREATE TABLE Invoice (
    invoice_no VARCHAR(50) PRIMARY KEY,
    invoice_line_id VARCHAR(50),
    invoice_approved_date DATE,
    invoice_approved_hour TIME,
    invoice_status VARCHAR(50),
    revenue_id VARCHAR(50),
    FOREIGN KEY (revenue_id) REFERENCES Revenue(revenue_id)
);

-- Consultation table
CREATE TABLE Consultation (
    consultation_id VARCHAR(50) PRIMARY KEY,
    date_key DATE,
    appointment_id VARCHAR(50),
    consultation_status VARCHAR(50),
    patient_id VARCHAR(50),
    consultant_id VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (consultant_id) REFERENCES Consultant(consultant_id)
);

-- Create indexes for frequently accessed columns
CREATE INDEX idx_patient_mrn ON Patient(mrn);
CREATE INDEX idx_encounter_visit_date ON Encounter(visit_date);
CREATE INDEX idx_admission_date ON Admission(admission_date);
CREATE INDEX idx_discharge_date ON Discharge(discharge_date);
CREATE INDEX idx_invoice_approved_date ON Invoice(invoice_approved_date);
CREATE INDEX idx_item_expiry_date ON Item(item_expiry_date);