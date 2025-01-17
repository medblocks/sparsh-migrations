from dlt.sources.credentials import ConnectionStringCredentials
from dlt.sources.sql_database import sql_database, sql_table, Table
import dlt


@dlt.resource(
    primary_key="patient_id",
    write_disposition="merge"
)
def patient_resource():
    query = """
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
        CONCAT(ra.PresentStreet, " ", ra.PresentFlatHouseNo) AS address
    FROM 
        Base_DB.Registration r
    INNER JOIN 
        Base_DB.RegistrationAddress ra
    ON 
        r.id = ra.RegistrationId
    LIMIT 20
    """
    return sql_table(query)

def main():
    # configure pipeline
    pipeline = dlt.pipeline(
        pipeline_name='patient_pipeline',
        destination='postgres',
        dataset_name='public'
    )

    # run the pipeline with the source
    load_info = pipeline.run(
        patient_resource(),
        table_name="patient",
        write_disposition="merge"
    )

    print(f"Load info: {load_info}")

if __name__ == "__main__":
    main()
