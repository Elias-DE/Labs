-- Trigger to update order total when order details change
DELIMITER //
CREATE TRIGGER update_order_total
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT SUM(quantity * unit_price)
        FROM order_details
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END;

-- Trigger to update order total when a new order detail is added


CREATE TRIGGER update_order_total
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT SUM(od.quantity * od.unit_price)
        FROM order_details od
        WHERE od.order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END
DELIMITER //