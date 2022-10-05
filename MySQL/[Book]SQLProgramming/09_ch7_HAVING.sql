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

-- case1
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
HAVING counts>1	-- right.
ORDER BY 1 desc;


-- case2
SELECT EXTRACT(YEAR_MONTH FROM release_date) release_ym, COUNT(*) released_movies,
	   ROUND(SUM(sale_amt) / 100000000) sales_10mil
FROM box_office
WHERE 1=1
	AND ranks BETWEEN 1 AND 10
GROUP BY release_ym
HAVING sales_10mil >= 1500
ORDER BY 1;

-- case3 : show only subtotals, HAVING GROUPING()
SELECT MONTH(release_date) month, movie_type type, SUM(sale_amt) sales
FROM box_office
WHERE YEAR(release_date) - 2019
  AND QUARTER(release_date) = 1
  AND sale_amt > 10000000
GROUP BY MONTH(release_date), movie_type WITH ROLLUP
HAVING GROUPING(movie_type) = 1;



-- p.250 quiz : how many countries in each continent, + number of all countries 
SELECT continent, COUNT(name) 
FROM world.COUNTRY
GROUP BY continent WITH ROLLUP
ORDER BY 1;



/* p. 252 self check */
-- 1. max surfacearea and max population continent, and countries number in that continent
SELECT continent, SUM(surfacearea) Surf, SUM(population) Popl, COUNT(*) countries
FROM world.COUNTRY
GROUP BY continent
ORDER BY 2 DESC, 3 DESC
LIMIT 1;
-- don't need to `LIMIT`

-- 2. 2019 released movies, rank1~10 movies and others sales amount
SELECT ranks, SUM(sale_amt)
FROM practice.box_office
WHERE 1=1
  AND EXTRACT(YEAR FROM release_date) = 2019
  AND ranks BETWEEN 1 and 10
GROUP BY ranks WITH ROLLUP;
-- right answer
SELECT 
	CASE WHEN ranks BETWEEN 1 and 10 THEN 'top 10'
		 ELSE 'else' END by_ranks,
	SUM(sale_amt)
FROM practice.box_office
WHERE YEAR(release_date) = 2019
GROUP BY by_ranks ;
/*
# by_ranks, SUM(sale_amt)
'else', '1006477906583'
'top 10', '864306256605'
*/

-- 3. 2019, by 'rep_country', audience_num> 500000 with subtotal and total
SELECT rep_country, SUM(sale_amt) totalaudience
FROM practice.box_office
WHERE 1=1
  AND YEAR(release_date) = 2019
GROUP BY rep_country WITH ROLLUP
HAVING total_audience >= 500000;

-- 4. released after 2015, by year, audience> 1000000 more than 2, movie's director and audience number , by year and by director
SELECT YEAR(release_date) released_year, director, COUNT(*) counts, SUM(audience_num)
FROM practice.box_office
WHERE 1=1
  AND YEAR(release_date)>=2015
  AND audience_num>1000000
GROUP BY YEAR(release_date), director
HAVING counts>1;
-- I couldn't understand the purpose of the question...
-- results is same. answer:
SELECT YEAR(release_date) released_year, director,  SUM(audience_num), COUNT(*) counts
FROM practice.box_office
WHERE 1=1
  AND YEAR(release_date)>=2015
  AND audience_num>=1000000
GROUP BY 1, 2
HAVING counts>1
ORDER BY 1, 2;
