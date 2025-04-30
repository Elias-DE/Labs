CREATE DATABASE ecommerce_db;
CREATE TABLE IF NOT EXISTS user_events (
    event_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    event_type VARCHAR(20) NOT NULL,  -- 'view', 'purchase', etc.
    product_id VARCHAR(50) NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    event_timestamp TIMESTAMP NOT NULL,
    processed_timestamp TIMESTAMP NOT NULL
);