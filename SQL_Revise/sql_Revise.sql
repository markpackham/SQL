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

--- Replace null columns with dashes in database selects
SELECT IFNULL(aFieldThatMightBeNull, '-')

--ISNULL If expression is a NULL value, the ISNULL() function returns 1. Otherwise, it returns 0.
SELECT ISNULL("Return 0 I am not null"); --returns 0
SELECT ISNULL(""); --returns 0, strangely this is not Null
SELECT ISNULL(NULL); --returns 1

--Time functions
SELECT ADDTIME("2015-01-01 01:01:01", "1"); --2015-01-01 01:01:02
SELECT SUBTIME("2015-01-01 01:01:01", "1"); --2015-01-01 01:01:00
SELECT TIMEDIFF("14:00", "15:00"); -- -01:00:00
SELECT DATEDIFF("2020-01-01", "2019-01-01"); --difference in days 365
SELECT NOW(); -- eg 2018-06-25 14:08:01
SELECT CURRENT_DATE(); --eg 2018-06-25
SELECT CURTIME(); --eg 14:09:46
SELECT ADDDATE("2015-01-01", INTERVAL 5 DAY); --5 days are added & we get 2015-01-06
--use SUBDATE to subtract

--Output to file
SELECT *
FROM customers
INTO OUTFILE 'C:\\myFolder\\customers.csv'
FIELDS ENCLOSED BY '"' TERMINATED BY ',' ESCAPE BY '\\' --factor in NULL values
LINES TERMINATED BY '\r\n'; --carriage return (jump back to left like typewriter) & line break

--Import from file, (one above)
LOAD DATA
INFILE 'C:\\myFolder\\customers.csv'
INTO TABLE myDatabase.customers
FIELDS ENCLOSED BY '"' TERMINATED BY ',' ESCAPE BY '\\' --factor in NULL values
LINES TERMINATED BY '\r\n';

--Create new table copying data from existing one & limiting it
CREATE TABLE no_credit
LIKE myDatabase.customers;

INSERT no_credit
SELECT *
FROM customers
WHERE creditLimit = 0;

--Variables
SET @start = 9, @finish = 17; -- Both SET or SELECT work as do = or :=
SELECT @start := 9, @finish := 17;
SELECT * FROM work WHERE work_hours BETWEEN @start AND @finish;

--Disable safe update mode (a mode than can force you to use WHERE clauses before deleting stuff)
SET SQL_SAFE_UPDATES=0;
--Renable safe update mode
SET SQL_SAFE_UPDATES=1;

--FORMAT, used for rounding
SELECT FORMAT(199.9999, 2); --200.00

--RAND, random number
SELECT RAND(14); --generate a random number & use the number 14 as a seed to make it more random

--Find out which tables specific columns live in
SELECT DISTINCT table_name, column_name FROM information_schema.columns WHERE column_name IN ('the_field_something_id') AND table_schema ='the_database'; 

--Correct paths in database when changing folder locations between Dev and Live
UPDATE volume SET system_path = REPLACE (system_path, 'oldPathName', 'newPathName');

--Smart insertion means using wildcards so Dev & Live paths no longer an issue
INSERT INTO tag (tag_id, some_predictable_number, file_id) SELECT Null,some_predictable_number,file_id FROM file WHERE full_pathname LIKE '/someFolderPath/aChildFolder/%';

--Concat users with multiple roles & make sure to use  a GROUP BY
GROUP_CONCAT(DISTINCT role)
GROUP BY user_id


--An insertion query involving 3 tables
INSERT INTO table3 (tag_id, theNumber10)
SELECT tag_id,10 FROM table2 WHERE file_id IN
(SELECT file_id FROM table1 WHERE full_pathname LIKE '/something/%/somethinFolder/%');


--Describe the meta info on a table or field, DESC is the short version
DESCRIBE SELECT email FROM sfsuser;
+----+-------------+---------+------------+-------+---------------+-------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type  | possible_keys | key   | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+-------+---------------+-------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | sfsuser | NULL       | index | NULL          | email | 291     | NULL | 8680 |   100.00 | Using index |
+----+-------------+---------+------------+-------+---------------+-------+---------+------+------+----------+-------------+

DESC role;
+-------------+------------------+------+-----+---------+----------------+
| Field       | Type             | Null | Key | Default | Extra          |
+-------------+------------------+------+-----+---------+----------------+
| role_id     | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name        | varchar(75)      | YES  | UNI | NULL    |                |
| description | varchar(255)     | YES  |     | NULL    |                |
+-------------+------------------+------+-----+---------+----------------+


--Remove table lines from mysql's console, handy when doing selections to copy and paste data
mysql -s -n -u root myDatabase


--Disable Mysql "incompatible with sql_mode=only_full_group_by"
SET sql_mode = '';


--CONCAT
SELECT CONCAT("ab", "cd", "ef", "g") AS alphaBet;
--Outputs "abcdefg"


--GROUP_CONCAT (handy for adding "," to SELECT stuff in in one query for use in a very long IN() statement via another
SELECT GROUP_CONCAT(someId) FROM someTable WHERE someThing IS NULL;
/*You might get output like this 257502,257512,343882,348152,368371,368431,515981,547481 which you can copy & paste into a very long IN() statement later */

--Boost GROUP_CONCAT limit so you don't miss out on stuff
SET SESSION group_concat_max_len = 100000;

