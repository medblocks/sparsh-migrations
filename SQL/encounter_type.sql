create materialized view public.encounter_type as
select
	id,
	active,
	code,
	description
from
	mhea_master.am_registration_type
with
	no data;

refresh materialized view public.encounter_type;