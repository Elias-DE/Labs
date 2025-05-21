# Bangladesh Flight Price Analysis Pipeline

This project builds an end-to-end data pipeline using Apache Airflow to process and analyze flight price data for Bangladesh. Astronomer was used to handle dag processing activities to avoid potential issues with individual containers running into error. Astronomer ensured a smooth operation of the project using the dag file, and various scripts necessary to complete the project.

---

## Objective

The pipeline ingests flight price data from a CSV file, validates and transforms it, computes key KPIs, and loads the final results into a PostgreSQL database for analytics.



## Tech Stack

| Component    | Purpose                      |
|--------------|------------------------------|
| Apache Airflow | Orchestrate pipeline tasks |
| MySQL        | Staging database              |
| PostgreSQL   | Analytics database            |
| Python & Pandas | Data processing and transformation |
| Docker Compose | Container orchestration     |



