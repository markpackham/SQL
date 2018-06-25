--INNER JOIN is the DEFAULT, you don't need to write INNER
SELECT tableA.aID, tableB.names
FROM tableA
JOIN tableB ON tableA.aID = tableB.foreignKey

--BETWEEN
SELECT * FROM customers
WHERE age
BETWEEN 5 AND 20;

--LIKE/NOT LIKE with wildcard
SELECT * FROM customers
WHERE town LIKE '%ondon';

SELECT * FROM customers
WHERE town NOT LIKE '%o%';

--IN for multiple values
SELECT * FROM customers
WHERE town IN ('London','LA','Stoke');

--INDEX (only use for frequently searched columns - people do not see indexes)
CREATE INDEX CIndex
ON customers (city);

SELECT city FROM customers; --Search much faster

DROP INDEX CIndex
ON customers;

--FOREIGN KEY syntax

CREATE TABLE orders(
 id INT NOT NULL AUTO_INCREMENT,
 customerId INT,
 productId INT,
 PRIMARY KEY (id),
 FOREIGN KEY (customerId) REFERENCES customers(id),
 FOREIGN KEY (productId) REFERENCES products(id)
); 

--ALIAS for more human readable column names
SELECT firstName AS 'First Name' FROM customers;

SELECT o.id, o.orderDate, c.firstName, c.lastName
FROM customers AS c, orders AS o;

--CONCAT so you get a Name column with names like "John Smith"
SELECT CONCAT(firstName, '',lastName) AS 'Name'
FROM customers;

--UCASE, LCASE (upper & lower case)
SELECT UCASE(firstName), LCASE(lastName) FROM customers;


--AVG average
SELECT AVG(age) FROM customers;

--IFNULL returns an alternative value if an expression is NULL eg 0
SELECT IFNULL(diploma, 0) FROM customers; --it is possible no customers have academic diplomas

--COUNT, MIN, MAX, SUM
SELECT COUNT(age) FROM customers;
SELECT min(age) FROM customers;
SELECT max(age) FROM customers;
SELECT SUM(age) FROM customers;

--Only show age range for those greated than 20 if there are 2 or more identical age groups
--So a single 31 year old person won't show however if there are 2 31 year old persons then the age of
--31 will show with a COUNT(age) of 2
SELECT age, COUNT(age)
FROM customers
WHERE age >20
GROUP BY age;
HAVING COUNT(age)>=2;