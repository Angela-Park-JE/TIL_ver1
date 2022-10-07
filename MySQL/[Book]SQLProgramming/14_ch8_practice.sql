/* PRACTICE JOIN CH8.6 employee info tables */

USE PRACTICE;

-- code 8-26 : employees number, name, department name
-- mine
SELECT e.emp_no, e.first_name, e.last_name, dep.dept_name
FROM EMPLOYEES e 
	INNER JOIN DEPT_EMP emp ON e.emp_no = emp.emp_no
    INNER JOIN DEPARTMENTS dep ON emp.dept_no = dep.dept_no;
-- answer : use string functions to concat the first and last name.
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) emp_name, c.dept_name
FROM EMPLOYEES a
	INNER JOIN DEPT_EMP b ON a.emp_no = b.emp_no
    INNER JOIN DEPARTMENTS c ON b.dept_no = c.dept_no
ORDER BY a.emp_no;


-- code 8-27 : managers information of Marketing and Finance
-- mine
SELECT d.dept_name, e.emp_no, CONCAT(e.first_name, ' ', e.last_name) emp_name
FROM EMPLOYEES e 
	INNER JOIN DEPT_MANAGER m ON e.emp_no = m.emp_no
    INNER JOIN DEPARTMENTS d ON m.dept_no = d.dept_no
WHERE INSTR(d.dept_name, 'Marketing') !=0 
	OR INSTR(d.dept_name, 'Finance') !=0;
-- answer : date columns, and `IN` using, so results are different.
SELECT d.dept_name, e.emp_no, CONCAT(e.first_name, ' ', e.last_name) emp_name, m.from_date, m.to_date
FROM EMPLOYEES e 
	INNER JOIN DEPT_MANAGER m ON e.emp_no = m.emp_no
    INNER JOIN DEPARTMENTS d ON m.dept_no = d.dept_no
WHERE d.dept_name IN ('Marketing', 'Finance') !=0
	AND SYSDATE() BETWEEN m.from_date AND m.to_date; -- managers at this point


-- code 8-28 : at this point, manager's emp number of all department and department name
-- mine
SELECT d.dept_name, e.emp_no
FROM EMPLOYEES e INNER JOIN DEPT_MANAGER m ON e.emp_no = m.emp_no
				 INNER JOIN DEPARTMENTS d ON m.dept_no = d.dept_no
WHERE 1=1
  AND SYSDATE() BETWEEN m.from_date AND m.to_date
ORDER BY 1;
-- answer : date columns, and in case of manager's absence
SELECT d.dept_name, m.emp_no, m.from_date, m.to_date
FROM DEPT_MANAGER m RIGHT JOIN DEPARTMENTS d ON  m.dept_no = d.dept_no
WHERE 1=1
  AND SYSDATE() BETWEEN IFNULL(m.from_date, SYSDATE()) AND IFNULL(m.to_date, SYSDATE());


-- code 8-29 : number of employees in each department, and all employees number
-- mine
SELECT d.dept_name, COUNT(e.emp_no)
FROM EMPLOYEES emp LEFT JOIN DEPT_EMP e ON emp.emp_no = e.emp_no
				   -- LEFT JOIN dept_manager m ON emp.emp_no = m.emp_no
                   INNER JOIN DEPARTMENTS d ON e.dept_no = d.dept_no -- AND m.dept_no = d.dept_no
WHERE 1=1
  -- AND SYSDATE() BETWEEN IFNULL(m.from_date, SYSDATE()) AND IFNULL(m.to_date, SYSDATE())
  AND SYSDATE() BETWEEN IFNULL(e.from_date, SYSDATE()) AND IFNULL(e.to_date, SYSDATE())
GROUP BY d.dept_name WITH ROLLUP;
-- answer: results is right but... without ROLLUP XP
-- and it doesn't need to IFNULL with 'date' because this needs only employees, excluding managers.
SELECT d.dept_name, COUNT(*)
FROM DEPARTMENTS d INNER JOIN DEPT_EMP e ON d.dept_no = e.dept_no
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date
GROUP BY 1
UNION
SELECT 'ALL', COUNT(*)
FROM DEPT_EMP e
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date;
-- '''d.dept_name -> CASE WHEN d.dept_no = e.dept_no THEN d.dept_name END department_name'''
-- BUT it doesn't need to grouping by 'name', it could be 'number'!!! but this can't use `WITH ROLLUP`.
-- it doesn't need to write like this because already the answer is good enough,
-- but I learned that it doesn't have to state the group by column name or number exactly.
SELECT 
		CASE WHEN d.dept_no = e.dept_no THEN d.dept_name END department_name, 
        COUNT(*)
FROM DEPARTMENTS d INNER JOIN DEPT_EMP e ON d.dept_no = e.dept_no
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date
GROUP BY d.dept_no
UNION
SELECT 'ALL', COUNT(*)
FROM DEPT_EMP e
WHERE SYSDATE() BETWEEN e.from_date AND e.to_date;
