--narrow results, showing ONLY matching values in both tables
--you'll get less nulls compared to the other joins
SELECT staff.id, staff.name, role.roleType FROM staff
INNER JOIN staff ON role.staffId=staff.id;

--focus on staff table, all records from the left table & matches on right
--often you get nulls on the right
SELECT staff.id, staff.name, role.roleType FROM staff
LEFT JOIN staff ON role.staffId=staff.id;

--focus on role table, all records from the right table & matches on left
--often you get nulls on the left
SELECT staff.id, staff.name, role.roleType FROM staff
RIGHT JOIN staff ON role.staffId=staff.id;

--increase results, terrible performance, all results show even if there are no matches
--you'll probably see lots of nulls on both sides
SELECT staff.id, staff.name, role.roleType FROM staff
FULL OUTER JOIN staff ON role.staffId=staff.id;

--UNION combines the distinct result of multiple tables if they have the same datatypes
--you must also SELECT the same amount of columns in identical orders between statements
SELECT rank FROM staff UNION
SELECT rank FROM role ORDER BY rank;

--UNION ALL allows duplicate values, you may get more results that you want
SELECT rank FROM staff UNION ALL
SELECT rank FROM role ORDER BY rank;

--Joins using actual database travcrashcourse
SELECT customers.firstName, customers.lastName, orders.orderNumber FROM customers
INNER JOIN orders ON
customers.id = orders.customerId
ORDER BY customers.lastName;

SELECT customers.firstName, customers.lastName,
orderNumber, orders.orderDate
FROM customers
LEFT JOIN orders ON customers.id = orders.customerId
ORDER BY customers.lastName;

SELECT orders.orderNumber, customers.firstName, customers.lastName
FROM orders
RIGHT JOIN customers ON orders.customerId = customers.id
ORDER BY orders.orderNumber;

SELECT orders.orderNumber, customers.firstName, customers.lastName, products.name
FROM orders
INNER JOIN products
ON orders.productId = products.id
INNER JOIN customers
ON orders.customerId = customers.id
ORDER BY orders.orderNumber;

