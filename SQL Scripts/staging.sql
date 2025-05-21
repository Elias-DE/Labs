CREATE DATABASE staging_db;

CREATE TABLE flight_prices (
    id SERIAL PRIMARY KEY,
    airline VARCHAR(100),
    source VARCHAR(50),
    source_name VARCHAR(100),
    destination VARCHAR(50),
    destination_name VARCHAR(100),
    departure_datetime DATETIME,
    arrival_datetime DATETIME,
    duration_hrs DECIMAL(5,2), 
    aircraft_type VARCHAR(100),
    class VARCHAR(50), 
    booking_source VARCHAR(100),
    base_fare_bdt DECIMAL(10,2),
    tax_surcharge_bdt DECIMAL(10,2),
    total_fare_bdt DECIMAL(10,2),
    seasonality VARCHAR(50),
    days_before_departure INT
);
