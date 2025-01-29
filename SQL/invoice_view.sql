select
	id,
	active,
	facility_id,
	bill_type,
	entered_date,
	invoice_date,
	invoice_no,
	registration_id as patient_id,
	encounter_id,
	encounter_type,
	payor_id,
	invoice_amount,
	gst_amount,
	employer_id,
	sponsor_id,
	add_on_discount,
	mou_discount,
	invoicestatusid
from
	mhea_replica.bt_invoice
where
	facility_id = 32
	OR facility_id = 34
	OR facility_id = 36
	OR facility_id = 37
limit
	20;