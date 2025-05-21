import pandas as pd
import mysql.connector


def ingest():
    df = pd.read_csv('./Flight_Price_Dataset_of_Bangladesh.csv')

    if df.empty:
        print("DataFrame is empty. No data inserted.")
        return

    # Drop extra column
    df = df.drop(columns=['Stopovers'])
    print(df)
    
    # Rename columns to match SQL table
    df.columns = [
        'airline', 'source', 'source_name', 'destination', 'destination_name',
        'departure_datetime', 'arrival_datetime', 'duration_hrs',
        'aircraft_type', 'class', 'booking_source',
        'base_fare_bdt', 'tax_surcharge_bdt', 'total_fare_bdt',
        'seasonality', 'days_before_departure'
    ]
    df['departure_datetime'] = pd.to_datetime(df['departure_datetime']).dt.strftime('%Y-%m-%d %H:%M:%S')
    df['arrival_datetime'] = pd.to_datetime(df['arrival_datetime']).dt.strftime('%Y-%m-%d %H:%M:%S')

        
    conn = mysql.connector.connect(
        host='mysql',
        user='root',
        password='root',
        database='staging_db',
        port=3306
    )
    cursor = conn.cursor()

    insert_query = """
    INSERT INTO flight_prices (
        airline, source, source_name, destination, destination_name,
        departure_datetime, arrival_datetime, duration_hrs,
        aircraft_type, class, booking_source,
        base_fare_bdt, tax_surcharge_bdt, total_fare_bdt,
        seasonality, days_before_departure
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    data = df[['airline', 'source', 'source_name', 'destination', 'destination_name',
              'departure_datetime', 'arrival_datetime', 'duration_hrs',
              'aircraft_type', 'class', 'booking_source',
              'base_fare_bdt', 'tax_surcharge_bdt', 'total_fare_bdt',
              'seasonality', 'days_before_departure']].values.tolist()
    
    cursor.executemany(insert_query, data)

    conn.commit()
    cursor.close()
    conn.close()

