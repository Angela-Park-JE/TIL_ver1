/*** CTE ***/
-- CTE : Common Table Expression
-- = WITH : sentence, kind of subquery but it is stated in front of the main query.

-- subquery can't refer the other subquery in derived subquery situation,
-- but if use CTE, can do.

/* structure
WITH cte1 AS (SELECT ... FROM ...),
	 cte2 AS (SELECT ... FROM ...),
     ...

SELECT ...
FROM cte1, cte2 ...
WHERE ... ; */

-- code 11-1 :
USE practice;

WITH MNG AS 
	(
    SELECT b.dept_no, b.emp_no, c.first_name, c.last_name
	FROM DEPT_MANAGER b, EMPLOYEES c
    WHERE b.emp_no = c.emp_no
	  AND SYSDATE() BETWEEN b.from_date AND b.to_date
	)

SELECT a.dept_no, a.dept_name, b.emp_no, b.first_name, b.last_name
FROM DEPARTMENTS a, MNG b
WHERE a.dept_no = b.dept_no
ORDER BY 1;


-- code 11-2 : error, subquery can't refer the other subquery
SELECT a.dep_no, a.dept_name, sal.emp_no, sal.salary
FROM DEPARTEMENTS a,
	(SELECT emp_no, dept_no FROM DEPT_MANAGER 
		WHERE SYSDATE() BETWEEN from_date AND to_date) DEPT_MGR,
    (SELECT a.emp_no, a.salary, b.dept_no FROM SALARIES a, DEPT_MGR b 
		WHERE SYSDATE() BETWEEN a.from_date AND a.to_date 
          AND a.emp_no = b.emp_no) SAL
WHERE a.dept_no = sal.dept_no;
-- code 11-3 : alter the 11-2 using CTE
WITH DEPT_MGR AS 
		(SELECT emp_no, dept_no 
        FROM DEPT_MANAGER 
		WHERE SYSDATE() BETWEEN from_date AND to_date),
	SAL AS
		(SELECT a.emp_no, a.salary, b.dept_no FROM SALARIES a, DEPT_MGR b 
		WHERE SYSDATE() BETWEEN a.from_date AND a.to_date 
          AND a.emp_no = b.emp_no)

SELECT a.dept_no, a.dept_name, sal.emp_no, sal.salary
FROM DEPARTMENTS a, SAL
WHERE a.dept_no = sal.dept_no;

-- code 11-4 : 9-13's subquery to CTE
WITH TMP AS
		(SELECT a.dept_no, a.dept_name, COUNT(*) cnt, SUM(c.salary) sum_salary
			FROM DEPARTMENTS a, DEPT_EMP b, SALARIES c
			WHERE a.dept_no = b.dept_no AND b.emp_no = c.emp_no
			  AND SYSDATE() BETWEEN b.from_date AND b.to_date 
			  AND SYSDATE() BETWEEN c.from_date AND c.to_date
			GROUP BY a.dept_no, a.dept_name
			ORDER BY 1),
	DEPT_AVG AS
		(SELECT AVG(TMP.sum_salary) avg_sal			-- 193044765.5556
		   FROM TMP)

SELECT dept_no, dept_name, sum_salary, avg_sal
FROM TMP, DEPT_AVG;


/* RECURSIVE QUERY with CTE */
-- it refer to itself in query, so it repeat the subaggregate results until return the final result.
-- using when making consecutive rows or writing hierarchical(계층형) query.
/* structure
WITH RECURSIVE cte1 AS
	(SELECT ... FROM ...       -- > first query
	  UNION ALL
	 SELECT ... FROM cte1 ...  -- > refer itself
     ),
	...
SELECT ... 
FROM cte1, cte2, ... ; */

-- making consecutive rows --
-- code 11-5 : 
WITH RECURSIVE cte AS 
		(SELECT 1 AS n 		-- starting query. set the first row. 
			UNION ALL
		 SELECT n + 1 FROM cte WHERE n < 5  -- repeat the SELECT until the WHERE condition comes true.
         )
SELECT * FROM cte;
/*
# n
'1'
'2'
'3'
'4'
'5'
*/

-- code 11-6 : released moives by release_date
SELECT DATE(release_date) dates, COUNT(*) 
FROM box_office
WHERE EXTRACT(YEAR_MONTH FROm release_date) = 201901
GROUP BY 1
ORDER BY 1;
-- code 11-7 : making other days which are not in `DATE(release_date)`
WITH RECURSIVE cte1 AS 
	(
    SELECT MIN(DATE(release_date)) dates
	FROM BOX_OFFICE
    WHERE EXTRACT(YEAR_MONTH FROM release_date) = 201901
	UNION ALL
    SELECT ADDDATE(dates, 1)
    FROM cte1
    WHERE ADDDATE(dates, 1) <= '2019-01-31'
    )

SELECT a.dates, COUNT(b.movie_name) cnt
FROM cte1 a 
	LEFT JOIN BOX_OFFICE b ON a.dates = b.release_date
GROUP BY 1
ORDER BY 1;


-- writing hierarchical(계층형) query --
