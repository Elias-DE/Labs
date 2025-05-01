# User Guide: Real-Time E-commerce Data Pipeline

This guide will help you run and test the real-time data pipeline system.

## Prerequisites

Before getting started, ensure you have the following installed:
- Docker and Docker Compose
- Git (to clone the repository)

No other installations are needed as all dependencies run inside Docker containers.

## Setup & Installation

1. Clone the project repository (or extract the project files to a directory)

2. Navigate to the project directory:
   ```bash
   cd real-time-pipeline
   ```

3. Start the Docker containers:
   ```bash
   docker-compose up -d
   ```
   This command starts both the PostgreSQL database and Spark container.

4. Wait for about 30 seconds for PostgreSQL to initialize.

## Running the Pipeline

### Step 1: Start the Data Generator

1. Connect to the Spark container:
   ```bash
   docker exec -it spark_streaming bash
   ```

2. Run the data generator script:
   ```bash
   python scripts/data_generator.py
   ```
   
   The script will start generating CSV files with simulated e-commerce data in the `data/` directory.
   
   Leave this terminal window open to continue generating data.

### Step 2: Start the Spark Streaming Job

1. Open a new terminal window and connect to the Spark container again:
   ```bash
   docker exec -it spark_streaming bash
   ```

2. Run the Spark streaming job:
   ```bash
   python scripts/spark_streaming_to_postgres.py
   ```
   
   The job will start monitoring the `data/` directory for new CSV files and process them as they appear.
   
   You should see output showing batches being processed.

### Step 3: Verify the Data in PostgreSQL

1. Open a new terminal window and connect to the PostgreSQL container:
   ```bash
   docker exec -it postgres_db psql -U postgres -d ecommerce
   ```

2. Check that data is being written to the database:
   ```sql
   SELECT COUNT(*) FROM user_events;
   ```
   
   You should see a count that increases as more data is processed.

3. Run some example queries:
   ```sql
   -- Count events by type
   SELECT action, COUNT(*) FROM user_events GROUP BY action;
   
   -- View latest 10 events
   SELECT action, product, timestamp 
   FROM user_events 
   ORDER BY timestamp DESC 
   LIMIT 10;
 
   ```

## Monitoring and Troubleshooting

### Checking Logs

- To view logs from the Spark container:
  ```bash
  docker logs spark_streaming
  ```

- To view logs from the PostgreSQL container:
  ```bash
  docker logs postgres_db
  ```

### Common Issues

1. **No data showing in PostgreSQL**
   - Check if CSV files are being generated in the `data/` directory
   - Verify that the Spark streaming job is running
   - Check for error messages in the Spark logs

2. **Error connecting to PostgreSQL**
   - Ensure PostgreSQL container is running: `docker ps`
   - Check if the connection details in `postgres_connection_details.txt` are correct

## Stopping the Pipeline

1. Press `Ctrl+C` in each terminal window to stop the running scripts

2. Stop the Docker containers:
   ```bash
   docker-compose down
   ```

## Data Persistence

The PostgreSQL data is persisted in a Docker volume named `postgres_data`. This ensures your data remains even if you stop the containers.

To completely reset the system including data:
```bash
docker-compose down -v
```
