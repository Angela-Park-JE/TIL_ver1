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

USE world;

-- DISTINCT : unique values
SELECT DISTINCT continent
FROM COUNTRY;


-- = get unique values with GROUP BY (1)
SELECT continent
FROM COUNTRY
GROUP BY continent;

-- get unique values with GROUP BY (2)
SELECT continent, region
FROM COUNTRY
GROUP BY continent, region
ORDER BY 1, 2;

SELECT continent, region
FROM COUNTRY
GROUP BY 1, 2
ORDER BY 1, 2;

-- two first character, in Korean district 'do'.
SELECT SUBSTRING(district, 1, 2) DO
FROM city
WHERE countrycode = 'KOR'
GROUP BY SUBSTRING(district, 1, 2)
ORDER BY 1;

SELECT SUBSTRING(district, 1, 2) DO
FROM city
WHERE countrycode = 'KOR'
GROUP BY DO
ORDER BY 1;
/*-
'Ch'
'In'
'Ka'
'Kw'
'Ky'
'Pu'
'Se'
'Ta'
-*/

-- columns in SELECT and GROUP BY must be same.
-- in my Mysql, it dosen't work. 
SELECT continent
FROM COUNTRY
GROUP BY region
ORDER BY 1;
