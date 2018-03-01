--Use IN to save you from having to write OR loads of times
--Show every customer that lives in New York
SELECT * FROM customers
WHERE city IN ('New York');

--Show every customer that doesn't live in New York
SELECT * FROM customers
WHERE city NOT IN ('New York');

--LIKE is used to focus on a type of pattern, use % as a wildcard for many characters and _ as a wildcard for only 1
SELECT * FROM customers
WHERE city LIKE ('Ne_ York');

SELECT * FROM customers
WHERE city LIKE ('% York');