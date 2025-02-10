create materialized view if not exists public.estimate_view as
select distinct
	on (e.id) e.id as unique_id,
	e.facilityid as unit_code,
	e.estimate_no as estimate_code,
	e.entered_date as created_date,
	r.registration_no as patient_mrno,
	r.gender_code as gender,
	r.patient_full_name as patient_name,
	r.mobile_no as mobile_no,
	r.dob as age,
	employee.id as primary_consultant_id,
	d.id as department_id,
	c.id as sponsor_id,
	status.status_value as estimate_type,
	bw.bedcategory_name as admission_category,
	bw.amount as total_estimated_amount,
	e.icustaydays + e.wardstaydays as estimated_los,
	details.service_category_id as service_id,
	details.service_category_name as service_name
from
	mhea_replica.adt_estimate_main as e
	left join mhea_replica.registration as r on r.id = e.registrationid
	left join mhea_master.am_employee as employee on e.admitting_practitioner_id = employee.id
	left join mhea_master.am_department as d on employee.department_id = d.id
	left join mhea_master.am_company as c on c.id = e.sponsorid
	left join mhea_master.am_status_master as status on status.id = e.estimate_type_id
	left join mhea_replica.adt_estimate_bedcatgwise_amt as bw on e.id = bw.estimate_id
	left join mhea_replica.adt_estimate_details as details on details.estimate_id = e.id
where
	e.facilityid = 32
	OR e.facilityid = 33
	OR e.facilityid = 34
	OR e.facilityid = 36
	OR e.facilityid = 37
	OR e.facility_id = 2
	OR e.facility_id = 4
order by
	e.id,
	e.entered_date
with
	no data;

REFRESH MATERIALIZED VIEW public.estimate_view;