/**- SUBQUERY -**/
-- a query inside of a query
-- independent SELECT sentence, and covered '( )'
-- using for main query


/*- WHERE subquery -*/
-- subquery be a condtion, works like a filter
-- if you use the subquery for simple comparing(>, < ...), the result of subquery must be a single row.
-- if the result of subquery return multiple values(multiple rows), compare using ANY, SOME, ALL operators

-- ANY, SOME : if the main query's compared value matched with any values in condition subquery's result, it will be considered a true.
-- ALL : if the main query's compared value matched with all values in condition subquery's result, it will be considered a true.

-- code 9-18 : single rows
USE practice;
SELECT ranks, movie_name, sale_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND sale_amt >= (SELECT MAX(sale_amt) FROM BOX_OFFICE 
					WHERE YEAR(release_date) = 2018);

-- code 9-20 : ANY, SOME
SELECT ranks, movie_name, sale_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND sale_amt >= ANY (SELECT sale_amt FROM BOX_OFFICE 
						WHERE YEAR(release_date) = 2018 AND ranks BETWEEN 1 AND 3);
SELECT ranks, movie_name, sale_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND sale_amt >= SOME (SELECT sale_amt FROM BOX_OFFICE 
						WHERE YEAR(release_date) = 2018 AND ranks BETWEEN 1 AND 3);
/*
'1','±ØÇÑÁ÷¾÷','139651845516'
'2','¾îº¥Á®½º: ¿£µå°ÔÀÓ','122182694160'
'3','°Ü¿ï¿Õ±¹ 2','111596248720'
'4','¾Ë¶óµò','106955138359'
'5','±â»ýÃæ','85883963645'
*/

-- code 9-21 : ALL
SELECT ranks, movie_name, sale_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND sale_amt >= ALL (SELECT sale_amt FROM BOX_OFFICE 
						WHERE YEAR(release_date) = 2018 AND ranks BETWEEN 1 AND 3);
/*
'1','±ØÇÑÁ÷¾÷','139651845516'
'2','¾îº¥Á®½º: ¿£µå°ÔÀÓ','122182694160'
'3','°Ü¿ï¿Õ±¹ 2','111596248720'
'4','¾Ë¶óµò','106955138359'
*/


/* IN and EXISTS */

-- IN : works like a 'OR', comparing with a list. 
-- if use with subquery, a value will be true when the value is matched with any subquery's result values.
-- NOT IN : be not in the result of subquery

-- code 9-22 : screened 2019 movies among screened in 2018
SELECT ranks, movie_name, director
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND movie_name IN (SELECT movie_name FROM BOX_OFFICE 
						WHERE YEAR(release_date) = 2018);
/*
'492','¾ÆÀÌ´Ù',NULL
'523','¶ó Æ®¶óºñ¾ÆÅ¸',NULL
'613','Ä«¸£¸à',NULL
'682','Åä½ºÄ«','¸¶¸£°¡·¹Å× ¹ß¸¸'
'3538','¹ÂÁî','Á¸ ¹ö'
'3538','¸ç´À¸®ÀÇ À¯È¤',NULL
'3538','ÄÁÀú¸µ ÇÏ¿ì½º','¹ÌÅ° ¸Æ±×·¡°Å'
'3538','¸ç´À¸®ÀÇ À¯È¤',NULL
'142','¶ó½ºÆ® ¹Ì¼Ç','Å¬¸°Æ® ÀÌ½ºÆ®¿ìµå'
*/

-- code 9-23 : multiple column comparing (col1, col2...)
-- above + condition:same director ; except the case of different movies in same name.
SELECT ranks, movie_name, director
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND (movie_name, director) IN (SELECT movie_name, director FROM BOX_OFFICE 
									WHERE YEAR(release_date) = 2018);
/*
'3538','ÄÁÀú¸µ ÇÏ¿ì½º','¹ÌÅ° ¸Æ±×·¡°Å'
'142','¶ó½ºÆ® ¹Ì¼Ç','Å¬¸°Æ® ÀÌ½ºÆ®¿ìµå'
*/

