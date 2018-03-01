--Copy stuff from one table into another in MySQL using Insert Into
INSERT INTO newCustomersTable
SELECT *
FROM customers;

--MySQL does not support SELECT INTO, only INSERT INTO will work

--SELECT INTO lets you copy data from 1 table into a new one
SELECT * INTO newCustomersTable
FROM customers;

--This creates a new table that has no data in it
SELECT * INTO newCustomersTable
FROM customers
WHERE 1 = 0;

--copy a table into a new database
SELECT * INTO newCustomersTable IN 'newDatabase.mdb'
FROM customers;