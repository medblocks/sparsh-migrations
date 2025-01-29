create materialized view public.employee_master as
select 
id,
active,
code,
employee_name,
employee_type_id,
title_id,
gender_code,
department_id,
pin_code,
designation_id
from mhea_master.am_employee
where
enterprise_id = 8
with no data;
refresh materialized view public.employee_master;