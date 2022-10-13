/*** VIEW ***/
-- a temporary table from a saved query
-- not saving table, save a query. so look a view, it bring the result of the query.
-- USE in `FROM` sentence like a table.
-- CAN be composed with CTE.
-- CAN refer other views.

-- CREATE OR REPLACE : create a view / alter a view if there existing view in the same name
/* structure
CREATE [OR REPLACE] VIEW view_name AS
SELECT ... ;
*/

-- ALTER : alter the existing view. = `CREATE OR REPLACE`
/* structure
ALTER VIEW view_name AS 
SELECT ... ;
*/

-- DROP : delete the view.
/* structure
DROP VIEW view_name;
*/


-- code 11-28 : creating a view 1
-- code 11-27: SELECT * FROM DEPT_EMP WHERE SYSDATE() BETWEEN from_date AND to_date;
CREATE OR REPLACE VIEW dept_emp_v AS
SELECT emp_no, dept_no FROM DEPT_EMP WHERE SYSDATE() BETWEEN from_date AND to_date;

SELECT * FROM DEPT_EMP_V;

-- code 11-29 : creating a view 2 with previous view
CREATE OR REPLACE VIEW dept_sal_v AS
WITH TMP AS
	(SELECT a.dept_no, a.dept_name, COUNT(*) cnt, SUM(c.salary) salary 
     FROM DEPARTMENTS a, DEPT_EMP_V b, SALARIES c
     WHERE a.dept_no = b.dept_no 
	   AND b.emp_no = c.emp_no
       AND SYSDATE() BETWEEN c.from_date AND c.to_date
	 GROUP BY a.dept_no, a.dept_name
	),
	 DEPT_AVG AS
     (SELECT AVG(salary) avg_sal
	  FROM TMP
	)

SELECT dept_no, dept_name, salary, avg_sal
FROM TMP, DEPT_AVG;

SELECT *
FROM DEPT_SAL_V;


-- code 11-30 : alter the view
ALTER VIEW DEPT_EMP_V AS
SELECT emp_no, dept_no, from_date
FROM DEPT_EMP
WHERE SYSDATE() BETWEEN from_date AND to_date;

SELECT *
FROM DEPT_EMP_V;

-- code 11-31 : alter the view with `CREATE OR REPLACE`
CREATE OR REPLACE VIEW DEPT_EMP_V AS
SELECT emp_no, dept_no, from_date, to_date
FROM DEPT_EMP
WHERE SYSDATE() BETWEEN from_date AND to_date;

SELECT *
FROM DEPT_EMP_V;


-- code 11-32 : delete the view
DROP VIEW DETP_SAL_V;   -- I made a mistake o0o......



-- p.441 quiz : make a DEPT_EMP_INFO_V with current part's emp_no, name using DEPARTMENTS, DEPT_EMP, EMPLOYEES table
CREATE OR REPLACE VIEW DEPT_EMP_INFO_V AS
	SELECT d.dept_name, e.emp_no, CONCAT(emp.first_name, ' ', emp.last_name) full_name
    FROM DEPARTMENTS d, DEPT_EMP e, EMPLOYEES emp 
    WHERE d.dept_no = e.dept_no
      AND e.emp_no = emp.emp_no
	  AND SYSDATE() BETWEEN e.from_date AND e.to_date
	ORDER BY 1, 2;



/* self check */
-- 1. Refer to DEPT_EMP_INFO_V, make a new view DEPT_EMP_SAL_V with current dept_name, emp_no, full_name, salary.
-- mine : not wrong
CREATE OR REPLACE VIEW DEPT_EMP_SAL_V AS
	SELECT v.*, s.salary
    FROM DEPT_EMP_INFO_V v, SALARIES s
    WHERE v.emp_no = s.emp_no
      AND SYSDATE() BETWEEN s.from_date AND s.to_date;
-- answer : making a view not using the view.
CREATE OR REPLACE VIEW DEPT_EMP_SAL_V AS
	SELECT d.dept_name, e.emp_no, CONCAT(emp.first_name, ' ', emp.last_name) full_name, s.salary
    FROM DEPARTMENTS d, DEPT_EMP e, EMPLOYEES emp, SALARIES s
    WHERE d.dept_no = e.dept_no
      AND e.emp_no = emp.emp_no
	  AND SYSDATE() BETWEEN e.from_date AND e.to_date
	  AND emp.emp_no = s.emp_no							-- added here
      AND SYSDATE() BETWEEN s.from_date AND s.to_date
    ORDER BY 1, 4 DESC;

-- 2. Refer to DEPT_EMP_SAL_V, make a query with top 3 salary employees by department.
-- mine
WITH CTE AS 
	(SELECT dept_name, emp_no, full_name, salary, 
			DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) rank_salary
	FROM DEPT_EMP_SAL_V
    )
SELECT dept_name, emp_no, full_name, salary
FROM CTE
WHERE rank_salary <=3
ORDER BY 1, 4 DESC;
-- answer : same! but DENSE_RANK() -> RANK()
WITH BASIS AS 
	(SELECT dept_name, emp_no, full_name, salary, 
			RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) ranks
	FROM DEPT_EMP_SAL_V
    )
SELECT *
FROM BASIS
WHERE ranks <=3
ORDER BY 1, 5;

-- 3. Refer DEPT_EMP_SAL_V, make a query with 3 groups with salary top 10, by department.
-- mine : divided the rank in CTE and NTILE in main query
WITH CTE AS 
	(SELECT dept_name, emp_no, full_name, salary, 
			DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) rank_salary
	FROM DEPT_EMP_SAL_V
    )
SELECT dept_name, emp_no, full_name, salary, rank_salary,
	NTILE(3) OVER (PARTITION BY dept_name ORDER BY rank_salary) ntiles
FROM CTE
WHERE rank_salary<=10
ORDER BY 1, ntiles;
-- answer: result is same 
-- I put the condition in main query's `WHERE`,
-- But this make an another CTE with BASIS and use CTE in main query simply.
WITH BASIS AS 
	(SELECT dept_name, emp_no, full_name, salary, 
			RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) ranks
	FROM DEPT_EMP_SAL_V
    ),
     TOP10 AS
     (SELECT * 
     FROM BASIS 
     WHERE ranks <=10
     )

SELECT dept_name, emp_no, full_name, salary,
	NTILE(3) OVER (PARTITION BY dept_name ORDER BY salary DESC) grade
FROM TOP10
ORDER BY 1, grade;

-- 4. In BOX_OFFICE table, get 2019 release movies' monthly sale amount and a rate of change by monthly
WITH MONTHLY_SALES AS 
	(
    SELECT EXTRACT(YEAR_MONTH FROM release_date), sale_amt, 
		SUM(sale_amt) OVER (PARTITION BY MONTH(release_date))
	FROM BOX_OFFICE 
    WHERE YEAR(release_date) = 2019
	UNION
	SELECT movie_name, 
    );
    
SELECT EXTRACT(YEAR_MONTH FROM release_date) year_months, 
		SUM(sale_amt) OVER (PARTITION BY MONTH(release_date))
FROM BOX_OFFICE 
WHERE YEAR(release_date) = 2019
GROUP BY MONTH;
