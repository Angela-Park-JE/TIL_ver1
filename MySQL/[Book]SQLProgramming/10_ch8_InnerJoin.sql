 /*- JOIN -*/
-- MUST know the 'join' columns name
-- CAN 'join' more than two tables
-- MUST state the table alias'
-- MUST write the 'join' condition (stating the 'join' columns name)


/*- INNER JOIN -*/
-- show data when the join column value is same each other
/* structure
SELECT ...
FROM table1 [AS] alias1 [INNER] JOIN table2 [AS] alias2
ON alias1.column1 = alias2.column2
AND ...
WHERE ... ; */

-- case1
USE world;
SELECT a.id, a.name, b.code, b.name country_name, a.district, a.population
FROM city a INNER JOIN country b ON a.countrycode = b.code
ORDER BY 1;

-- case2 : can use WHERE.
SELECT b.name, a.language, a.isofficial, a.percentage
FROM countrylanguage a JOIN country b ON a.countrycode = b.code 
ORDER BY 1;
SELECT b.name, a.language, a.isofficial, a.percentage
FROM countrylanguage a JOIN country b ON a.countrycode = b.code 
WHERE a.countrycode = 'KOR'
ORDER BY 1;

-- case3: the sequence isn't mattered in INNER JOIN.
SELECT a.name, b.language, b.isofficial, b.percentage
FROM country a JOIN countrylanguage b ON a.code = b.countrycode
WHERE b.countrycode = 'KOR'
ORDER BY 1;

-- case4: JOIN multiple tables
SELECT a.code, a.name, a.continent, a.region, a.population, b.language, c.name, c.district, c.population
FROM country a INNER JOIN countrylanguage b ON a.code = b.countrycode
			   INNER JOIN city c ON a.code = c.countrycode
WHERE c.countrycode = 'KOR'
ORDER BY 1;


/*- FROM WHERE join -*/
/* structure
SELECT ...
FROM table1 [AS] alias 1, 
	 table2 [AS] alias 2
WHERE alias1.column1 = alias2.column2
  AND ... ; */

-- case1
SELECT b.name coutry_name, a.language, a.isofficial, a.percentage
FROM countrylanguage a, country b
WHERE a.countrycode = b.code
  AND a.countrycode = 'KOR'
ORDER BY 1;

-- case2: same with previous case4
SELECT a.code, a.name, a.continent, a.region, a.population, b.language, c.name, c.district, c.population
FROM country a, countrylanguage b, city c
WHERE a.code = b.countrycode 
  AND b.countrycode = c.countrycode
  AND a.code = 'KOR'
ORDER BY 1;


-- p.269 quiz
SELECT a.name country_name, COUNT(b.name)
FROM country a INNER JOIN city b ON a.code = b.countrycode
GROUP BY country_name WITH ROLLUP;
-- don't need to `b.name`, because city table has a city in one row.
