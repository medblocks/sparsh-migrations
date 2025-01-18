create materialized view public.consultant_view
as
select 
doctor_id as id,
specialization_name as speciality,
employee_name as name
from mhea_replica.doctor_speciality
with no data;
refresh materialized view public.consultant_view;