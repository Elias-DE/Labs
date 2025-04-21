USE ecommerce_system;
/* Inserting sample values into the products table*/

INSERT INTO products (name, category, price, stock_quantity, reorder_level)
VALUES
('Iphone 15 Pro Max', 'Electronics', 699.99, 25, 5),
('Lenovo Legion', 'Electronics', 1299.99, 15, 3),
('Nike T-Shirt', 'Clothing', 19.99, 100, 20),
('Nike Air Force 1', 'Footwear', 89.99, 30, 5),
('Coffee Maker', 'Home Appliances', 49.99, 20, 5),
('Airpods Pro', 'Electronics', 129.99, 40, 10),
('Blender', 'Home Appliances', 79.99, 15, 5),
('Denim Jeans', 'Clothing', 59.99, 75, 15),
('Smart Watch', 'Electronics', 249.99, 20, 5),
('Gaming Console', 'Electronics', 499.99, 10, 3);

/*Inserting sample vaules into the customers table*/
INSERT INTO customers (name, email, phone_number)
VALUES
('Jeffery Ampong', 'jeffampong@gmail.com', '555-123-4567'),
('Michael Smith', 'mike.smith@gmail.com', '555-345-5678'),
('Kwame Appa', 'Kwameapah@outlook.com', '453-242-5415'),
('David Wilson', 'david.wilson@gmail.com', '552-563-2546'),
('Addo Showboy', 'addo.showboy@gmail.com', '233-642-1432');

-- The command above adds sample data to the product and customer tables.
-- New records are added into specific columns in each table. the 'VALUES' keyword indicates that the actual data for the columns are were about to be listed.
-- Columns like product_id have no speficied values because it is an auto-increment primary key that the databases assigns automatically.