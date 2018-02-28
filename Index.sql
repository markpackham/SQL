--create an index for orderName called myOrderNameIndex
--indexes speed up search queries, be sure to DROP the ones you aren't using to save space
CREATE INDEX myOrderNameIndex ON orders(orderName);

--unique results in this index only
CREATE UNIQUE INDEX myOrderNameIndex ON orders(orderName);

--get rid of the index
ALTER TABLE orders
DROP INDEX myOrderNameIndex;