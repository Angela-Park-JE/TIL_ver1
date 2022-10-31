/**- SUBQUERY -**/
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


-- code 9-12: sometimes it must need a derived query case when the main query needs a calculated data
-- mine
SELECT d.dept_name, SUM(s.salary), AVG(s.salary)
FROM DEPARTMENTS d RIGHT JOIN DEPT_EMP e ON d.dept_no = e.dept_no
				  RIGHT JOIN SALARIES s ON e.emp_no = s.emp_no
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date
  AND SYSDATE() BETWEEN s.from_date AND s.to_date
GROUP BY d.dept_name;

-- code : dept_no, added COUNT employees
SELECT a.dept_no, a.dept_name, COUNT(*) cnt, SUM(c.salary) sum_salary, AVG(c.salary) dept_avg
FROM DEPARTMENTS a, DEPT_EMP b, SALARIES c
WHERE a.dept_no = b.dept_no AND b.emp_no = c.emp_no
  AND SYSDATE() BETWEEN b.from_date AND b.to_date 
  AND SYSDATE() BETWEEN c.from_date AND c.to_date
GROUP BY a.dept_no, a.dept_name
ORDER BY 1;


-- code 9-13 : departments total salary's AVG
SELECT AVG(TB1.sum_salary)			-- 193044765.5556
FROM 
	(SELECT a.dept_no, a.dept_name, COUNT(*) cnt, SUM(c.salary) sum_salary, AVG(c.salary) dept_avg
	FROM DEPARTMENTS a, DEPT_EMP b, SALARIES c
	WHERE a.dept_no = b.dept_no AND b.emp_no = c.emp_no
	  AND SYSDATE() BETWEEN b.from_date AND b.to_date 
	  AND SYSDATE() BETWEEN c.from_date AND c.to_date
	GROUP BY a.dept_no, a.dept_name
	ORDER BY 1) TB1;


-- code 9-14 : 2015년 이후 연도별 순위가 3위 안인 영화와 해당 영화의 매출액이 해당 연도 전체 매출액에서 차지하는 비율을 구하는 쿼리
SELECT YEAR(b.release_date), b.ranks, b.movie_name, ROUND(b.sale_amt / TB.total_amt * 100, 2) percentage
FROM box_office b
		INNER JOIN (SELECT YEAR(release_date) years, SUM(sale_amt) total_amt -- the total sales of the year
					FROM box_office
                    WHERE YEAR(release_date) >= 2015
                    GROUP BY 1
                    ) TB
		ON YEAR(b.release_date) = TB.years
WHERE b.ranks <= 3
ORDER BY 1, 2;



/*- LATERAL derived table -*/
-- AFTER MySQL 8.0.14 ver.
-- PREVIOUS : subquery can't refer the main query's table
-- BUT! WITH `LATERAL` can.
-- Just the position before the subquery which refers the main query's table.

-- code 9-15 : error
SELECT a.dept_no, a.dept_name, mng.emp_no
FROM DEPARTMENTS a, 
	(
    SELECT b.dept_no, b.emp_no, c.first_name, c.last_name
	FROM DEPT_MANAGER b, EMPLOYEES c
    WHERE b.emp_no = c.emp_no
      AND SYSDATE() BETWEEN b.from_date AND b.to_date
      AND a.dept_no = b.dept_no
   ) mng
ORDER BY 1;

-- code 9-16 : LATERAL
SELECT a.dept_no, a.dept_name, mng.emp_no
FROM DEPARTMENTS a, 
	LATERAL -- here
	(
    SELECT b.dept_no, b.emp_no, c.first_name, c.last_name
	FROM DEPT_MANAGER b, EMPLOYEES c
    WHERE b.emp_no = c.emp_no
      AND SYSDATE() BETWEEN b.from_date AND b.to_date
      AND a.dept_no = b.dept_no
   ) mng
ORDER BY 1;

-- code 9-17 : LATERAL INNER JOIN (same with 9-16)
SELECT a.dept_no, a.dept_name, mng.emp_no
FROM DEPARTMENTS a	   -- remove ','
	INNER JOIN LATERAL -- and here
	(
    SELECT b.dept_no, b.emp_no, c.first_name, c.last_name
	FROM DEPT_MANAGER b, EMPLOYEES c
    WHERE b.emp_no = c.emp_no
      AND SYSDATE() BETWEEN b.from_date AND b.to_date
      AND a.dept_no = b.dept_no
   ) mng
ORDER BY 1;

-- actually this simple problem can be solved with INNER JOIN like this, haha.
SELECT a.dept_no, a.dept_name, c.emp_no
FROM DEPARTMENTS a, DEPT_MANAGER b, EMPLOYEES c
WHERE a.dept_no = b.dept_no AND b.emp_no = c.emp_no 
  AND SYSDATE() BETWEEN b.from_date AND b.to_date
ORDER BY 1;



-- p.321 quiz: edit the subquery in code 9-5, country name and continent in WORLD SCHEMA, without error.
-- code 9-5: error
USE WORLD;
SELECT a.name, a.district, a.population, a.countrycode, 
	(SELECT b.name, b.continent
    FROM COUNTRY b
    WHERE a.countrycode = b.code
    ) countryname
FROM CITY a;

-- mine : I think mine is better ... 0_0 I make SCALAR subquery to derived subquery and join them using `LATERAL`
-- so I can use all two columns.
SELECT a.name, a.district, a.population, a.countrycode, c.*
FROM CITY a
	INNER JOIN LATERAL
	(SELECT b.name, b.continent
    FROM COUNTRY b
    WHERE a.countrycode = b.code
    ) c;
	
-- answer : this method make SCALAR subquery's results to one value. 
SELECT a.name, a.district, a.population,
	(SELECT CONCAT(b.name, ' ', b.continent)
    FROM COUNTRY b
    WHERE a.countrycode = b.code
    ) countryname
FROM CITY a
