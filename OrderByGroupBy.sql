--GROUP BY is used to aggregate rows so you can AVG, MIN, MAX, SUM or COUNT the data
--list all the staff ranks and count the amount of staff of those ranks, show results insert in ascending order
--so the most exclusive ranks like CEO are seen first, then management and then regular staff
SELECT COUNT(name), address, rank
FROM staff
GROUP BY rank
ORDER BY COUNT(name) ASC;

SELECT AVG(age) FROM customers;
SELECT COUNT(age) FROM customers;
SELECT MAX(age) FROM customers;
SELECT MIN(age) FROM customers;
SELECT SUM(age) FROM customers;

SELECT age, COUNT(age)
FROM customers
WHERE age > 30
GROUP BY age;

--only show me non unique ages see 2 or more time that are older than 3
SELECT age, COUNT(age)
FROM customers
WHERE age > 30
GROUP BY age
HAVING COUNT(age) >= 2;