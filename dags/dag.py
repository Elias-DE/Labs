from include.ingest_data import ingest
from include.transform_and_kpi import transform
from include.load_postgres import load
from datetime import datetime, timedelta
from airflow import DAG
import requests
import pandas as pd
import numpy as np
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator

# Define the DAG
default_args={
        "owner": "Astro",
        "retries": 3,
        "retry_delay": timedelta(minutes=5)}

with DAG(
        dag_id="flight_price_prediction",
        default_args=default_args,
        description="DAG to predict flight prices",
) as dag:
    
    ingest = PythonOperator(
        task_id='ingest_data',
        python_callable=ingest
    )

    # validate = BashOperator(
    #     task_id='validate_data',
    #     bash_command='python3 /opt/airflow/scripts/validate_data.py'
    # )

    # transform = PythonOperator(
    #     task_id='transform_kpi',
    #     python_callable=transform
    # )

    # load = PythonOperator(
    #     task_id='load_to_postgres',
    #     python_callable=load
    # )
    tr_files = transform()
    load = load(tr_files)

    ingest >> tr_files  >> load
