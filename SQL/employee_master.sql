create materialized view public.employee_master as
select 
e.id,
e.active,
e.code,
e.employee_name,
et.description,
e.gender_code,
e.department_id,
e.pin_code,
d.description
from mhea_master.am_employee as e
left join mhea_master.am_designation as d 
on e.designation_id = d.id
left join mhea_master.am_employee_type as et
on e.employee_type_id = et.id
where
enterprise_id = 8
with no data;
refresh materialized view public.employee_master;