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


@flow(log_prints=True, name="MHEA Base database migration pipeline")
def create_mhea_pipeline():
    # Base_DB
    pipeline = dlt.pipeline(
        pipeline_name="mhea", destination='postgres', dataset_name="mhea_replica")

    # Configure the source to load a few select tables increentally
    source_1 = sql_database().with_resources("Registration", "RegistrationAddress", "AM_State",
                                             "AM_Nationality", "AM_City", "emr_referraldetails", "__DoctorSpeciality", "BT_Encounter", "ADT_PatientBedStatus", "AM_Bed", "ADT_Admission", "BT_Invoice", "adt_discharge", "__CompanyPayorCategory", "visit_assessments", "BT_ServiceOrderMain", "BT_ServiceOrderDtl", "AM_Employee", "AM_Facility", "AM_EmployeeFacilityMappingDoNotDelete", "AM_EmployeeDoNotDelete", "BT_InvoicePatientVisit", "ADT_admissionotherdetail", "adt_estimate_main", "adt_estimate_bedcatgwise_amt", "adt_estimate_details", "registration_master_data_text")

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
    source_1.ADT_admissionotherdetail.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.adt_estimate_main.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.adt_estimate_details.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_1.registration_master_data_text.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")

    # Run the pipeline. The merge write disposition merges existing rows in the destination by primary key
    info = pipeline.run(source_1, write_disposition="merge")
    print(info)


@flow(log_prints=True, name="MHEA Master mapping pipeline")
def create_master_pipeline():
    # Master_DB
    pipeline2 = dlt.pipeline(
        pipeline_name="mhea_master", destination='postgres', dataset_name="mhea_master")

    source_2 = sql_database().with_resources("__AM_Employee", "AM_Department", "AM_FacilityDepartmentMapping", "AM_Role", "AM_RoleDepartmentMapping",
                                             "AM_RoleFacilityMapping", "AM_Designation", "AM_Company", "AM_CompanySponsorMapping", "AM_CompanyFacilityMapping", "AM_EmployeeType", "AM_DepartmentSub", "AM_AdmissionType", "AM_RegistrationType", "AM_BedType", "AM_StatusMaster", "AM_ServiceMst")

    source_2.__AM_Employee.apply_hints(
        incremental=dlt.sources.incremental("EnteredDate"), primary_key="Id")
    source_2.AM_StatusMaster.apply_hints(
        incremental=dlt.sources.incremental("ModifiedDate"), primary_key="Id")
    source_2.AM_ServiceMst.apply_hints(
        incremental=dlt.sources.incremental("ModifiedDate"), primary_key="Id")

    info = pipeline2.run(source_2, write_disposition="merge")
    print(info)


@flow(log_prints=True, name="Inventory Master mapping pipeline")
def inventory_master_pipeline():
    # Inventory_DB
    pipeline3 = dlt.pipeline(
        pipeline_name="inventory_pipeline4", destination='postgres', dataset_name="inventory_pipeline4")
    source_3 = sql_database().with_resources(
        "INVT_OPIssueSaleDetails", "INVT_IPIssueDetails", "INVM_ItemMaster")
    source_3.INVT_OPIssueSaleDetails.apply_hints(
        incremental=dlt.sources.incremental("ModifiedDate"), primary_key="Id")
    source_3.INVT_IPIssueDetails.apply_hints(
        incremental=dlt.sources.incremental("ModifiedDate"), primary_key="Id")
    source_3.INVM_ItemMaster.apply_hints(
        incremental=dlt.sources.incremental("ModifiedDate"), primary_key="Id")
    pipeline3.run(source_3, write_disposition="merge")


if __name__ == "__main__":
    create_master_pipeline()
    create_mhea_pipeline()
    inventory_master_pipeline()
