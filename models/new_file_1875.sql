MODEL (
    name public.patient,
    cron '@daily',
    kind INCREMENTAL_BY_TIME_RANGE (registration_date),
    grain patient_id,
    dialect mysql
  );


SELECT
  r.id AS patient_id,
  r.RegistrationDate AS registration_date,
  r.RegistrationNo AS mrn,
  r.PatientFullName AS name,
  r.DOB AS date_of_birth,
  r.GenderCode AS gender,
  r.Email AS email,
  r.MobileNo AS mobile_no,
  ra.PresentPINCode AS pin,
  CONCAT (ra.PresentStreet, " ", ra.PresentFlatHouseNo) AS address
FROM
  Base_DB.Registration r
  INNER JOIN Base_DB.RegistrationAddress ra ON r.id = ra.RegistrationId