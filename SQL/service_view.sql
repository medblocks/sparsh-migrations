create materialized view if not exists public.service_view as
select
	id,
	modified_date as date,
	code,
	alias,
	description as name,
	department_id
from
	mhea_master.am_service_mst
where
	enterprise_id = 8
	OR enterprise_id = 2
with
	no data;

refresh materialized view public.service_view;