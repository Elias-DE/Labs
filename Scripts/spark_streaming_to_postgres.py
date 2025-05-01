# Importing necessary libraries and modules
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StringType, IntegerType, StructField
from pyspark.sql.functions import col

# Initializing Spark session
spark = SparkSession.builder \
    .appName("Ecommerce_Stream_Processor") \
    .getOrCreate()

# Defining the data types for each column in the CSV file
schema = StructType([
        StructField("user_id", IntegerType(), False),
        StructField("action", StringType(), False),
        StructField("product", StringType(), False),
        StructField("timestamp", StringType(), False),
    ])

# Reading the CSV file and transforming the timestamp column
df = spark.readStream \
    .option("header", "true") \
    .schema(schema) \
    .csv("/app/data")
    
df_transformed = df.withColumn("timestamp", col("timestamp").cast("timestamp"))

# Writing the transformed data to the console
query = df_transformed.writeStream \
    .format("console") \
    .outputMode("append") \
    .start()

# Waiting for the streaming query to terminate
query.awaitTermination()