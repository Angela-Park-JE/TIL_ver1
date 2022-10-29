/**- Aggregation Query -**/

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


/*- aggregating functions -*/

-- COUNT([DISTINCT] expr) : total rows number
-- COUNT(*) = COUNT(column) = COUNT(anyotherthings), 
-- * is can b used with only COUNT.
-- But if use DISTINCT, return the unique value numbers in expr columns
SELECT COUNT(*), COUNT(continent) 						-- : 239, 239
FROM COUNTRY;

SELECT COUNT(*), COUNT(2)								-- : 46, 46
FROM COUNTRY
WHERE continent = 'EUROPE';

SELECT COUNT(DISTINCT continent)						-- : 7
FROM COUNTRY;

-- MAX([DISTINCT] expr) : maximum value in expr
-- MIN([DISTINCT] expr) : minimum value in expr
-- AVG([DISTINCT] expr) : mean of expr
-- MAX and MIN can be used with date type or characters.
SELECT MAX(population), MIN(population), ROUND(AVG(population), 2)			-- : 146934000, 1000, 15871186.96
FROM COUNTRY
WHERE continent = 'Europe';

-- SUM([DISTINCT] expr) : sum of expr
-- VARIANCE(expr), VAR_POP(expr) : variance
-- STD(expr), STDDEV(expr), STDDEV_POP(expr) : standard deviation
SELECT SUM(population), VARIANCE(population), TRUNCATE(STD(population), 2)	-- : 730074600, 754623313635047.4, 27470407.96
FROM COUNTRY
WHERE continent = 'EUROPE';



/* USAGE */

USE practice;

-- release movies summary by years
SELECT year(release_date) released_year, COUNT(*)
FROM BOX_OFFICE
GROUP BY year(release_date)
ORDER BY 1 DESC;

-- 2019 released movies: max, min sales by movie type and total sale_amt.
SELECT movie_type, MAX(sale_amt), MIN(sale_amt), SUM(sale_amt)
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
GROUP BY movie_type
ORDER BY 1;
/*
NULL,'4417000','100000','4517000'
'¿È´Ï¹ö½º','41537030','901000','92895690'
'´ÜÆí','18270150','38000','29395700'
'ÀåÆí','139651845516','1000','1870657354798'
*/

-- sale_amt >= 100000000 , 2019 released movie count, sales: by quarter, by distributor 
SELECT QUARTER(release_date) quarter, distributor, COUNT(DISTINCT movie_name) movies, SUM(sale_amt) total
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019 AND sale_amt >= 100000000
GROUP BY quarter, distributor
ORDER BY 1, 2;
-- answer : use not null but result rows number is same
SELECT QUARTER(release_date) 분기, distributor 배급사, COUNT(*) 영화편수, ROUND(SUM(sale_amt)/ 100000000) 매출_억원
FROM BOX_OFFICE
WHERE 1=1
  AND EXTRACT(YEAR FROM release_date) = 2019
  AND distributor IS NOT NULL
  AND sale_amt >= 100000000
GROUP BY QUARTER(release_date), distributor
ORDER BY 1, 2, 3;



-- p.240 quiz : count the cities by country code in CITY table
SELECT CountryCode, count(DISTINCT Name)
FROM WORLD.CITY
GROUP BY CountryCode;
-- in CITY table, one row means one city so it can be just `COUNT(*)`.
