--GROUP BY is used to aggregate rows so you can AVG, MIN, MAX, SUM or COUNT the data
--list all the staff ranks and count the amount of staff of those ranks, show results insert in ascending order
--so the most exclusive ranks like CEO are seen first, then management and then regular staff
SELECT COUNT(name), address, rank
FROM staff
GROUP BY rank
ORDER BY COUNT(name) ASC;