--create a database
CREATE DATABASE a_new_database;

--Risky remove database
DROP DATABASE a_new_database;

--CREATE a table with columns
CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
)

--delete record from a made up table
DELETE FROM a_non_existent_table
WHERE id = 1;

--wipe out the content in a table but keep the table
DELETE FROM a_non_existent_table;
--this is the same, very handy for cache tables
TRUNCATE TABLE a_non_existent_table;

--DROP table destorys the table
DROP TABLE a_non_existent_table;

--DROP VIEW
DROP VIEW a_non_existent_view;