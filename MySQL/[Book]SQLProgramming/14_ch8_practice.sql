/* PRACTICE JOIN CH8.6 employee info tables */

USE practice;


-- code 8-26 : employees number, name, department name
SELECT e.emp_no, e.first_name, e.last_name, dep.dept_name
FROM employees e 
	INNER JOIN dept_emp emp ON e.emp_no = emp.emp_no
    INNER JOIN departments dep ON emp.dept_no = dep.dept_no;

-- answer : use string functions to concat the first and last name.
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) emp_name, c.dept_name
FROM employees a
	INNER JOIN dept_emp b ON a.emp_no = b.emp_no
    INNER JOIN departments c ON b.dept_no = c.dept_no
ORDER BY a.emp_no;


-- code 8-27 : managers information of Marketing and Finance
SELECT d.dept_name, e.emp_no, CONCAT(e.first_name, ' ', e.last_name) emp_name
FROM employees e 
	INNER JOIN dept_manager m ON e.emp_no = m.emp_no
    INNER JOIN departments d ON m.dept_no = d.dept_no
WHERE INSTR(d.dept_name, 'Marketing') !=0 
	OR INSTR(d.dept_name, 'Finance') !=0;

-- answer : 
SELECT d.dept_name, e.emp_no, CONCAT(e.first_name, ' ', e.last_name) emp_name, m.from_date, m.to_date
FROM employees e 
	INNER JOIN dept_manager m ON e.emp_no = m.emp_no
    INNER JOIN departments d ON m.dept_no = d.dept_no
WHERE d.dept_name IN ('Marketing', 'Finance') !=0
	AND SYSDATE() BETWEEN m.from_date AND m.to_date;
