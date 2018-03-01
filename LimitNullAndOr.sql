--Only show 3 customers
SELECT * FROM customers
LIMIT 3;

--AND will only give results if both criteria are true, this will fail
SELECT firstName FROM customers
WHERE state='New York' AND state='Planet Earth';

--NOT turns the statement into a negative so will have the opposite effect to the above
SELECT firstName FROM customers
WHERE state='New York' AND NOT state='Planet Earth';

--OR will allow any results that is true to show providing 1 statement is true
--other statements can also be true or false and it will still give back results
SELECT firstName FROM customers
WHERE state='New York' OR state='Planet Earth';

--Find all people who live in the state of New York, must be in any of the following cities listed
--They must not come from Atlantis
SELECT firstName FROM customers
WHERE state='New York' AND (city='New York' OR city='Moscow' OR city='Albion')
AND NOT state = 'Atlantis';