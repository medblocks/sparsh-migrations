create materialized view if not exists public.billing_view as
SELECT 
som.facility_id unit_id,
som.service_order_date primary_date,
en.encounter_type_code visit_type,
en.encounter_date date_of_the_visit,
en.encounter_no visit_no,
som.registration_id patient_id,
r.registration_no mrd_no,
sod.invoice_no invoice_no,
iv.invoice_date invoice_approved_date,
sod.id invoice_line_id ,
sod.service_id service_billed,
sod.start_from service_rendered_date,
sod.unit quantity,
(sod.net_amount + sod.mou_service_disc_amount) gross_amount,
(sod.net_amount - sod.service_disc_amount) net_amount,
sod.service_amount mrp_per_unit,
sod.service_amount * (CASE WHEN unit = 0 THEN 1 ELSE unit END) as total_mrp,
sod.actual_service_amount cost_price_per_unit,
sod.actual_service_amount * (CASE WHEN unit = 0 THEN 1 ELSE unit END) as total_cost_price,
som.service_order_date ordered_date,
sod.doctor_name revenue_consultant,
sod.department_name revenue_deepartment,
som.order_doctor_name referring_consultant,
sod.doctor_name rendering_consultant,
ds.specialization_name ordered_department,
ds.specialization_name referring_department,
sod.specialization_name rendering_department,
iv.invoicestatusid invoice_status,
sod.tax_percentage * sod.actual_service_amount AS purchase_tax_for_a_unit,
sod.tax_percentage * sod.actual_service_amount * (CASE WHEN unit = 0 THEN 1 ELSE unit END) as total_purchase_tax,
sod.tax_applied total_tax,
sod.service_disc_amount discretionary_discount,
sod.mou_service_disc_amount non_discretionary_discount,
sod.patient_payable_amount patient_payable,
sod.payor_amount sponsor_payable,
iv.sponsor_id sponsor_id,
iv.payor_plan_id plan_id,
sod.invoice_no invoice_plan_id ,
sod.department_sub_name service_center_id,
0 tarriff_identifier,
sod.package_name package,
sod.package_id service_package_identifier,
ra.present_pin_code 
from mhea_replica.bt_service_order_dtl sod
left join mhea_replica.bt_service_order_main som on som.id = sod.service_order_id 
inner join mhea_replica.bt_invoice iv on sod.invoice_id  = iv.id 
left join mhea_replica.bt_encounter en on en.id = som.encounter_id  
left join mhea_replica.registration r on r.id = som.registration_id 
left join mhea_replica.doctor_speciality ds on ds.doctor_id = som.order_doctor_id 
left join mhea_replica.registration_address ra on r.id = ra.registration_id 
WITH
	NO DATA;
REFRESH MATERIALIZED VIEW public.patient_view;