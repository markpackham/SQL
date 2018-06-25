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
--avoid NATURAL JOIN & use INNER JOIN, code is far easier to maintain since NATURAL JOIN breaks easily with colum name changes

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

--Return the unique connection ID for the current connection:
SELECT CONNECTION_ID();

--Find database version
SELECT VERSION();

--GREATEST & LEAST returns the greatest/least value in a list of expressions
SELECT GREATEST(3, 12, 34, 8, 25); --34
SELECT LEAST(3, 12, 34, 8, 25); --3

--LOCATE, find position of value targeted
SELECT LOCATE("a", "Mark") AS customers; --returns 2

--SUBSTR (substring which is identical to SUBSTRING & MID)
SELECT SUBSTR("abcdefghi", 4, 2) AS aSubstring; -- gives ef

--STRCMP compares string lengths, -1 means first string longer, 0 means identical length & 1 means 2nd string longer
SELECT STRCMP("longerString", "shortString"); -- -1
SELECT STRCMP("sameLength","sameLength"); -- 0
SELECT STRCMP("shortString", "longerString"); -- 1

--IF condition
SELECT IF(100000>2, "YES", "NO"); --returns YES

--IFNULL returns an alternative value if an expression is NULL eg 0
SELECT IFNULL(diploma, 0) FROM customers; --it is possible no customers have academic diplomas

--ISNULL If expression is a NULL value, the ISNULL() function returns 1. Otherwise, it returns 0.
SELECT ISNULL("Return 0 I am not null"); --returns 0
SELECT ISNULL(""); --returns 0, strangely this is not Null
SELECT ISNULL(NULL); --returns 1

--Time functions
SELECT TIMEDIFF("14:00", "15:00"); -- -01:00:00
SELECT DATEDIFF("2020-01-01", "2019-01-01"); --difference in days 365
SELECT NOW(); -- eg 2018-06-25 14:08:01
SELECT CURRENT_DATE(); --eg 2018-06-25
SELECT CURTIME(); --eg 14:09:46
SELECT ADDDATE("2015-01-01", INTERVAL 5 DAY); --5 days are added & we get 2015-01-06