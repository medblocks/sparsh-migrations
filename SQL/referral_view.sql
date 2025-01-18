create materialized view if not exists public.referral_view as
select
	r.patient_id,
	e.doctor_name as source_doctor,
	e.specialization_name as source_dept,
	r.doctor_name_list as destination_doctor,
	specaility_name_list as destination_dept,
	e.encounter_no as encounter_id,
	status_list as status
from
	mhea_replica.emr_referraldetails r
	inner join mhea_replica.bt_encounter e on r.encounter_id = e.id
WITH
	NO DATA;

refresh MATERIALIZED VIEW public.referral_view;