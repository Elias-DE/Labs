# Test Cases for Real-Time E-commerce Data Pipeline

This document outlines a series of manual tests to verify that all components of the system are working correctly.

## Test 1: Data Generator Functionality

**Objective**: Verify that the data generator creates CSV files with the correct format.

**Steps**:
1. Run the data generator for 1 minute:
   ```bash
   python scripts/data_generator.py
   ```
2. Navigate to the data directory and check for CSV files
3. Open a sample CSV file and inspect its contents

**Expected Result**:
- Multiple CSV files should be present in the data directory
- Each CSV file should have the correct header:
  `user_id, action, product, timestamp`
- Values should be present for all fields
- Event types should be 'view' or 'purchase'

## Test 2: Spark Streaming Job Detection

**Objective**: Verify that the Spark streaming job detects and processes new CSV files.

**Steps**:
1. Start the Spark streaming job:
   ```bash
   python scripts/spark_streaming_to_postgres.py
   ```
2. In another terminal, run the data generator
3. Observe the output from the Spark streaming job

**Expected Result**:
- The Spark job should detect new files and report "Processing X records" for each batch
- Sample data from each batch should be displayed
- No errors should be reported

## Test 3: PostgreSQL Data Writing

**Objective**: Verify that processed data is correctly written to PostgreSQL.

**Steps**:
1. Ensure both the data generator and Spark streaming job are running
2. Connect to PostgreSQL:
   ```bash
   docker exec -it postgres_db psql -U postgres -d ecommerce
   ```
3. Check for records in the user_events table:
   ```sql
   SELECT COUNT(*) FROM user_events;
   ```
4. Examine some records:
   ```sql
   SELECT * FROM user_events LIMIT 5;
   ```

**Expected Result**:
- The count should be greater than 0 and increasing over time
- Records should have all fields populated, including the timestamp
- Data types should be correct (e.g., product as string, timestamps as datetime)

## Test 4: End-to-End Data Flow

**Objective**: Verify the complete data flow from generation to storage.

**Steps**:
1. Clear all existing data:
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```
2. Wait for PostgreSQL to initialize
3. Run the data generator for exactly 5 minutes
4. After starting the generator, immediately run the Spark streaming job
5. Check the count of records in PostgreSQL
6. Count the number of events in the CSV files:
   ```bash
   cat data/*.csv | grep -v user_id | wc -l
   ```

**Expected Result**:
- The count in PostgreSQL should match (or be close to) the count from the CSV files
- All data should be processed with no errors

## Test 5: Error Handling and Recovery

**Objective**: Verify that the system can handle errors and recover.

**Steps**:
1. Start the data generator and Spark streaming job
2. Deliberately create a malformed CSV by:
   - Creating a file in the data directory with incorrect number of columns
   - Or creating a file with non-numeric values in the price field
3. Continue running the system and observe behavior

**Expected Result**:
- The system should report an error for the malformed file
- The system should continue processing other files
- Valid data should still be written to PostgreSQL

## Test 6: Performance Under Load

**Objective**: Assess system performance with increased data volume.

**Steps**:
1. Modify the data generator to create more events per batch (e.g., 50-100 events)
2. Run the system for 10 minutes
3. Monitor resource usage:
   ```bash
   docker stats
   ```
4. Check for any delays in processing

**Expected Result**:
- The system should handle the increased load without significant delays
- Resource usage should remain reasonable
- All data should be processed correctly
