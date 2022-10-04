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


/*- WITH ROLLUP -*/
-- total and subtotal
-- normal query
SELECT movie_type, SUM(sale_amt)
FROM box_office
WHERE YEAR(release_date) = 2019 AND sale_amt > 10000000
GROUP BY movie_type
ORDER BY 1 DESC;
/*
'ÀåÆí','1870000814478'
'´ÜÆí','29142700'
'¿È´Ï¹ö½º','75428940'
*/

-- with rollup make total and subtotal with null
-- total sales by movie_type and subtotal
SELECT movie_type, SUM(sale_amt)
FROM box_office
WHERE YEAR(release_date) = 2019 AND sale_amt > 10000000
GROUP BY movie_type WITH ROLLUP;
/*
'¿È´Ï¹ö½º','75428940'
'´ÜÆí','29142700'
'ÀåÆí','1870000814478'
NULL,'1870105386118'
*/

-- total and subtotals sales by month, movie_type in conditions
SELECT MONTH(release_date), movie_type, SUM(sale_amt)
FROM box_office
WHERE YEAR(release_date) = 2019 AND sale_amt > 10000000 AND QUARTER(release_date) = 1
GROUP BY MONTH(release_date), movie_type WITH ROLLUP;
/*
'1','´ÜÆí','18270150'
'1','ÀåÆí','249008693659'
'1',NULL,'249026963809'
'2','ÀåÆí','86975994258'
'2',NULL,'86975994258'
'3','´ÜÆí','10872550'
'3','ÀåÆí','112668378148'
'3',NULL,'112679250698'
NULL,NULL,'448682208765'
*/

-- GROUPING(grouped_column_name) : make a dummy data by whether grouped total or not
-- not grouping()
SELECT movie_type, SUM(sale_amt)
FROM box_office
WHERE YEAR(release_date) = 2019
GROUP BY movie_type WITH ROLLUP;
/*
NULL,'4517000'
'¿È´Ï¹ö½º','92895690'
'´ÜÆí','29395700'
'ÀåÆí','1870657354798'
NULL,'1870784163188'
*/
-- this make a NULL with the rows which not have a data with grouped column. It seems uncomfortable.
-- we use grouping(), it mark with '1' when it is aggregated data with GROUP BY.
SELECT movie_type, SUM(sale_amt), GROUPING(movie_type)
FROM box_office
WHERE YEAR(release_date) = 2019
GROUP BY movie_type WITH ROLLUP;
/*
NULL,'4517000','0'
'¿È´Ï¹ö½º','92895690','0'
'´ÜÆí','29395700','0'
'ÀåÆí','1870657354798','0'
NULL,'1870784163188','1'
*/
-- And it can be expressed like this
SELECT IF(GROUPING(movie_type) = 1, 'subtotal', movie_type) movie_type, SUM(sale_amt)
FROM box_office
WHERE YEAR(release_date) = 2019
GROUP BY movie_type WITH ROLLUP;
/*
NULL,'4517000'
'¿È´Ï¹ö½º','92895690'
'´ÜÆí','29395700'
'ÀåÆí','1870657354798'
'subtotal','1870784163188'
*/



/*- HAVING -*/

