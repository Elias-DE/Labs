# Data Generator script to simulate patient heart rate data and sends to Kafka topic
import random
import time
from datetime import datetime
from kafka import KafkaProducer
import json

# Initializing Kafka Producer
producer = KafkaProducer(
    bootstrap_servers='kafka:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

# Function to generate heartbeat data
def generate_heartbeat():
    while True:
        data = {
            "patient_id": random.randint(1, 10),
            "timestamp": datetime.now().isoformat(),
            "heart_rate": random.randint(20, 200)
        }
        producer.send('heartbeat-topic', data)
        print("Sent:", data)
        time.sleep(1)

generate_heartbeat()