-- code 9-24 : NOT IN
SELECT ranks, movie_name, release_date, sale_amt, rep_country
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND ranks BETWEEN 1 AND 100
  AND rep_country NOT IN (SELECT rep_country FROM BOX_OFFICE 
							WHERE YEAR(release_date) = 2018 AND ranks BETWEEN 1 AND 100);
/* 
'78','Àå³­½º·± Å°½º','2019-03-27 00:00:00','3501463050','´ë¸¸' 
*/


-- EXISTS : only WHERE subquery.
-- it works like IN, but different
/* structure
SELECT
FROM TBL1
WHERE EXISTS (SELECT ... FROM TBL2 WHERE a.column = b.column ...)
... ; */

-- code 9-25 : EXISTS (same result code 9-22)
SELECT ranks, movie_name, director
FROM BOX_OFFICE a
WHERE YEAR(release_date) = 2019
  AND EXISTS (SELECT 1 FROM BOX_OFFICE b 
				WHERE YEAR(release_date) =2018 AND a.movie_name = b.movie_name);

-- code 9-26 : NOT EXISTS (same result code 9-24)
SELECT ranks, movie_name, release_date, sale_amt, rep_country
FROM BOX_OFFICE a
WHERE YEAR(release_date) = 2019
  AND ranks BETWEEN 1 AND 100
  AND NOT EXISTS (SELECT * FROM BOX_OFFICE b 
					WHERE YEAR(release_date) = 2018
					  AND ranks BETWEEN 1 AND 100
					  AND a.rep_country = b.rep_country);


-- p.332 quiz : alter code 9-23 using 'EXISTS'
-- code 9-23 : multiple column comparing (col1, col2...)
SELECT ranks, movie_name, director
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND (movie_name, director) IN (SELECT movie_name, director FROM BOX_OFFICE 
									WHERE YEAR(release_date) = 2018);
-- mine
SELECT ranks, movie_name, director
FROM BOX_OFFICE a
WHERE YEAR(release_date) = 2019
  AND EXISTS (SELECT movie_name, director 
				FROM BOX_OFFICE b
				WHERE YEAR(release_date) = 2018
                  AND a.movie_name = b.movie_name
                  AND a.director = b.director);
-- answer : same result but different
SELECT ranks, movie_name, director
FROM BOX_OFFICE a
WHERE YEAR(release_date) = 2019
  AND EXISTS (SELECT 1  -- < here
				FROM BOX_OFFICE b
				WHERE YEAR(release_date) = 2018
                  AND a.movie_name = b.movie_name
                  AND a.director = b.director);



/* self check */
-- 1. code 9-1 and code 9-3, find rank1 movies which is over the average sales' of total rank1 movies.

-- mine : doesn't understand right...
SELECT year(release_date) 'year', ranks, movie_name
FROM BOX_OFFICE
WHERE ranks = 1
  AND sale_amt >= (SELECT AVG(sale_amt) FROM BOX_OFFICE); -- I thought that the year's avg.. but this also wrong
SELECT year(release_date) 'year', ranks, movie_name
FROM BOX_OFFICE
WHERE ranks = 1
  AND sale_amt >= (SELECT AVG(sale_amt) FROM BOX_OFFICE WHERE ranks = 1);
  
-- answer : derived subquery
SELECT year(a.release_date) 'year', a.ranks, a.movie_name
FROM BOX_OFFICE a,
	(SELECT AVG(sale_amt) sale_amt FROM BOX_OFFICE WHERE ranks = 1) b
WHERE a.ranks = 1
  AND a.sale_amt > b.sale_amt
ORDER BY 1;


-- 2. code now, who employee recieve the maximum salary in each department?

-- mine: this do not work...
SELECT e.dept_no, s.salary, emp.emp_no, emp.first_name, emp.last_name
FROM DEPT_EMP e, SALARIES s, EMPLOYEES emp
WHERE e.emp_no = emp.emp_no AND e.emp_no = s.emp_no
  AND (e.emp_no, s.salary) IN (SELECT e.dept_no, MAX(s.salary) maxsal
								FROM DEPT_EMP e, SALARIES s
								WHERE e.emp_no = s.emp_no
								  AND SYSDATE() BETWEEN e.from_date AND e.to_date
								  AND SYSDATE() BETWEEN s.from_date AND s.to_date
								GROUP BY e.dept_no);

