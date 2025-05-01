# Real-Time E-commerce Data Pipeline: Project Overview

## System Components

### 1. Data Generator (`data_generator.py`)
This component simulates the behavior of users on an e-commerce platform by generating events such as product views, adding items to cart, and purchases. It creates CSV files with this simulated data at regular intervals of 5 seconds.

Key features:
- Generates realistic user IDs, product information, and timestamps
- Creates a variety of event types with realistic distribution (more views than purchases)
- Writes data to CSV files in a designated directory
- Runs continuously, creating new files every 1-3 seconds

### 2. Spark Streaming Application (`spark_streaming_to_postgres.py`)
This component monitors the data directory for new CSV files, processes them as they appear, and writes the processed data to PostgreSQL.

Key features:
- Uses Spark Structured Streaming to detect and process new files
- Validates and transforms incoming data according to a predefined schema
- Adds a processing timestamp to each record
- Writes records to PostgreSQL in real-time

### 3. PostgreSQL Database
A relational database that stores all processed events, enabling queries and analysis.

Key features:
- Schema optimized for e-commerce event data
- Indexes to improve query performance
- Views and functions for common analytical needs

## Data Flow

1. The data generator creates CSV files containing e-commerce events
2. Spark Structured Streaming detects new files as they appear
3. Spark reads, validates, and processes the data
4. Processed data is written to PostgreSQL
5. The data becomes available for querying and analysis

## System Architecture Diagram

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Data Generator │     │   CSV Files     │     │ Spark Streaming │     │   PostgreSQL    │
│                 │────>│  (data/*.csv)   │────>│    Process      │────>│    Database     │
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
        │                                                                        │
        │                                                                        │
        └────────────────────────────────────────────────────────────────────────┘
                          Data Analysis & Visualization
```
