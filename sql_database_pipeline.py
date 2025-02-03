# flake8: noqa
from typing import Any
import os
import unicodedata

import dlt
from dlt.common import pendulum
from dlt.sources.credentials import ConnectionStringCredentials
from pydantic import BaseModel
from dlt.sources.sql_database import sql_database, sql_table, Table

from sqlalchemy.sql.sqltypes import TypeEngine
import sqlalchemy as sa
from prefect import flow


def convert_latin1_to_utf8(data):
    if isinstance(data, str):
        return unicodedata.normalize('NFKD', data.encode('latin1').decode('utf8', 'ignore'))
    return data


def clean_bt_invoice(data):
    return {k: convert_latin1_to_utf8(v) for k, v in data.items()}


@flow(log_prints=True, name="MHEA Phase 1 pipeline")
def create_mhea_pipeline():
    pipeline = dlt.pipeline(
        pipeline_name="mhea", destination='postgres', dataset_name="mhea_replica")

    # Configure the source to load a few select tables increentally
    source_1 = sql_database().with_resources("Registration", "RegistrationAddress", "AM_State",
                                             "AM_Nationality", "AM_City", "emr_referraldetails", "__DoctorSpeciality", "BT_Encounter", "ADT_PatientBedStatus", "AM_Bed", "ADT_Admission", "BT_Invoice", "adt_discharge", "__CompanyPayorCategory", "visit_assessments", "BT_ServiceOrderMain", "BT_ServiceOrderDtl", "AM_Employee", "AM_Facility", "AM_EmployeeFacilityMappingDoNotDelete", "AM_EmployeeDoNotDelete", "BT_InvoicePatientVisit")

    # Add incremental config to the resources. "updated" is a timestamp column in these tables that gets used as a cursor
    source_1.Registration.apply_hints(
        incremental=dlt.sources.incremental("RegistrationDate"), primary_key="Id")
    source_1.RegistrationAddress.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.BT_Encounter.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.ADT_Admission.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.BT_Invoice.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.adt_discharge.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.visit_assessments.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.BT_ServiceOrderMain.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.BT_ServiceOrderDtl.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.AM_Employee.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.AM_Facility.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.AM_EmployeeFacilityMappingDoNotDelete.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.AM_EmployeeDoNotDelete.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.BT_InvoicePatientVisit.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")

    # Run the pipeline. The merge write disposition merges existing rows in the destination by primary key
    info = pipeline.run(source_1, write_disposition="merge")
    print(info)


@flow(log_prints=True, name="MHEA Master mapping pipeline")
def create_master_pipeline():
    pipeline2 = dlt.pipeline(
        pipeline_name="mhea_master", destination='postgres', dataset_name="mhea_master")

    source_2 = sql_database().with_resources("__AM_Employee", "__SARSH_Surgery_MASTER20240118", "__SparshServiceMaster20240120", "__SparshTariff23102024", "__Sparsh_Employee_Master", "__Sparsh_Specialization", "__Sparsh_Nomenclature", "__SParshEquipmentCharges", "AM_Department", "AM_FacilityDepartmentMapping", "AM_Role", "AM_RoleDepartmentMapping",
                                             "AM_RoleFacilityMapping", "AM_Designation", "AM_Company", "AM_CompanySponsorMapping", "AM_CompanyFacilityMapping", "__RRNagar_Payor_Master", "__YPRPayorSponsor", "__YPR_PayorMaster", "AM_EmployeeType", "AM_DepartmentSub", "AM_AdmissionType", "AM_RegistrationType", "AM_BedType", "__RRNAGAR_BedMaster", "__YeshwantpurBedMaster")

    source_2.__AM_Employee.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")

    info = pipeline2.run(source_2, write_disposition="merge")
    print(info)


@flow(log_prints=True, name="Inventory Master mapping pipeline")
def inventory_master_pipeline():
    pipeline3 = dlt.pipeline(
        pipeline_name="inventory_pipeline", destination='postgres', dataset_name="inventory_pipeline")

    invoice_columns = [
        "Id",
        "Active",
        "EnteredDate",
        "ModifiedDate",
        # "enterpriseId",
        "facilityId",
        "invoiceNo",
        "invoiceDate",
        # "billType",
        "registrationId",
        "encounterId",
        "encounterType",
        "invoiceAmount",
        "mouDiscount",
        "addOnDiscount",
        "patientAmount",
        "gstAmount",
        "payorAmount",
        "patientPayableAmount",
        "invoicestatusid",
        "facilityName",
    ]

    invoice_table = sql_table(
        table="BT_Invoice", incremental=dlt.sources.incremental('ModifiedDate'),
        included_columns=invoice_columns
    )

    pipeline3.run(invoice_table, write_disposition="merge")


if __name__ == "__main__":
    create_master_pipeline()
    create_mhea_pipeline()
    # inventory_master_pipeline()
