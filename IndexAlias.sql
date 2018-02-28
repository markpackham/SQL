--create an index for orderName called myOrderNameIndex, users can't see this
--indexes speed up search queries, be sure to DROP the ones you aren't using to save space
CREATE INDEX myOrderNameIndex ON orders(orderName);

--unique results in this index only
CREATE UNIQUE INDEX myOrderNameIndex ON orders(orderName);

--get rid of the index
ALTER TABLE orders
DROP INDEX myOrderNameIndex;

--Aliases can be used to make column names more user friendly to see
SELECT firstName AS 'First Name', lastName AS 'Last Name' FROM customers;

--concat short for concatenation joins fields together so "Name" replaces the two fields
SELECT CONCAT(firstName, ' ',lastName) AS 'Name', address, city, state FROM customers;

SELECT CONCAT(firstName, ' ',lastName) AS 'Name', CONCAT(address,' ',city,' ',state) AS 'Address' FROM customers;

--Short lazy alias to save you from writing full table names out
SELECT o.id, o.orderDate, c.firstName, c.lastName
FROM customers AS c, orders As o;