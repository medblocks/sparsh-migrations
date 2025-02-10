create materialized view public.sub_department_view as
select
	id,
	active,
	department_id,
	code,
	description,
	short_description,
	department_type
from
	mhea_master.am_department_sub
where
	enterprise_id = 8
	OR enterprise_id = 2
with
	no data;

refresh materialized view public.sub_department_view;