create materialized view public.service_master as
select
	service_id,
	service_code,
	service_name,
	service_category,
	department_id,
	department_sub_id
from
	mhea_master.sparsh_service_master20240120
with
	no data;

refresh materialized view public.service_master;