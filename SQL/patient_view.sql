CREATE MATERIALIZED VIEW IF NOT EXISTS public.patient_view AS
SELECT
  r.id AS patient_id,
  r.registration_date AS registration_date,
  r.registration_no AS mrn,
  r.patient_full_name AS name,
  r.dob AS date_of_birth,
  CAST(r.gender_code as CHAR) AS gender,
  r.email AS email,
  r.mobile_no AS mobile_no,
  ra.present_pin_code AS pin,
  CONCAT (ra.present_street, ' ', ra.present_flat_house_no) AS address,
  rm.present_city as city,
  rm.present_area as district,
  rm.present_country as country
FROM
  mhea_replica.registration AS r
  LEFT JOIN mhea_replica.registration_address AS ra ON r.id = ra.registration_id
  LEFT JOIN mhea_replica.registration_master_data_text rm ON rm.registration_id = r.id
where
  r.enterprise_id = 8
WITH
  NO DATA;

REFRESH MATERIALIZED VIEW public.patient_view;