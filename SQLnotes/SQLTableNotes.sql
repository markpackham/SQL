--Subquery
--A non-correlated subquery is a subquery that can be run independently of the outer query and
--can be used to complete a multi-step transformation.
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE elevation < 2000);

SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE faa_region = 'ASO');

--aggregate in multiple steps - like taking an average of a count
--think of aggregate data as data collected from multiple rows at a time.
/*
average total distance flown by day of week and month.
Outer query as average_distance and the Inner query as flight_distance
*/
SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_distance) AS average_distance
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               sum(distance) AS flight_distance
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;

 /*
Correlated Subquery, the subquery can not be run independently of the outer query. 
The order of operations is important in a correlated subquery:

A row is processed in the outer query.
Then, for that particular row in the outer query, the subquery is executed.

Correlated subqueries may appear elsewhere besides the WHERE clause, they can also appear in the SELECT
*/
--the id of the flights whose distance is below average for their carrier.
SELECT id
FROM flights AS f
WHERE distance < (
 SELECT AVG(distance)
 FROM flights
 WHERE carrier = f.carrier);

--view flights by origin, flight id, and sequence number. Alias the sequence number column as flight_sequence_number
--assuming flight_id increments with each additional flight
SELECT origin, id,
    (SELECT COUNT(*)
FROM flights f
WHERE f.id < flights.id
AND f.origin=flights.origin) + 1
 AS flight_sequence_number
FROM flights;

/*
- Subqueries are used to complete an SQL transformation by nesting one query within another query.
- A non-correlated subquery is a subquery that can be run independently of the outer query and can be used 
to complete a multi-step transformation.
- A correlated subquery is a subquery that cannot be run independently of the outer query. The order of operations in a 
correlated subquery is as follows:
1. A row is processed in the outer query.
2. Then, for that particular row in the outer query, the subquery is executed.
*/


--Unions allow us to utilize information from multiple tables in our queries.
/*
Each SELECT statement within the UNION must have the same number of columns with similar data types. 
The columns in each SELECT statement must be in the same order. 
By default, the UNION operator selects only distinct values.
*/
--Get complete list of brands from an old & a new table
SELECT brand FROM legacy_products
UNION 
SELECT brand FROM new_products;
/*
Allow duplicate values using the ALL keyword with UNION, with the following syntax:
*/
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

--find the average sale price over both order_items and order_items_historic tables
SELECT id, avg(a.sale_price) FROM (
  SELECT id, sale_price FROM order_items
  UNION ALL
  SELECT id, sale_price FROM order_items_historic) AS a 
  GROUP BY 1;

/*
INTERSECT is used to combine two SELECT statements, but returns rows only from the first SELECT statement 
that are identical to a row in the second SELECT statement. This means that it returns only common rows 
returned by the two SELECT statements.
*/

SELECT column_name(s) FROM table1
INTERSECT
SELECT column_name(s) FROM table2;

--Select the items in the category column that are both in the newly acquired new_products table and the legacy_products table.
SELECT category FROM new_products
INTERSECT
SELECT category  FROM legacy_products;


--EXCEPT is constructed in the same way, but returns distinct rows from the first SELECT statement 
--that aren’t output by the second SELECT statement.
--great for finding unique stuff in the first table
SELECT column_name(s) FROM table1
EXCEPT
SELECT column_name(s) FROM table2;
--select the items in the category column that are in the legacy_products table and not in the new_products table
SELECT category FROM legacy_products
EXCEPT
SELECT category FROM new_products;

/*
The UNION clause allows us to utilize information from multiple tables in our queries.
The UNION ALL clause allows us to utilize information from multiple tables in our queries, including duplicate values.
INTERSECT is used to combine two SELECT statements, but returns rows only from the first SELECT statement that 
are identical to a row in the second SELECT statement.
EXCEPT returns distinct rows from the first SELECT statement that aren’t output by the second SELECT statement
*/



--Conditional Aggregates are aggregate functions that compute a result set based on a given set of conditions.
--Count the number of rows in the flights table, representing the total number of flights contained in the table
SELECT COUNT(*) FROM flights;

--IS NULL or IS NOT NULL in the WHERE clause (= NULL does not work).
--Count the number of rows from the flights table, where arr_time is not null and the destination is ATL
SELECT COUNT(*) FROM flights WHERE arr_time IS NOT NULL AND destination = 'ATL';


--CASE WHEN (SQL's answer to If Else)
SELECT
    CASE
        WHEN elevation < 500 THEN 'Low'
        WHEN elevation BETWEEN 500 AND 1999 THEN 'Medium'
        WHEN elevation >= 2000 THEN 'High'
        ELSE 'Unknown'
    END AS elevation_tier
    , COUNT(*)
FROM airports
GROUP BY 1;

--hen the elevation is less than 250, the elevation_tier column returns ‘Low’, 
--when between 250 and 1749 it returns ‘Medium’, and when greater than or equal to 1750 it returns ‘High’.
SELECT
    CASE
        WHEN elevation < 250 THEN 'Low'
        WHEN elevation BETWEEN 250 AND 1749 THEN 'Medium'
        WHEN elevation >= 1750 THEN 'High'
        ELSE 'Unknown'
    END AS elevation_tier
    , COUNT(*)
FROM airports
GROUP BY 1;

--COUNT(CASE WHEN )
--look at an entire result set, but want to implement conditions on certain aggregates
--count the number of low elevation airports by state where low elevation is defined as less than 1000 ft
SELECT state, 
    COUNT(CASE WHEN elevation < 1000 THEN 1 ELSE NULL END) as count_low_elevation_aiports 
FROM airports 
GROUP BY state;

--SUM(CASE WHEN )
/*
sum the total flight distance and compare that to the sum of flight distance from a 
particular airline (in this case, United Airlines) by origin airport, we could run the following query:
*/
SELECT origin, sum(distance) as total_flight_distance, sum(CASE WHEN carrier = 'UA' THEN distance ELSE 0 END) as total_united_flight_distance 
FROM flights 
GROUP BY origin;

--find both the total flight distance and the flight distance by origin for Delta (carrier = 'DL')
SELECT origin, sum(distance) as total_flight_distance, sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END) as total_delta_flight_distance 
FROM flights 
GROUP BY origin;


