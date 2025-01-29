create materialized view public.encounter_view as
select
	id as encounter_id,
	encounter_no,
	encounter_date,
	payor_type,
	payor_id,
	sponsor_id,
	doctor_id,
	specialization_id,
	encounter_type_id,
	registration_id as patient_id
from
	mhea_replica.bt_encounter
where
	facility_id = 32
	OR facility_id = 34
	OR facility_id = 36
	OR facility_id = 37
with
	no data;

refresh materialized view public.encounter_view;