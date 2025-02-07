create materialized view sponsor_view as
select
	id,
	entered_date as created_date,
	active,
	code,
	description
from
	mhea_master.am_company
where
	enterprise_id = 8
with
	no data;

refresh materialized view sponsor_view;