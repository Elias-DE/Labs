DELIMITER //

CREATE PROCEDURE place_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10, 2);
    DECLARE v_stock INT;
    DECLARE v_order_id INT;

    START TRANSACTION;

    -- Create a new order
    INSERT INTO orders(customer_id, total_amount) VALUES (p_customer_id, 0);
    SET v_order_id = LAST_INSERT_ID();

    -- Get product price and stock
    SELECT price, stock_quantity INTO v_price, v_stock
    FROM products
    WHERE product_id = p_product_id;

    -- Check stock availability
    IF v_stock >= p_quantity THEN

        -- Add product to order
        INSERT INTO order_details(order_id, product_id, quantity, price)
        VALUES (v_order_id, p_product_id, p_quantity, v_price);

        -- Update order total
        UPDATE orders
        SET total_amount = p_quantity * v_price
        WHERE order_id = v_order_id;

        -- Reduce stock quantity
        UPDATE products
        SET stock_quantity = stock_quantity - p_quantity
        WHERE product_id = p_product_id;

        -- Log inventory change
        INSERT INTO inventory_logs(product_id, change_quantity, change_type, reference_id)
        VALUES (p_product_id, -p_quantity, 'Order', v_order_id);

        COMMIT;

    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock available';
    END IF;
END;
//

DELIMITER ;

CALL place_order(2, 3, 123);

SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM inventory_logs;