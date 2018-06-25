--INNER JOIN is the DEFAULT, you don't need to write INNER
SELECT tableA.aID, tableB.names
FROM tableA
JOIN tableB ON tableA.aID = tableB.foreignKey

/*
Target colums of the same name
In MySQL, the NATURAL JOIN is such a join that performs the same task as an INNER or LEFT JOIN, in which the ON or USING clause refers to all columns that the tables to be joined have in common.
The MySQL NATURAL JOIN is structured in such a way that, columns with the same name of associate tables will appear once only.
 */
SELECT aID, names
FROM tableA
NATURAL JOIN tableB; --same effect as INNER JOIN above since both tables have an ID column


--BETWEEN/NOT BETWEEN
SELECT * FROM customers
WHERE age
BETWEEN 5 AND 20;

SELECT * FROM customers
WHERE age
NOT BETWEEN 5 AND 20;

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
SELECT CONCAT(firstName, '-',lastName) AS 'Name'
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


--DEFAULT
CREATE TABLE customers(
id int NOT NULL AUTO_INCREMENT,
name city varchar (255),
city varchar (255) DEFAULT 'Basingstoke'
);

ALTER TABLE customers
ALTER city DROP DEFAULT;


--VIEWS they contain no actual data they are just showing off data from another table
--This is a a temporary table that updates dynamically
CREATE VIEW my_view AS
SELECT id, name
FROM customers
WHERE id > 20;

DROP VIEW my_view;


--The EXISTS operator is used to test for the existence of any record in a subquery.
--The EXISTS operator returns true if the subquery returns one or more records.
SELECT name
FROM customers
WHERE EXISTS (SELECT age FROM customers WHERE age >50);

--The SELECT INTO statement copies data from one table into a new table.
SELECT * INTO customersBackup
FROM customers


--CHECK (constraint to prevent unwanted data entering table)
CREATE TABLE Persons (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    age int,
    CHECK (age>=17)
);

ALTER TABLE customers
ADD CHECK (age>17);

ALTER TABLE customers
ADD CONSTRAINT ageRestrict CHECK (age>17 AND country='Wales');

ALTER TABLE customers
DROP CHECK ageRestrict;

--CAST, Convert a value from one datatype to another datatype:
SELECT CAST("2018-01-30" AS DATE);
--CONVERT() would also work as an alternative to CAST()

--Data about the database, return the user name and host name for the current MySQL user:
SELECT SESSION_USER();
SELECT SYSTEM_USER();
SELECT USER();

--Return the user name and host name for the MySQL account:
SELECT CURRENT_USER();

--Find database version
SELECT VERSION();


