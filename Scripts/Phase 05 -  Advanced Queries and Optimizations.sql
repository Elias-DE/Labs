/* Creating a view that summarizes order information, showing details such as customer name,
order date, total amount. and number of items in each order. 
This view simplifies data access*/

-- This View summarizes order information
CREATE VIEW order_summary AS
SELECT o.order_id, c.name AS customer_name, o.order_date, 
       o.total_amount, COUNT(od.order_detail_id) AS number_of_items,
       SUM(od.quantity) AS total_quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- This View displays stock information
CREATE VIEW stock_status AS
SELECT p.product_id, p.name, p.category, p.price,
       p.stock_quantity, p.reorder_level,
       CASE
           WHEN p.stock_quantity <= p.reorder_level THEN 'Low Stock'
           WHEN p.stock_quantity <= p.reorder_level * 2 THEN 'Adequate'
           ELSE 'Well Stocked'
       END AS stock_status
FROM products p;