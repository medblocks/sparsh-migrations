CREATE MATERIALIZED VIEW IF NOT EXISTS public.billing_dataset
as
select
i."facilityId" as unit_id,
i."encounterType" as  visit_type,
en.encounter_date as date_of_visit,
en.encounter_no as visit_no,
i."registrationId" as patient_id,
r.registration_no as mrno_uhid,
i."invoiceNo" as invoice_no,
sod.invoice_id as invoice_line_id,
date(i."invoiceDate") as invoice_approved_date,
i."invoiceDate" as invoice_approved_hour,
sod.service_id as service_billed,
date(i."invoiceDate") as service_rendered_date,
i."invoiceDate" as service_rendered_hour,
sod.unit as quantity,
i."invoiceAmount" as gross_revenue,
(i."invoiceAmount" - (i."mouDiscount") + (i."addOnDiscount")) as net_revenue,
op."InvoiceId" as item_billed,
op."MRP" as mrp_per_unit,
op."GrossAmount" as total_mrp,
op."UnitCost" as cost_price_per_unit,
op."CalculatedUnitCost" as total_cost_price,
som.service_order_date as ordered_date,
en.doctor_id as revenue_consultant,
sod.department_name as revenue_department,
i."referByName" as referring_consultant,
sod.doctor_name as rendering_consultant,
ad.description as ordered_department,
sm.status_value as invoice_status,
i."mouDiscount" as discretionary_discount,
i."addOnDiscount" as non_discretionary_discount,
i."patientPayableAmount" as patient_payable,
i."payorAmount" as sponsor_payable,
i."sponsorName" as sponsor_key,
i."payorPlanId" as plan_id,
i."payorPlanName" as invoice_plan_id,
sod.under_package as package,
sod.package_id as service_package_id
from
meltano."BT_Invoice" as i
left join mhea_replica.bt_encounter as en on en.id = i."encounterId" 
left join mhea_replica.registration as r on r.id = i."registrationId"
full join mhea_replica.bt_service_order_dtl as sod on sod.invoice_id = i."Id"
left join meltano."INVT_OPIssueSaleDetails" as op on op."InvoiceNo" =i."invoiceNo"
left join mhea_replica.bt_service_order_main as som on som.encounter_id = i."encounterId"
left join mhea_replica.am_employee as ae on ae.id = sod.doctor_id 
inner join mhea_master.am_department as ad on ad.id = ae.department_id
left join mhea_master.am_status_master as sm on sm.id = i.invoicestatusid
with no data;
refresh materialized view public.billing_dataset;