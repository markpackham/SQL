--narrow results, matching values in both tables
SELECT staff.id, staff.name, role.roleType FROM staff
INNER JOIN staff ON role.staffId=staff.id;

--focus on staff table, all records from the left table & matches on right
SELECT staff.id, staff.name, role.roleType FROM staff
LEFT JOIN staff ON role.staffId=staff.id;

--focus on role table, all records from the right table & matches on left
SELECT staff.id, staff.name, role.roleType FROM staff
RIGHT JOIN staff ON role.staffId=staff.id;

--increase results, terrible performance, all results where there is a match
SELECT staff.id, staff.name, role.roleType FROM staff
FULL OUTER JOIN staff ON role.staffId=staff.id;

--UNION combines the distinct result of multiple tables if they have the same datatypes
--you must also SELECT the same amount of columns in identical orders between statements
SELECT rank FROM staff UNION
SELECT rank FROM role ORDER BY rank;

--UNION ALL allows duplicate values, you may get more results that you want
SELECT rank FROM staff UNION ALL
SELECT rank FROM role ORDER BY rank;