-- anxwer : find employee using a condition 'same salary' 
--  I think it maybe has a problem in case of same max salary but different employee.
SELECT TBL1.dept_no, s.salary, s.emp_no, TBL1.sal
FROM SALARIES s,
	(SELECT e.dept_no, MAX(s.salary) sal
		FROM DEPT_EMP e INNER JOIN SALARIES s ON e.emp_no = s.emp_no
		WHERE SYSDATE() BETWEEN s.from_date AND s.to_date
		GROUP BY e.dept_no) TBL1
WHERE s.salary = TBL1.sal
ORDER BY 1;


-- 3. KIND OF PIVOTING!!!!! : about 2018, 2019 released movies, sales amount by year, by quarter, 
-- form : year | quar1 | quar2 | quar3 | quar4
-- 		  2018 |
-- 		  2019 |

-- first got table : year's, quarter's sum 
SELECT YEAR(release_date) years, QUARTER(release_date) quarters, SUM(sale_amt) sales
FROM BOX_OFFICE
WHERE 1=1
  AND YEAR(release_date) IN (2018, 2019)
GROUP BY YEAR(release_date), QUARTER(release_date)
ORDER BY 1, 2;

-- mine : I was wrong
-- I have to `SUM(CASE WHEN ...sale_amt END)`, not `CASE WHEN ... SUM(sale_amt) END` .... 
SELECT YEAR(release_date) years,
		SUM(CASE WHEN QUARTER(release_date) = 1 THEN sale_amt END) quar1,
		SUM(CASE WHEN QUARTER(release_date) = 2 THEN sale_amt END) quar2,
        SUM(CASE WHEN QUARTER(release_date) = 3 THEN sale_amt END) quar3,
        SUM(CASE WHEN QUARTER(release_date) = 4 THEN sale_amt END) quar4
FROM BOX_OFFICE
WHERE 1=1
  AND YEAR(release_date) IN (2018, 2019)
GROUP BY YEAR(release_date)
ORDER BY 1, 2;

-- answer
SELECT years,
		SUM(CASE WHEN months BETWEEN 1 AND 3 THEN sales ELSE 0 END) quar1,
		SUM(CASE WHEN months BETWEEN 4 AND 6 THEN sales ELSE 0 END) quar2,
		SUM(CASE WHEN months BETWEEN 7 AND 9 THEN sales ELSE 0 END) quar3,
		SUM(CASE WHEN months BETWEEN 10 AND 12 THEN sales ELSE 0 END) quar4
FROM 
	(
    SELECT YEAR(release_date) years, MONTH(release_date) months, SUM(sale_amt) sales
    FROM BOX_OFFICE
    WHERE YEAR(release_date) IN (2018, 2019)
    GROUP BY 1, 2
    ) a
GROUP BY 1
ORDER BY 1;


-- 4. a number of employees who are not in any department

-- mine : all results '0'...
SELECT COUNT(e.emp_no)
FROM EMPLOYEES e LEFT JOIN DEPT_EMP d ON e.emp_no = d.emp_no
WHERE 1=1
  AND SYSDATE() BETWEEN d.from_date AND d.to_date
  AND dept_no IS NULL;
SELECT COUNT(e.emp_no)
FROM EMPLOYEES e 
		LEFT JOIN (SELECT * FROM DEPT_EMP WHERE SYSDATE() BETWEEN from_date AND to_date) tb1 ON e.emp_no = tb1.emp_no
WHERE 1=1
  AND tb1.dept_no NOT IN (SELECT DISTINCT dept_no FROM DEPARTMENTS);
  
-- answer : not in any department employees are not in dept_emp
SELECT COUNT(*)
FROM EMPLOYEES e
WHERE NOT EXISTS (SELECT emp_no FROM DEPT_EMP d
					WHERE SYSDATE() BETWEEN from_date AND to_date
                      AND e.emp_no = d.emp_no);  -- not exist with this condition!!
