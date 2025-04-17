CREATE DATABASE ecommerce_system;
/* This creates a new database named 'ecommerce_system' to store all the tables and data. */
USE ecommerce_system; -- This switches to using this database for subsequent queries.



-- Creating All Tables
/*Creating Products table. The table stores information about each product. 
product_id: Unique ID for each product. It assigns an index for each new row
name, category: Product name and its category (e.g electronics, clothing)
Price: The price of a signel item
stock_quantity: How many units are currently in stock
reorder_level: The minimum stock level at which the system should trigger a reorder */
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 5
);



/*Creating Customers table to keep customer information.
customer_id: Unique customer id. It increases automatically.
name, email, phone: customer's details
*/
CREATE TABLE Customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
email VARCHAR(100),
phone_number VARCHAR(50)
);



/*Creating Orders table to record orders made by customers.
order_id: Unique ID for each order.
customer_id: This links the order to a customer (The FOREIGN KEY function creates a relationship).
order_date: This records the time the order was placed.
total_amount: Total cost of the order.
status: Tracks order progress
*/
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



/*Creating Order Details table as a junction table to break down orders into individual items.
order_detail_id: Unique ID for this entry.
order_id: Which order this item belongs to.
product_id: Which product was ordered.
quantity: Number of units of this product in the order.
price_each: Unit price at the time of order.
*/
CREATE TABLE Order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



/*Creating Inventory Logs table to track inventory changes over time.
log_id: Unique entry ID.
product_id: Which product was affected.
change_quantity: The change amount.
reason: Why the change occurred (e.g., "Order", "Restock").
reference_id: Optional reference (e.g., related order ID).
log_date: When the change happened.*/
CREATE TABLE Inventory_logs (
log_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
change_quantity INT,
change_date DATE,
change_type VARCHAR(50),
reference_id INT,
log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (product_id) REFERENCES products(product_id)
);