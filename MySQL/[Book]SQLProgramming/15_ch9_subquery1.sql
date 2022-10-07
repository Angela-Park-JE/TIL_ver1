/*** SUBQUERY ***/
-- a query inside of a query
-- independent SELECT sentence, and covered '( )'
-- using for main query


/*- SCALAR subquery -*/
-- located in main query's SELECT
-- it makes only one row (for one row in main query)
-- using a lot when bring a name or one something from other table
/* structure
SELECT col1, col2 ...
	(SELECT ... FROM ... WHERE ... ) [AS] alias
FROM ...
WHERE ...; */

-- code 9-4: it can do using `JOIN` also.
USE world;
SELECT a.name, a.district, a.population, a.countrycode,
		(SELECT b.name
		   FROM COUNTRY b
		  WHERE a.countrycode = b.code
		) countryname
FROM city a;

-- code 9-8: all departments with manager emp_no
USE practice;
SELECT a.dept_no, a.dept_name, 
		(SELECT b.emp_no
		   FROM DEPT_MANAGER b
		  WHERE b.dept_no = a.dept_no
				AND SYSDATE() BETWEEN b.from_date AND b.to_date
		) emp_no
FROM DEPARTMENTS a
ORDER BY 1;
-- code 9-7: also can do with JOIN 
-- but this need to use IFNULL because it can't show the case when the MANAGER isn't.
SELECT a.dept_no, a.dept_name, b.emp_no
FROM DEPARTMENTS a LEFT JOIN DEPT_MANAGER b ON b.dept_no = a.dept_no
WHERE SYSDATE() BETWEEN b.from_date AND b.to_date;



/*- DERIVED subquery -*/
-- located in main query's FROM
-- it works like a table
-- MUST state the alias of table.
-- CAN use the columns which is in derived table in main query.
-- CAN use multiple derived subquery in main query's FROM.
/* structure
SELECT col1, col2 ...
FROM tbl1 [AS] alias1,
	(SELECT ... FROM ... WHERE ... ) [AS] alias2
    ...
WHERE ...; */

-- code 9-10: can do this join 3 tables also.
SELECT d.dept_no, d.dept_name, 
	   mng.emp_no, mng.first_name, mng.last_name
FROM DEPARTMENTS d,
	(SELECT m.dept_no, m.emp_no, emp.first_name, emp.last_name
       FROM DEPT_MANAGER m, EMPLOYEES emp
	  WHERE m.emp_no = emp.emp_no
			AND SYSDATE() BETWEEN m.from_date AND m.to_date
	) mng
WHERE d.dept_no = mng.dept_no
ORDER BY 1;

-- code 9-11 arrange: above code with NATURAL JOIN
SELECT d.dept_no, d.dept_name, 
	   m.emp_no, e.first_name, e.last_name
FROM DEPARTMENTS d NATURAL JOIN DEPT_MANAGER m NATURAL JOIN EMPLOYEES e
WHERE SYSDATE() BETWEEN m.from_date AND m.to_date
ORDER BY 1;


-- 하다말음
-- code 9-12: sometimes it must need a derived query case when the main query needs a calculated data
SELECT d.dept_name, SUM(s.salary), AVG(s.salary)
FROM DEPARTMENTS d RIGHT JOIN DEPT_EMP e ON d.dept_no = e.dept_no
				  RIGHT JOIN SALARIES s ON e.emp_no = s.emp_no
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date
  AND SYSDATE() BETWEEN s.from_date AND s.to_date
GROUP BY d.dept_name;
