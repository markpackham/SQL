--a view is a read/SELECT only table based on a real table
--you can use views on user's you don't trust to edit tables

CREATE VIEW order_greater_than_4_view AS
SELECT orderNumber, productId, customerId
FROM orders
WHERE orderNumber > 4;


--if a view already exists and you want to change it use REPLACE
CREATE OR REPLACE VIEW replace_order_less_5_view AS
SELECT orderNumber, productId, customerId
FROM orders
WHERE orderNumber < 4;