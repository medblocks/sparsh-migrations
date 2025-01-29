create materialized view public.bed_type_view as
select
	Id,
	Active,
	Code,
	Description
from
	mhea_master.am_bed_type refresh materialized view public.bed_type_view;