create materialized view public.department_view as
select
	id,
	code,
	description,
	short_description,
	enterprise_id
from
	mhea_master.am_department
where
	enterprise_id = 8
	OR enterprise_id = 2
with
	no data;

refresh materialized view public.department_view;