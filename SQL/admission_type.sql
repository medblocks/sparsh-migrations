create materialized view public.admission_type as
select
	id,
	active,
	code,
	description
from
	mhea_master.am_admission_type
with
	no data;

refresh materialized view public.admission_type;