import typing as t
from datetime import datetime
import pandas as pd
from sqlmesh import ExecutionContext, model
from sqlmesh.core.model.kind import ModelKindName
from sqlalchemy import create_engine


@model(
    "public.patient",
    columns={
        "id": "int",
        "registration_date": "datetime",
        "mrn": "text",
        "name": "text",
        "dob": "text",
        "gender": "text",
        "email": "text",
        "mobile_no": "text",
        "pin": "text",
        "address": "text"
    },
    kind=dict(
        name=ModelKindName.INCREMENTAL_BY_TIME_RANGE,
        time_column="registration_date"
    )
)
def execute(
    context: ExecutionContext,
    start: datetime,
    end: datetime,
    execution_time: datetime,
    **kwargs: t.Any,
):

    db_connection_str = 'mysql+pymysql://read_only:4NjneaNJLNewew@13.200.36.86:3306/Base_DB'
    db_connection = create_engine(db_connection_str)
    q = """
        SELECT
        r.id AS patient_id,
        r.RegistrationDate AS registration_date,
        r.RegistrationNo AS mrn,
        r.PatientFullName AS name,
        r.DOB AS date_of_birth,
        CAST(r.GenderCode as CHAR) AS gender,
        r.Email AS email,
        r.MobileNo AS mobile_no,
        ra.PresentPINCode AS pin,
        CONCAT(ra.PresentStreet, ' ', ra.PresentFlatHouseNo) AS address
        FROM Base_DB.Registration AS r
        INNER JOIN Base_DB.RegistrationAddress AS ra
        ON r.id = ra.RegistrationId
        WHERE r.RegistrationDate >= '{start}'
        AND r.RegistrationDate < '{end}'
    """.format(start=start, end=end)
    df = pd.read_sql(q, db_connection)
    return df
