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
  tc.description as district,
  ts.description as state,
  tn.description as country
FROM
  mhea_replica.registration AS r
  LEFT JOIN mhea_replica.registration_address AS ra ON r.id = ra.registration_id
  LEFT JOIN mhea_replica.am_city as tc on ra.present_city_id = tc.id
  LEFT JOIN mhea_replica.am_state as ts on ra.present_state_id = ts.id
  LEFT JOIN mhea_replica.am_nationality as tn on ra.present_country_id = tn.id
where
  r.enterprise_id = 8
WITH
  NO DATA;

REFRESH MATERIALIZED VIEW public.patient_view;