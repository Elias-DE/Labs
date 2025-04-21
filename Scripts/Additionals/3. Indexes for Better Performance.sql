-- Creating indexes to improve query performance
CREATE INDEX idx_product_category ON products(category);
CREATE INDEX idx_product_stock ON products(stock_quantity);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_log_date ON inventory_logs(log_date);
CREATE INDEX idx_log_product ON inventory_logs(product_id);