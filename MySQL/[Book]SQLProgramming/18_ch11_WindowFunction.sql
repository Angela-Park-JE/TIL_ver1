/*** Window Functions ***/
-- window : group of rows which is grouped by specific column values
-- if use `group by`, the row number decreases.
-- but if use window functions, we can maintain the row number and see the aggregated value.

/* structure : function part OVER (PARTITION BY col1, col2, ... ORDER BY ... )
*/

-- functions which can calculate wiht 'window' : Aggregating function, Window function
-- Window function MUST use `OVER` sentence
-- PARTIION BY : this sets the aggregating group, but it don't short the rows.


-- code 11-10 :
SELECT YEAR(release_date) years, SUM(sale_amt) sum_amt, AVG(sale_amt) avg_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) >= 2018
  AND ranks <= 10
GROUP BY 1 ORDER BY 1;
-- code 11-11 : using CTE, show each movies rank and the aggregated values. good but complex
WITH SUMMARY AS 
	(SELECT YEAR(release_date) years, SUM(sale_amt) sum_amt, AVG(sale_amt) avg_amt
	FROM BOX_OFFICE
	WHERE YEAR(release_date) >= 2018
	  AND ranks <= 10
	GROUP BY 1)

SELECT b.years, a.ranks, a.movie_name, a.sale_amt, b.sum_amt, b.avg_amt
FROM BOX_OFFICE a INNER JOIN SUMMARY b ON YEAR(a.release_date) = b.years
WHERE a.ranks <= 10
ORDER BY 1, 2;
-- code 11-12 : using window function
SELECT YEAR(release_date) years, ranks, movie_name, sale_amt,
	   SUM(sale_amt) OVER (PARTITION BY YEAR(release_date)) sum_amt,
       AVG(sale_amt) OVER (PARTITION BY YEAR(release_date)) avg_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) >= 2018 
  AND ranks <= 10
ORDER BY 1, 2;
