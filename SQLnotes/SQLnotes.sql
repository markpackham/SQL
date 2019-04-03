INTEGER, a positive or negative whole number
TEXT, a text string
DATE, the date formatted as YYYY-MM-DD for the year, month, and day
REAL, a decimal value 

A relational database is a database that organizes information into one or more tables.
A table is a collection of data organized into rows and columns.
A statement is a string of characters that the database recognizes as a valid command.

CREATE TABLE creates a new table.
INSERT INTO adds a new row to a table.
SELECT queries data from a table.
ALTER TABLE changes an existing table.
UPDATE edits a row in a table.
DELETE FROM deletes rows from a table.
Constraints add information about how a column can be used.


LIKE is a special operator used with the WHERE clause to search for a specific pattern in a column.
name LIKE 'Se_en' is a condition evaluating the name column for a specific pattern.
Se_en represents a pattern with a wildcard character.
The _ means you can substitute any individual character here without breaking the pattern. The names Seven and Se7en both match this pattern.


% is a wildcard character that matches zero or more missing letters in the pattern. For example:
A% matches all movies with names that begin with letter ‘A’
%a matches all movies that end with ‘a’
We can also use % both before and after a pattern:

CASE (If Else statement in SQL)
A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL’s way of handling if-then logic.
Suppose we want to condense the ratings in movies to three levels:
If the rating is above 8, then it is Fantastic.
If the rating is above 6, then it is Poorly Received.
Else, Avoid at All Costs.
SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END
FROM movies;


SELECT name,
 CASE
  WHEN genre = 'romance' THEN 'Chill'
  WHEN genre = 'comedy' THEN 'Chill'
  ELSE 'Intense'
 END AS 'Mood'
FROM movies;



SELECT is the clause we use every time we want to query information from a database.
AS renames a column or table.
DISTINCT return unique values.
WHERE is a popular command that lets you filter the results of the query based on conditions that you specify.
LIKE and BETWEEN are special operators.
AND and OR combines multiple conditions.
ORDER BY sorts the result.
LIMIT specifies the maximum number of rows that the query will return.
CASE creates different outputs.


Using Rounding on an average by 2 decimal places
SELECT ROUND(AVG(price), 2)
FROM fake_apps;


GROUP BY example 
SELECT category, 
   price,
   AVG(downloads)
FROM fake_apps
GROUP BY category, price;


HAVING instead of WHERE
we want to see how many movies of different genres were produced each year, but we only care about years and genres with at least 10 movies.
We can’t use WHERE here because we don’t want to filter the rows; we want to filter groups.
This is where HAVING comes in.
HAVING is very similar to WHERE. In fact, all types of WHERE clauses you learned about thus far can be used with HAVING.
HAVING statement always comes after GROUP BY, but before ORDER BY and LIMIT.
We can use the following for the problem:
SELECT year,
   genre,
   COUNT(name)
FROM movies
GROUP BY 1, 2
HAVING COUNT(name) > 10;

SELECT price, 
   ROUND(AVG(downloads)),
   COUNT(*)
FROM fake_apps
GROUP BY price
HAVING COUNT(*) > 10;


COUNT(): count the number of rows
SUM(): the sum of the values in a column
MAX()/MIN(): the largest/smallest value
AVG(): the average of the values in a column
ROUND(): round the values in the column
Aggregate functions combine multiple rows together to form a single value of more meaningful information.
GROUP BY is a clause used with aggregate functions to combine data from one or more columns.
HAVING limit the results of a query based on an aggregate property.


--Inner Join
SELECT COUNT(*)
FROM newspaper;

SELECT COUNT(*)
FROM online;

SELECT COUNT(*)
FROM newspaper
JOIN online
	ON newspaper.id = online.id;


--Left Join
SELECT *
FROM newspaper
LEFT JOIN online
	ON newspaper.id = online.id;
  
SELECT *
FROM newspaper
LEFT JOIN online
	ON newspaper.id = online.id
WHERE online.id IS NULL;

--Foreign Key example
Primary keys have a few requirements:
None of the values can be NULL.
Each value must be unique (i.e., you can’t have two customers with the same customer_id in the customers table).
A table can not have more than one primary key column.
---
SELECT *
FROM classes
JOIN students
	ON classes.id = students.class_id;


--Cross Join---
--cross joins don’t require an ON statement. You’re not really joining on any columns!
A more common usage of CROSS JOIN is when we need to compare each row of a table to a list of values.

Let’s return to our newspaper subscriptions. This table contains two columns that we haven’t discussed yet:

start_month: the first month where the customer subscribed to the print newspaper (i.e., 2 for February)
end_month: the final month where the customer subscribed to the print newspaper
Suppose we wanted to know how many users were subscribed during each month of the year. For each month (1, 2, 3) 
we would need to know if a user was subscribed. Follow the steps below to see how 
we can use a CROSS JOIN to solve this problem.
---
Never found much use for them.
CROSS JOIN produces a result set which is the number of rows in the first table multiplied by the number of rows in 
the second table if no WHERE clause is used along with CROSS JOIN.This kind of result is called as Cartesian Product.
If WHERE clause is used with CROSS JOIN, it functions like an INNER JOIN
---
---
SELECT COUNT(*)
FROM newspaper
WHERE start_month <= 3 
  AND end_month >= 3;
  
SELECT *
FROM newspaper
CROSS JOIN months;

SELECT *
FROM newspaper
CROSS JOIN months
WHERE start_month <= month 
  AND end_month >= month;

SELECT month, 
  COUNT(*)
FROM newspaper
CROSS JOIN months
WHERE start_month <= month 
  AND end_month >= month
GROUP BY month;
---

---UNION
Sometimes we just want to stack one dataset on top of the other. 
Well, the UNION operator allows us to do that.
---
SELECT *
FROM newspaper
UNION
SELECT *
FROM online;

---WITH (never used this before)
The WITH statement allows us to perform a separate query (such as aggregating customer’s subscriptions)
previous_results is the alias that we will use to reference any columns from the query inside of the WITH clause
We can then go on to do whatever we want with this temporary table (such as join the temporary table with another table)
Essentially, we are putting a whole first query inside the parentheses () and giving it a name. After that, 
we can use this name as if it’s a table and write a new query using the first query.

The with clause is an optional prefix for select
WITH query_name (column_name1, ...) AS
     (SELECT ...)
     
SELECT ...
----
WITH previous_query AS (
SELECT customer_id,
       COUNT(subscription_id) as subscriptions
FROM orders
GROUP BY customer_id)

SELECT customers.customer_name,
previous_query.subscriptions
FROM previous_query
JOIN customers
	ON customers.customer_id = previous_query.customer_id;
-----

JOIN aka INNER JOIN will combine rows from different tables if the join condition is true.
INNER JOIN is identical to JOIN can be a bit clearer to read, especially if the query has other join types 
(i.e. LEFT or RIGHT or CROSS) included in it.

LEFT JOIN will return every row in the left table, and if the join condition is not met, 
NULL values are used to fill in the columns from the right table.

Primary key is a column that serves a unique identifier for the rows in the table.
Foreign key is a column that contains the primary key to another table.
CROSS JOIN lets us combine all rows of one table with all rows of another table.
UNION stacks one dataset on top of another.
WITH allows us to define one or more temporary tables that can be used in the final query.