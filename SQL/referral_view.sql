create materialized view if not exists public.referral_view as
select
	r.patient_id,
	e.doctor_name as source_doctor,
	e.id as source_doctor_id,
	e.specialization_name as source_dept,
	r.doctor_name_list as destination_doctor,
	specaility_name_list as destination_dept,
	r.specaility_id as destination_dept_id,
	r.doctor_id as destination_doctor_id,
	e.encounter_no as encounter_id,
	status_list as status,
	r.facility_id as facility,
	r.entered_date as referral_date
from
	mhea_replica.emr_referraldetails r
	left join mhea_replica.bt_encounter e on r.encounter_id = e.id
where
	r.facility_id = 32
	OR r.facility_id = 34
	OR r.facility_id = 36
	OR r.facility_id = 37
WITH
	NO DATA;

refresh MATERIALIZED VIEW public.referral_view;