create materialized view if not exists public.billing_view as
select distinct
	on (i.id) i.id as invoice_id,
	i.facility_id as unit_id,
	i.invoice_date as primary_date,
	i.encounter_type as visit_type,
	e.encounter_date as visit_date,
	e.encounter_no as visit_number,
	i.registration_id as patient_id,
	r.registration_no as mrn,
	i.invoice_no as invoice_no,
	i.invoice_date as invoice_date,
	so.service_id as service_billed,
	so.unit as quantity,
	i.invoice_amount as gross_revenue,
	i.invoice_amount - (i.mou_discount + i.add_on_discount) as net_revenue,
	COALESCE(ip.item_id, op.item_id) as item_billed,
	COALESCE(ip.mrp, op.mrp) as mrp_per_unit,
	COALESCE(ip.gross_amount, op.gross_amount) as total_mrp,
	COALESCE(ip.unit_cost, op.unit_cost) as cost_price_per_unit,
	COALESCE(ip.calculated_unit_cost, op.calculated_unit_cost) as total_cost_price,
	som.service_order_date as ordered_date,
	so.doctor_id as rendering_consultant,
	i.mou_discount as disc_discount,
	i.add_on_discount as non_disc_discount,
	i.patient_payable_amount as patient_payable,
	i.payor_amount as sponsor_payable,
	so.under_package as package,
	so.package_id as service_package_id
from
	mhea_replica.bt_invoice as i
	left join mhea_replica.bt_encounter as e on e.id = i.encounter_id
	left join mhea_replica.registration as r on r.id = i.registration_id
	left join mhea_replica.bt_service_order_dtl so on so.invoice_id = i.id
	left join mhea_replica.bt_service_order_main som on som.encounter_id = i.encounter_id
	left join inventory_pipeline4.invt_ip_issue_details ip on ip.invoice_id = i.id
	left join inventory_pipeline4.invt_op_issue_sale_details op on op.invoice_id = i.id
where
	i.facility_id = 32
	OR i.facility_id = 33
	OR i.facility_id = 34
	OR i.facility_id = 36
	OR i.facility_id = 37
	OR i.facility_id = 2
	OR i.facility_id = 4
order by
	i.id,
	i.invoice_date
with
	no data;

REFRESH MATERIALIZED VIEW public.billing_view;