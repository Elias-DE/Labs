/* Designing a stock replenishment system for products that fall below the reorder level,
and ensuring that the system replenishes stock, then automatically logs the replenishment to the Inventory_logs table. 
All these is wrapped in a Stored procedure to automate the entire process. */

DELIMITER //
CREATE PROCEDURE replenish_stock(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    -- Updating the product stock
    UPDATE products
    SET stock_quantity = stock_quantity + p_quantity
    WHERE product_id = p_product_id;
    
    -- Logging the inventory change
    INSERT INTO inventory_logs (product_id, quantity_change, reason)
    VALUES (p_product_id, p_quantity, 'REPLENISHMENT');
    
    SELECT 'Stock replenished successfully' AS message;
END;

-- Procedure to automatically replenish all low stock items
CREATE PROCEDURE auto_replenish_low_stock()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE current_stock INT;
    DECLARE reorder_amount INT;
    
    -- Cursor to iterate through low stock products
    DECLARE low_stock_cursor CURSOR FOR
        SELECT product_id, stock_quantity, reorder_level
        FROM products
        WHERE stock_quantity < reorder_level;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN low_stock_cursor;
    
    replenish_loop: LOOP
        FETCH low_stock_cursor INTO pid, current_stock, reorder_amount;
        
        IF done THEN
            LEAVE replenish_loop;
        END IF;
        
        -- Calculating how much to order by restocking twice the reorder level
        SET reorder_amount = (reorder_amount * 2) - current_stock;
        
        -- Calling the replenish procedure
        CALL replenish_stock(pid, reorder_amount);
    END LOOP;
    
    CLOSE low_stock_cursor;
    
    SELECT 'Auto-replenishment completed' AS message;
END;