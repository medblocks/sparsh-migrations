create materialized view public.facility_view as
select
	id,
	description,
	enterprise_id,
	code,
	facility_address,
	pin_code,
	enterprise_name,
	facility_long_name,
	facility_short_name
from
	mhea_replica.am_facility
where
	id = 32
	or id = 34
	or id = 36
	or id = 37
	OR id = 2
	OR id = 4
	OR id = 33
limit
	10
with
	no data;

refresh materialized view public.facility_view;