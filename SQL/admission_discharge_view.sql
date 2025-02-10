create materialized view public.admission_discharge_view as
select distinct on (a.id)
	a.facility_id as unit_id,
	aod.last_admitting_practitioner_name as admission_consultant_name,
	aod.specialization as admission_department,
	aod.last_admitting_practitioner_name as discharge_consultant_name,
	aod.specialization as discharge_department,
	aod.payor_category_name as admission_type_id,
	aod.payor_plan_name as plan_name,
	aod.sponsor_name as sponsor_name,
	aod.nursing_unit_name as service_center_id,
	a.registration_no as mrn,
	a.registration_id as patient_id,
	a.encounter_id as visit_id,
	a.admission_date as visit_date,
	a.encounter_no ip_no,
	aod.bed_no as bed_no,
	aod.bed_category_name as bed_type,
	aod.last_bed_category_name as current_bed_category_name,
	aod.last_bed_no as current_bed_no,
	aod.admission_source_name as visit_type_name,
	a.id as admission_id,
	aod.case_type_name as admission_category,
	a.mark_arrival_date as admission_receive_date,
	a.admission_date as admission_date,
	aod.encounter_status_name as admission_status,
	dis.initiate_discharge_datetime as mark_discharge_date,
	a.expected_dateof_discharge as expected_discharge_date,
	a.discharge_date as discharge_date,
	dis.id as discharge_id,
	dis.discharge_type_desc as discharge_status
from
	mhea_replica.adt_admission a
	left join mhea_replica.adt_admissionotherdetail aod on a.id = aod.admission_id
	left join mhea_replica.adt_discharge dis on a.encounter_id = dis.encounter_id
where
	a.facility_id = 32
	OR a.facility_id = 34
	OR a.facility_id = 36
	OR a.facility_id = 37
order by a.id, a.admission_date
with
	no data;

refresh materialized view public.admission_discharge_view;