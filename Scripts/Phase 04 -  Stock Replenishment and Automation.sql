/* Designing a stock replenishment system for products that fall below the reorder level,
and ensure the system replenishes stock by adding 50 more quantities, then
automatically logging the replenishment to the Inventory_logs table. 
All these is wrapped in a Stored procedure to automate the entire process. */

DELIMITER //
CREATE PROCEDURE ReplenishStock()
BEGIN
	-- Adding 50 units to low-stock products
UPDATE products
SET stock_quantity = stock_quantity + 50
WHERE stock_quantity < reorder_level;
	-- Logging the replenishment based on pre-update stock level
INSERT INTO inventory_logs (product_id, change_date, change_type, change_quantity)
SELECT
	product_id,
    CURDATE(),
    'Replenishment',
    50
    FROM products
    WHERE stock_quantity - 50 < reorder_level;
END //
DELIMITER ;


/* Dusplaying replenished stock & logs. This shows
products now in good stock and also inventory logs fro replenishments. */

SELECT name, stock_quantity, reorder_level
FROM products
WHERE stock_quantity >= reorder_level;

SELECT * FROM inventory_logs
WHERE change_type = 'Replenishment'
ORDER BY log_id DESC;