--allow your date field to use the current time timestamp
ALTER TABLE orders MODIFY orderDate DATETIME default CURRENT_TIMESTAMP;

--add a foreign key
ALTER TABLE order ADD FOREIGN KEY personId REFERENCES persons(personID);