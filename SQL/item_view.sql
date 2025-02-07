create materialized view public.item_view as
select
	id,
	modified_date,
	code,
	item_display_name as name,
	hsn_code,
	unique_cat_description as description
from
	inventory_pipeline4.invm_item_master
where
	enterprise_id = 8
with
	no data;

refresh materialized view public.item_view;