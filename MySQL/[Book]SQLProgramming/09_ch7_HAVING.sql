/*- Aggregation Query -*/

/*-- GROUP BY 
SELECT *
FROM tablename
WHERE conditions
GROUP BY column[or regex, or number in select columns]1, column[regex, number]2 ...
ORDER BY ...
LIMIT n;

-- Must state the columns or regex in GROUP BY
-- If we give alias to columns in SELECT, we can use the alias in GROUP BY
--*/


/*- HAVING -*/
-- make a filter with condition using aggregated results.
-- before use having : 
SELECT EXTRACT(YEAR_MONTH FROM release_date) released, COUNT(*) counts
FROM box_office
WHERE ranks BETWEEN 1 AND 10
GROUP BY EXTRACT(YEAR_MONTH FROM release_date)
ORDER BY 1 desc;
-- if we want to see the counts more than 1?
SELECT EXTRACT(YEAR_MONTH FROM release_date) released, COUNT(*) counts
FROM box_office
WHERE ranks BETWEEN 1 AND 10 
	AND counts>1 	-- this query is wrong
GROUP BY EXTRACT(YEAR_MONTH FROM release_date)
ORDER BY 1 desc;  
-- so use HAVING like this
SELECT EXTRACT(YEAR_MONTH FROM release_date) released, COUNT(*) counts
FROM box_office
WHERE ranks BETWEEN 1 AND 10
GROUP BY EXTRACT(YEAR_MONTH FROM release_date)
HAVING counts >1	-- right.
ORDER BY 1 desc;
