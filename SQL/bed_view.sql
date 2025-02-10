create materialized view public.bed_view as
select
	id,
	active,
	block_name,
	building_name,
	floor_name,
	room_name,
	bed_category_name,
	bed_no,
	bed_flag,
	facility_id,
	bed_status_name,
	level_of_care_id,
	nursing_unit_name,
	nursing_unit_id
from
	mhea_replica.am_bed
where
	facility_id = 32
	OR facility_id = 33
	OR facility_id = 34
	OR facility_id = 36
	OR facility_id = 37
	OR facility_id = 2
	OR facility_id = 4
with
	no data;

refresh materialized view public.bed_view;