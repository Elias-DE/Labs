-- Create a view for order summaries
CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    COUNT(od.order_detail_id) AS total_items,
    GROUP_CONCAT(p.name SEPARATOR ', ') AS products
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    o.order_id;


-- Create a view for low stock products
CREATE VIEW low_stock_products AS
SELECT 
    product_id,
    name,
    category,
    stock_quantity,
    reorder_level,
    (reorder_level - stock_quantity) AS units_needed
FROM 
    products
WHERE 
    stock_quantity <= reorder_level;


-- Create a view for customer spending
CREATE VIEW customer_spending AS
SELECT 
    c.customer_id,
    c.name,
    c.email,
    SUM(o.total_amount) AS total_spent,
    CASE
        WHEN SUM(o.total_amount) >= 1000 THEN 'Gold'
        WHEN SUM(o.total_amount) >= 500 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id;


DELIMITER //

CREATE PROCEDURE place_order (
    IN cust_id INT,
    IN prod_id INT,
    IN qty INT
)
BEGIN
    DECLARE unit_price DECIMAL(10,2);
    DECLARE discounted_price DECIMAL(10,2);
    DECLARE discount_rate DECIMAL(5,2);
    DECLARE discount_amount DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Showing base product price
    SELECT price INTO unit_price FROM products WHERE product_id = prod_id;

    -- Determining discount rate
    IF qty >= 50 THEN
        SET discount_rate = 0.15;
    ELSEIF qty >= 20 THEN
        SET discount_rate = 0.10;
    ELSEIF qty >= 10 THEN
        SET discount_rate = 0.05;
    ELSE
        SET discount_rate = 0.00;
    END IF;

    -- Calculating discounted price
    SET discounted_price = unit_price * (1 - discount_rate);
    SET total = discounted_price * qty;
    SET discount_amount = (unit_price - discounted_price) * qty;

    -- Inserting into the Orders table
    INSERT INTO orders (customer_id, order_date, total_amount)
    VALUES (cust_id, CURDATE(), total);

    SET @oid = LAST_INSERT_ID();

    -- Insert into order_details with discount info
    INSERT INTO order_details (order_id, product_id, quantity, price, discount_rate, discount_amount)
    VALUES (@oid, prod_id, qty, discounted_price, discount_rate, discount_amount);

    -- Update inventory
    UPDATE products SET stock_quantity = stock_quantity - qty
    WHERE product_id = prod_id;

    -- Log inventory change
    INSERT INTO inventory_logs (product_id, change_date, change_type, change_quantity)
    VALUES (prod_id, CURDATE(), 'Order', -qty);
END //

DELIMITER ;


CALL place_order(1, 1, 8);   -- No discount
CALL place_order(1, 1, 15);  -- 5%
CALL place_order(1, 1, 25);  -- 10%
CALL place_order(1, 1, 60);  -- 15%

-- Displaying the discounts applied
SELECT 
  od.order_id,
  od.product_id,
  p.name AS product_name,
  od.quantity,
  od.price AS discounted_unit_price,
  od.discount_rate,
  od.discount_amount
FROM order_details od
JOIN products p ON od.product_id = p.product_id
ORDER BY od.order_detail_id DESC;