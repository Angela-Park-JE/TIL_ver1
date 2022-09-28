""" Chapter 5. SELECT, FROM, WHERE, ORDER BY, LIMIT """

-- `USE` : select schema what I'm going to use
USE world;

-- if I want to look a table which is in other scheme
SELECT *
FROM practice.box_office;

-- describe the table information(like column name, type)
desc countrylanguage;

"""
-- `WHERE` is the sentences where I write conditions about the query
-- AND = &&
-- OR = ||
-- NOT = !
"""
-- countrycode is 'KOR' and ID columns which has number 9
SELECT *
FROM city
WHERE 1=1
	AND countrycode = 'KOR' 
    AND INSTR(ID, 9);
"""
-- `LIKE` : a value which is like a specific character or value
-- `A%` : start with 'A'
-- `%A` : end with 'A'
-- `%A%` : 'A' in the middle
"""
SELECT * 
FROM city
WHERE 1=1 
	AND countrycode = 'KOR'
	AND district LIKE 'K%'
    AND district not LIKE '%K';

-- AND 2>3 is a false
SELECT *
FROM city
WHERE 2>3 -- this is null maker. :(
	AND countrycode = 'KOR';

"""
-- `IN` : compare with many values
"""
SELECT *
FROM city
WHERE NOT 2>3 -- this is !null maker. :)
	AND district IN ('seoul', 'pusan'); -- why Busan is 'Pusan'? 
-- this is same with above.
SELECT *
FROM city
WHERE NOT 2>3 
	AND (district= 'seoul' OR district= 'pusan'); 

-- <, >, <=, >=
SELECT *
FROM country
WHERE 1=1
	AND population > 100000000;
"""
-- `BETWEEN` contain '='
"""
SELECT * FROM country WHERE population BETWEEN 45000000 AND 55000000;
SELECT * FROM country WHERE population >= 45000000 AND population <= 55000000;

/*----*/

-- I WANNA SOLVE encoding problem with book's practice file
SELECT * FROM practice.box_office;

ALTER DATABASE practice CHARACTER SET utf8 COLLATE utf8_general_ci;

SELECT  movie_name,
		CONVERT(CONVERT(movie_name USING BINARY) USING latin1) AS latin1,
       CONVERT(CONVERT(movie_name USING BINARY) USING utf8) AS utf8
FROM box_office;
-- WHERE CONVERT(movie_name USING BINARY) RLIKE CONCAT('[', UNHEX('80'), '-', UNHEX('FF'), ']');

-- can't solving so I just write it ....
SELECT * FROM box_office WHERE release_date BETWEEN '2018-01-01' AND '2018-12-31';
SELECT * FROM box_office WHERE YEAR(release_date) = '2019' AND audience_num >= 5000000;
SELECT * FROM box_office WHERE YEAR(release_date) = '2019' AND (audience_num >= 5000000 OR sale_amt >= 40000000000);

/*----*/

-- p.159 quiz
SELECT * FROM box_office WHERE years = 2012 AND YEAR(release_date) = '2019';

-- `ORDER BY`
-- p.165 quiz
SELECT * FROM world.city WHERE CountryCode = 'KOR' ORDER BY name, population DESC;

"""
-- `LIMIT` : We can use end of a query, limit the result row numbers.
-- top 5 with the conditions
"""
SELECT * FROM box_office WHERE year(release_date) = '2019' AND audience_num >= 5000000 ORDER BY sale_amt DESC LIMIT 5;

-- p.169 quiz
SELECT * FROM world.city WHERE CountryCode = 'KOR' ORDER BY name, population DESC LIMIT 5;

/*----*/

-- p.172 self check
-- 1.
DESC world.countrylanguage;
SELECT * FROM world.countrylanguage WHERE percentage > 99 ORDER BY countrycode;
-- 2.
SELECT * FROM practice.box_office WHERE years = 2019 AND ranks BETWEEN 1 AND 10 ORDER BY ranks;
-- 3. 
USE practice;
SELECT * FROM box_office WHERE years = 2019 AND movie_type != '장편' ORDER BY ranks;
-- > correct answer
SELECT * FROM box_office WHERE years = 2019 AND movie_type NOT IN ('장편', '기타') ORDER BY ranks;
-- 4.
SELECT * FROM box_office WHERE years = 2019 ORDER BY screen_num DESC LIMIT 10;
