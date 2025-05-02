# This script demonstrates how to connect Apache Spark to PostgreSQL using the JDBC driver.

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit, when
from pyspark.sql.types import StructType, StringType, IntegerType, StructField
import os
import sys

# Defining the data types for each column in the CSV file
schema = StructType([
        StructField("user_id", IntegerType(), False),
        StructField("action", StringType(), False),
        StructField("product", StringType(), False),
        StructField("timestamp", StringType(), False),
    ])

def create_spark_session():
    spark = SparkSession.builder \
        .appName("Spark PostgreSQL Connection") \
        .getOrCreate()
    
    spark.sparkContext.setLogLevel("WARN")
    return spark

# Reading the CSV file and transforming the timestamp column

def main():
    # Get PostgreSQL connection details
    postgres_host = os.environ.get("POSTGRES_HOST", "postgres")
    postgres_port = os.environ.get("POSTGRES_PORT", "5432")
    postgres_db = os.environ.get("POSTGRES_DB", "amazon_inventory")
    postgres_user = os.environ.get("POSTGRES_USER", "postgres")
    postgres_password = os.environ.get("POSTGRES_PASSWORD", "Eliasdaniel7!")
    
    jdbc_url = f"jdbc:postgresql://{postgres_host}:{postgres_port}/{postgres_db}"
    
    spark = create_spark_session()

    df = spark.readStream \
        .option("header", "true") \
        .schema(schema) \
        .csv("/app/data")

    df_transformed = df.withColumn("timestamp", col("timestamp").cast("timestamp"))
    
    def process_batch(batch_df, batch_id):
        batch_df.write \
            .format("jdbc") \
            .option("url", jdbc_url) \
            .option("dbtable", "user_events") \
            .option("user", postgres_user) \
            .option("password", postgres_password) \
            .option("driver", "org.postgresql.Driver") \
            .mode("append") \
            .save()
            
    # query = df_transformed.writeStream \
    #     .format("console") \
    #     .outputMode("append") \
    #     .start()

    query = df_transformed.writeStream \
         .outputMode("append") \
         .foreachBatch(process_batch) \
         .start()

    query.awaitTermination()

main()

# This code reads the CSV file and transforms the timestamp column to a timestamp data type.
# It then writes the transformed data to a PostgreSQL database using the JDBC connector.
# The writeStream method is used to create a streaming query that writes the data to the database in batches.
# The foreachBatch method is used to define the processing logic for each batch.
# The process_batch method is called for each batch and writes the data to the database using the JDBC connector.
# The awaitTermination method is used to wait for the streaming query to finish.