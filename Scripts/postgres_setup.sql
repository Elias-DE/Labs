-- Setting up a PostgreSQL database with a table that stores incoming events.
CREATE DATABASE Amazon_inventory;

-- Created a table to store user events
CREATE TABLE user_events (
    user_id INT,
    action VARCHAR(50),
    product VARCHAR(100),
    timestamp TIMESTAMP
);