--Combining aggregates
--find out the percent of flight distance that is from United by origin airport.
SELECT     origin, 
    100.0*(sum(CASE WHEN carrier = 'UN' THEN distance ELSE 0 END)/sum(distance)) as percentage_flight_distance_from_united FROM flights 
GROUP BY origin;

-- find the percentage of flights from Delta by origin (carrier = 'DL')
SELECT     origin, 
    100.0*(sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END)/sum(distance)) as percentage_flight_distance_from_delta FROM flights 
GROUP BY origin;

--Find the percentage of high elevation airports (elevation >= 2000) by state
SELECT state, 100.0 * sum(CASE WHEN elevation >= 2000 THEN 1 ELSE 0 END) / count(*)  
as percentage_high_elevation_airports FROM airports GROUP BY state;

/*
Conditional Aggregates are aggregate functions the compute a result set based on a given set of conditions.
NULL can be used to denote an empty field value
CASE statements allow for custom classification of data
CASE statements can be used inside aggregates (like SUM() and COUNT()) to provide filtered measures
*/


--date, number, and string functions are highly database dependent eg act weird depending on which database you use
--typical dataetime or timestamp is YYYY-MM-DD hh:mm:ss

--select the date and time of all deliveries in the baked_goods table using the column delivery_time
SELECT DATETIME(delivery_time)
FROM baked_goods;
--select just Date or just Time
SELECT DATE(manufacture_time), count(*) as count_baked_goods
FROM baked_goods
GROUP BY DATE(manufacture_time);

SELECT TIME(manufacture_time), count(*) as count_baked_goods
FROM baked_goods
GROUP BY TIME(manufacture_time);

--Find the number of baked goods by date of delivery
SELECT DATE(delivery_time), count(*) as count_baked_goods
FROM baked_goods
GROUP BY DATE(delivery_time);

--Adding time in SQLite
DATETIME(time1, '+3 hours', '40 minutes', '2 days');
--Would return a time 3 hours, 20 minutes, and 2 days after time1

--each dessert in our baked_goods table is inspected 2 hours, 30 minutes, and 1 day after the manufacture time. 
SELECT DATETIME(manufacture_time, '+2 hours', '30 minutes', '1 day') as inspection_time
FROM baked_goods;

--Each of the baked goods is packaged by Baker’s Market exactly five hours, twenty minutes, and two days after the delivery (designated by delivery_time)
SELECT DATETIME(delivery_time, '+5 hours', '20 minutes', '2 days') as package_time
FROM baked_goods;



--NUMBERS
/*
common SQLite mathematical functions are included below that take numeric data types as inputs:

SELECT (number1 + number2);: Returns the sum of two numbers. Similar, SQL can be used for subtraction, multiplication, and division.
SELECT CAST(number1 AS REAL) / number3;: Returns the result as a real number by casting one of the values as a real number, rather than an integer.
SELECT ROUND(number, precision);: Returns the numeric value rounded off to the next value specified.
*/

--make sure that each ingredient cost is rounded to four decimal places rather than two, to account for currency fluctuations.
SELECT ROUND(ingredients_cost, 4) as rounded_cost
FROM baked_goods;

--Find the bakery’s distance from the market rounded to two decimal places
SELECT ROUND(distance, 2) as distance_from_market
FROM bakeries;


--MAX & MIN
--use the MAX function to determine the overall greatest value of cost for each item
SELECT id, MAX(ingredients_cost, packaging_cost)
FROM baked_goods;
--Find Max cook & cool down time
SELECT id, MAX(cook_time, cool_down_time)
FROM baked_goods;
--Find Minx cook & cool down time
SELECT id, MIN(cook_time, cool_down_time)
FROM baked_goods;



--Strings
--A common use case for string manipulation in SQL is concatenation of strings. In SQLite, this is written as
SELECT string1 || ' ' || string2;
--the bakeries table contains both city and state columns. In order to create a route for these columns, 
SELECT city || ' ' || state as location
FROM bakeries;
--Combine the first_name and last_name columns from the bakeries table as the full_name
SELECT first_name || ' ' || last_name as full_name
FROM bakeries;


--Replace
REPLACE(string,from_string,to_string)

SELECT id, REPLACE(ingredients,'_',' ') as item_ingredients
from baked_goods;

--enriched_flour appears in the ingredients list, we’d like to replace it with just flour
SELECT REPLACE(ingredients,'enriched_',' ') as item_ingredients
FROM baked_goods;

/*
Date Functions:

DATETIME; Returns the date and time of the column specified. This can be modified to return only the date or only the time.
DATETIME(time1, +X hours, Y minutes, Z days): Increments the specificed column by a given number of hours, minutes, or days.
Numeric Functions:

(number1 + number2);: Returns the sum of two numbers, or other mathematical operations, accordingly.
CAST(number1 AS REAL) / number2;: Returns the result as a real number by casting one of numeric inputs as a real number
ROUND(number, precision);: Returns the numeric value rounded off to the next value specified.
String Functions:

'string1' || ' ' || 'string2';: Concatenates string1 and string 2, with a space between.
REPLACE(string,from_string,to_string): Returns the string with all occurrences of the string from_string replaced by the string to_string.
*/