from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col, window, avg
from pyspark.sql.types import StructType, IntegerType, TimestampType
import logging

# Setting up logging for proper debugging
logging.basicConfig(level=logging.INFO)
log = logging.getLogger("KafkaToPostgres")

# Defining the expected schema of Kafka messages
def get_schema():
    return StructType() \
        .add("patient_id", IntegerType()) \
        .add("timestamp", TimestampType()) \
        .add("heart_rate", IntegerType())

# Initializing Spark session
def get_spark_session(app_name="KafkaToPostgres"):
    return SparkSession.builder.appName(app_name).getOrCreate()

# Reading data from Kafka topic
def read_kafka_stream(spark, topic, servers):
    return spark.readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", servers) \
        .option("subscribe", topic) \
        .option("startingOffsets", "latest") \
        .load()


# Transforming the stream to a format suitable for analysis
def transform_stream(kafka_df, schema):
    return kafka_df.selectExpr("CAST(value AS STRING)") \
        .select(from_json(col("value"), schema).alias("data")) \
        .select("data.*") \
        .dropna() \
        .withWatermark("timestamp", "1 minute") \
        .groupBy(
            window(col("timestamp"), "1 minute"),
            col("patient_id")
        ).agg(
            avg("heart_rate").alias("avg_heart_rate")
        ) \
        .select(
            col("window.start").alias("timestamp"),
            col("patient_id"),
            col("avg_heart_rate").cast("int").alias("heart_rate")
        )

# Writing the transformed data to PostgreSQL
def write_to_postgres(batch_df, batch_id):
    try:
        batch_df.write \
            .format("jdbc") \
            .option("url", "jdbc:postgresql://postgres:5432/heartbeat_db") \
            .option("dbtable", "heartbeats") \
            .option("user", "postgres") \
            .option("password", "postgres") \
            .option("driver", "org.postgresql.Driver") \
            .mode("append") \
            .save()
        log.info(f"Batch {batch_id} written successfully.")
    except Exception as e:
        log.error(f"Error writing batch {batch_id}: {e}")

# Main function
def main():
    spark = get_spark_session()
    schema = get_schema()

    kafka_df = read_kafka_stream(spark, topic="heartbeat-topic", servers="kafka:9092")
    transformed_df = transform_stream(kafka_df, schema)

    transformed_df.writeStream \
        .foreachBatch(write_to_postgres) \
        .option("checkpointLocation", "/tmp/spark_checkpoint") \
        .start() \
        .awaitTermination()
        
if __name__ == "__main__":
    main()
