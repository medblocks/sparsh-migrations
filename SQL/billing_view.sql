create materialized view if not exists public.billing_view as
SELECT
	i."facilityId" as unit_id,
	i."invoiceDate" as primary_date,
	i."encounterType" as visit_type,
	i."EnteredDate" as date_of_the_visit,
	r.registration_no as mrno_uhid,
	i."invoiceNo" as invoice_no,
	sodtl.invoice_id as invoice_line_id,
	i."invoiceDate" as invoice_approved_date,
	sodtl.service_id as service_billed,
	i."invoiceDate" as service_rendered_date,
	sodtl.unit as quantity,
	i."invoiceAmount" as gross_revenue,
	(
		i."invoiceAmount" - (i."mouDiscount") + (i."addOnDiscount")
	) as net_revenue,
	op."InvoiceId" as item_billed,
	op."MRP" as mrp_per_unit,
	op."GrossAmount" as total_mrp,
	op."UnitCost" as cost_price_per_unit,
	op."CalculatedUnitCost" as total_cost_price,
	som.service_order_date as ordered_date,
	i."mouDiscount" as discretionary_discount,
	i."addOnDiscount" as non_discretionary_discount,
	i."patientPayableAmount" as patient_payable,
	i."payorAmount" as sponsor_payable,
	i."sponsorName" as sponsor_key,
	i."payorPlanId" as plan_id,
	i."payorPlanName" as invoice_plan_id
from
	meltano."BT_Invoice" as i
	left join mhea_replica.registration as r on r.id = i."registrationId"
	left join mhea_replica.bt_service_order_dtl as sodtl on sodtl.invoice_id = i."Id"
	left join meltano."INVT_OPIssueSaleDetails" as op on op."InvoiceNo" = i."invoiceNo"
	left join mhea_replica.bt_service_order_main as som on som.encounter_id = i."encounterId"
where
	i."facilityId" = 32
	OR i."facilityId" = 34
	OR i."facilityId" = 36
	OR i."facilityId" = 37
with
	no data;

REFRESH MATERIALIZED VIEW public.billing_view;