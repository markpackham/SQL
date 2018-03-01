--ANY and ALL work with WHERE and HAVING clauses
--ANY will be true if any of the subqueries are true

SELECT firstName
FROM customers
WHERE email = ANY (SELECT email FROM customers WHERE email LIKE '%gmail.com');

--ALL will be true if all subqueries are true

SELECT firstName
FROM customers
WHERE email = ALL (SELECT email FROM customers WHERE email LIKE '%.com');