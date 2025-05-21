import pandas as pd
import mysql.connector
import os

def transform():
    output_dir = "/tmp/flight_prices_transformed/"
    conn = mysql.connector.connect(
        host='mysql',
        user='root',
        password='root',
        database='staging_db',
        port=3306
    )    
    df = pd.read_sql('SELECT * FROM flight_prices', conn)


    # Compute KPIs
    avg_fare_by_airline = df.groupby('airline')['total_fare_bdt'].mean().reset_index()
    booking_count_by_airline = df['airline'].value_counts().reset_index(name='Booking_Count')
    popular_routes = df.groupby(['source', 'destination_name']).size().reset_index(name='Route_Count')


    print(popular_routes)
    
    avg_fare_path = os.path.join(output_dir, 'avg_fare_by_airline.csv')
    booking_count_path = os.path.join(output_dir, 'booking_count_by_airline.csv')
    popular_routes_path = os.path.join(output_dir, 'popular_routes.csv')

    # Save to CSV
    avg_fare_by_airline.to_csv(avg_fare_path, index=False)
    booking_count_by_airline.to_csv(booking_count_path, index=False)
    popular_routes.to_csv(popular_routes_path, index=False)

    return {
        'avg_fare_by_airline': avg_fare_path,
        'booking_count_by_airline': booking_count_path,
        'popular_routes': popular_routes_path
    }
    
