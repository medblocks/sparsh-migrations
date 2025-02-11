create materialized view public.invoice_view as
select distinct
	on (i.id)
	-- selecting unique by invoice id (i.id)
	i.id,
	i.active,
	i.facility_id,
	i.bill_type,
	i.entered_date,
	i.invoice_date,
	i.invoice_no,
	i.registration_id as patient_id,
	i.encounter_id,
	i.encounter_type,
	i.payor_id,
	i.invoice_amount,
	i.gst_amount,
	i.sponsor_id,
	i.add_on_discount,
	i.mou_discount,
	i.invoicestatusid,
	v.doctor_id,
	i.patient_payable_amount
from
	mhea_replica.bt_invoice as i
	left join mhea_replica.bt_invoice_patient_visit as v on i.id = v.invoice_id
where
	facility_id = 32
	OR facility_id = 34
	OR facility_id = 36
	OR facility_id = 37
	OR facility_id = 2
	OR facility_id = 4
	OR facility_id = 33
order by
	i.id,
	i.invoice_date -- adjust ordering as needed
with
	no data;

refresh materialized view public.invoice_view;