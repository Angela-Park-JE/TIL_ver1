/*- JOIN -*/
-- MUST know the 'join' columns name
-- CAN 'join' more than two tables
-- MUST state the table alias'
-- MUST write the 'join' condition (stating the 'join' columns name)


/*- OUTER JOIN -*/
-- show 'all' data in a table even if the join column value is not same each other

-- LEFT JOIN
/* structure
SELECT ...
FROM table1 [AS] alias1 LEFT [OUTER] JOIN table2 [AS] alias2
ON alias1.column1 = alias2.column2
AND ...
WHERE ... ; */

-- case1: numbers of city in each continent
USE world;
SELECT a.continent, COUNT(*)
FROM country a JOIN city b ON a.code = b.countrycode
GROUP BY 1;
/*
# continent, COUNT(*)
'North America', '581'
'Asia', '1766'
'Africa', '366'
'Europe', '841'
'South America', '470'
'Oceania', '55'
*/
SELECT a.continent, COUNT(*)
FROM country a LEFT JOIN city b ON a.code = b.countrycode
GROUP BY 1;
/*
# continent, COUNT(*)
'North America', '581'
'Asia', '1766'
'Africa', '367'
'Europe', '841'
'South America', '470'
'Oceania', '56'
'Antarctica', '5' --> this means country table's row
*/
-- more specific
SELECT a.continent, COUNT(*) all_, COUNT(b.name) cities
FROM country a LEFT JOIN city b ON a.code = b.countrycode
GROUP BY 1;
/*
# continent, all_, cities
'North America', '581', '581'
'Asia', '1766', '1766'
'Africa', '367', '366'
'Europe', '841', '841'
'South America', '470', '470'
'Oceania', '56', '55'
'Antarctica', '5', '0'
*/



-- RIGHT JOIN
/* structure
SELECT ...
FROM table1 [AS] alias1 RIGHT [OUTER] JOIN table2 [AS] alias2
ON alias1.column1 = alias2.column2
AND ...
WHERE ... ; */

-- case1: previous case1 same structure but different
SELECT a.continent, COUNT(*) all_, COUNT(b.name) cities
FROM country a RIGHT JOIN city b ON a.code = b.countrycode
GROUP BY 1;
/*
# continent, all_, cities
'Asia', '1766', '1766'
'Europe', '841', '841'
'North America', '581', '581'
'Africa', '366', '366'
'Oceania', '55', '55'
'South America', '470', '470'
*/
-- if want to see the 'Antarctica' (not in city table)
SELECT b.continent, COUNT(*) all_, COUNT(a.name) cities
FROM city a RIGHT OUTER JOIN country b ON a.countrycode = b.code
GROUP BY 1;
/*
# continent, all_, cities
'North America', '581', '581'
'Asia', '1766', '1766'
'Africa', '367', '366'
'Europe', '841', '841'
'South America', '470', '470'
'Oceania', '56', '55'
'Antarctica', '5', '0'
*/


-- p.278 quiz
SELECT c.name
FROM countrylanguage l RIGHT JOIN country c ON l.countrycode = c.code
WHERE 1=1
  AND l.language is null 
  AND c.continent = 'Africa'
GROUP BY c.name;				-- : 'British Indian Ocean Territory'
-- results are same
SELECT c.name, COUNT(l.language)
FROM country c LEFT JOIN countrylanguage l ON l.countrycode = c.code
WHERE 1=1
  AND c.continent = 'Africa'
GROUP BY c.name
HAVING COUNT(l.language) = 0;	-- : 'British Indian Ocean Territory','0'
