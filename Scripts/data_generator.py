# Importing the required libraries
import csv
import random
import time
from datetime import datetime

actions = ['view', 'purchase']
products = ['laptop', 'headphones', 'keyboard', 'mouse']
user_ids = range(1001, 1011)

# Defining the function to generate event
def generate_event():
    return {
        "user_id": random.choice(user_ids),
        "action": random.choice(actions),
        "product": random.choice(products),
        "timestamp": datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }

while True:
    filename = f"data/event_{int(time.time())}.csv"
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=["user_id", "action", "product", "timestamp"])
        writer.writeheader()
        for _ in range(random.randint(5, 10)):
            writer.writerow(generate_event())
    print(f"Generated {filename}")
    time.sleep(1)
    
# Events are generated and stored in a CSV file named event_<timestamp>.csv every second.
