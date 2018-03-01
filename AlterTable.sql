--allow your date field to use the current time timestamp
ALTER TABLE orders MODIFY orderDate DATETIME default CURRENT_TIMESTAMP;

--add a foreign key
ALTER TABLE order ADD FOREIGN KEY personId REFERENCES persons(personID);

--drop an index focused on orderName
ALTER TABLE order DROP INDEX orderName;

--Setting up an auto increment and don't make it null
ALTER TABLE `customers`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--Make a primary key
ALTER TABLE `products`
ADD PRIMARY KEY (`id`);
