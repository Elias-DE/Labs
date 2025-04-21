-- Creating a new order for Elias
CALL create_order(1, @new_order_id);
SELECT @new_order_id;

-- Adding products to the order
CALL add_product_to_order(@new_order_id, 1, 2); -- 2 units of iPhone 15 Pro Max
CALL add_product_to_order(@new_order_id, 3, 5); -- 5 units of Cotton T-Shirt

-- Finalizing the order
CALL finalize_order(@new_order_id);

-- Checking the results
SELECT * FROM orders WHERE order_id = @new_order_id;
SELECT * FROM order_details WHERE order_id = @new_order_id;
SELECT * FROM inventory_logs WHERE reference_id = @new_order_id;
SELECT * FROM products WHERE product_id IN (1, 3);