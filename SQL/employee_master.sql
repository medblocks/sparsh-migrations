drop materialized view public.employee_master;
create materialized view public.employee_master as
select distinct on (e.id)
e.id,
e.active,
e.code,
e.employee_name,
et.description,
e.gender_code,
e.department_id,
e.pin_code,
d.description as designation
from mhea_master.am_employee as e
left join mhea_master.am_designation as d 
on e.designation_id = d.id
left join mhea_master.am_employee_type as et
on e.employee_type_id = et.id
where
enterprise_id = 8
order by e.id, e.code
with no data;
refresh materialized view public.employee_master;