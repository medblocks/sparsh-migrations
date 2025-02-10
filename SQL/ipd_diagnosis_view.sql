create materialized view if not exists catalog.ipd_diagnosis_view as
select
	r.patient_full_name,
	r.oldreg_no,
	r.mobile_no,
	r.gender_code,
	r.dob,
	r.registration_no,
	r.registration_id,
	va.diagnosis_notes,
	discharge.encounter_id
from
	mhea_replica.visit_assessments as va
	join mhea_replica.adt_discharge as discharge on va.reference_id = discharge.encounter_id
	join mhea_replica.registration as r on discharge.patient_id = r.id
where
	type = 1
with
	no data;

refresh materialized view catalog.ipd_diagnosis_view;