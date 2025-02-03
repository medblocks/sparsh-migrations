create materialized view if not exists public.admission_discharge_view as
select
	a.facility_id unit_id,
	a.admitting_practitioner_id admission_consultant_id,
	e.specialization_id admission_department_id,
	a.last_practitioner_id discharge_consultant_id,
	e.specialization_id discharge_department_id,
	a.admission_type_id admission_type_id,
	a.payor_id plan_id,
	p.payor_name plan_name,
	a.sponsor_id sponsor_id,
	a.nursing_unit_id service_center_id,
	a.registration_no mrn,
	a.registration_id patient_id,
	a.encounter_id visit_id,
	e.encounter_date visit_date,
	a.encounter_no ip_no,
	a.bed_id bed_no,
	a.admission_bed_category_id bed_type_id,
	a.last_bed_id current_bed_no,
	a.last_bed_category_id current_bed_key,
	e.encounter_type_id visit_type_id,
	a.id admission_id,
	a.admissionrequest_id admission_no,
	a.case_type_id admission_category,
	a.mark_arrival_date admission_receive_date,
	a.admission_date admission_date,
	a.admission_status admission_status,
	d.informed_date_time mark_discharge_date,
	d.expected_discharge_datetime expected_discharge_date,
	a.discharge_date discharge_date,
	d.id discharge_id,
	d.active discharge_status,
	DATE_PART (
		'day',
		COALESCE(a.discharge_date, NOW ()) - COALESCE(a.admission_date, NOW ())
	) AS los
from
	mhea_replica.adt_admission a
	left join mhea_replica.bt_encounter e on a.encounter_id = e.id
	left join mhea_replica.company_payor_category p on a.payor_id = p.payor_id
	left join mhea_replica.am_bed b on b.id = a.bed_id
	left join mhea_replica.adt_discharge d on d.encounter_id = a.encounter_id
where
	a.facility_id = 32
	OR a.facility_id = 34
	OR a.facility_id = 36
	OR a.facility_id = 37
WITH
	NO DATA;

refresh MATERIALIZED VIEW public.admission_discharge_view;