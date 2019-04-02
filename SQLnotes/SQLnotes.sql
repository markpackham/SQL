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