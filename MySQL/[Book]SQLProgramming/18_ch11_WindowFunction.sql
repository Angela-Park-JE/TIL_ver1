/*** Window Functions ***/
-- window : group of rows which is grouped by specific column values
-- if use `group by`, the row number decreases.
-- but if use window functions, we can maintain the row number and see the aggregated value.

/*	structure : function part OVER (PARTITION BY col1, col2, ... ORDER BY ... ) */

-- functions which can calculate wiht 'window' : Aggregating function, Window function
-- Window function MUST use `OVER` sentence
-- PARTIION BY : this sets the aggregating group, but it don't short the rows.

-- code 11-10 :
SELECT YEAR(release_date) years, SUM(sale_amt) sum_amt, AVG(sale_amt) avg_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) >= 2018
  AND ranks <= 10
GROUP BY 1 ORDER BY 1;
-- code 11-11 : using CTE, show each movies rank and the aggregated values. good but complex
WITH SUMMARY AS 
	(SELECT YEAR(release_date) years, SUM(sale_amt) sum_amt, AVG(sale_amt) avg_amt
	FROM BOX_OFFICE
	WHERE YEAR(release_date) >= 2018
	  AND ranks <= 10
	GROUP BY 1)

SELECT b.years, a.ranks, a.movie_name, a.sale_amt, b.sum_amt, b.avg_amt
FROM BOX_OFFICE a INNER JOIN SUMMARY b ON YEAR(a.release_date) = b.years
WHERE a.ranks <= 10
ORDER BY 1, 2;
-- code 11-12 : using window function
SELECT YEAR(release_date) years, ranks, movie_name, sale_amt,
	   SUM(sale_amt) OVER (PARTITION BY YEAR(release_date)) sum_amt,
       AVG(sale_amt) OVER (PARTITION BY YEAR(release_date)) avg_amt
FROM BOX_OFFICE
WHERE YEAR(release_date) >= 2018 
  AND ranks <= 10
ORDER BY 1, 2;


/* Window functions */
-- ROW_NUMBER() : row's number
-- RANK() : each row's ranks
-- DENSE_RANK() : accumulated ranks (누적 순위)
-- PERCENT_RANK() : ranks by ratio (비율 순위)
-- LAG() : previous row's value
-- LEAD() : next row's value
-- CUME_DIST() : cumulative distribution value(누적 분포 값)
-- NTILE() : bucket partition value (분할 버킷 수)
-- FIRST_VALUE() : first row's value in the specified range
-- LAST_VALUE() : last row's value in the specified range
-- NTH_VALUE() : n'th row's value in the specified range


-- ROW_NUMBER() : row's number in query result's group
-- numbers are followed by `ORDER BY` group after `PARTITION BY`

-- code 11-13 : numbered by salary in a department
SELECT employee_id, emp_name, dept_name, salary,
		ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY salary DESC)  -- here
FROM EMP_HIERARCHY
ORDER BY 3, 4 DESC;


-- RANK() : same scores are treated in the same rank but the next ranks are pushed back as the previous same scores' number.
-- DENSE_RANK() : same scores are treated in the same rank and the next ranks are not pushed back, just the next number is allotted.
-- PERCENT_RANK() : percentile rank

-- code 11-14 : salary ranking in a department
SELECT employee_id, emp_name, dept_name, salary,
		RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) ranks,
        DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) dense_ranks,
        PERCENT_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) percent_ranks
FROM EMP_HIERARCHY
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, ranks, dense_ranks, percent_ranks
'205', 'Shelley Higgins', 'Accounting', '12008', '1', '1', '0'
'206', 'William Gietz', 'Accounting', '8300', '2', '2', '1'
'200', 'Jennifer Whalen', 'Administration', '4400', '1', '1', '0'
'100', 'Steven King', 'Executive', '24000', '1', '1', '0'
'101', 'Neena Kochhar', 'Executive', '17000', '2', '2', '0.5'
'102', 'Lex De Haan', 'Executive', '17000', '2', '2', '0.5'
'108', 'Nancy Greenberg', 'Finance', '12008', '1', '1', '0'
'109', 'Daniel Faviet', 'Finance', '9000', '2', '2', '0.2'
'110', 'John Chen', 'Finance', '8200', '3', '3', '0.4'
'112', 'Jose Manuel Urman', 'Finance', '7800', '4', '4', '0.6'
'111', 'Ismael Sciarra', 'Finance', '7700', '5', '5', '0.8'
'113', 'Luis Popp', 'Finance', '6900', '6', '6', '1'
'203', 'Susan Mavris', 'Human Resources', '6500', '1', '1', '0'
'103', 'Alexander Hunold', 'IT', '9000', '1', '1', '0'
'104', 'Bruce Ernst', 'IT', '6000', '2', '2', '0.25'
'105', 'David Austin', 'IT', '4800', '3', '3', '0.5'
'106', 'Valli Pataballa', 'IT', '4800', '3', '3', '0.5'
'107', 'Diana Lorentz', 'IT', '4200', '5', '4', '1'
'204', 'Hermann Baer', 'Public Relations', '10000', '1', '1', '0'
*/


-- LAG(expr, n, default_value) : get the previous `expr` as `n`
-- LEAD(expr, n, default_value) : get the next `expr` as`n`
-- default `n` is 1, `default_value` set the value when the value is NULL, default is NULL.

-- code 11-15 : lag or lead next man's salary in a department
SELECT employee_id, emp_name, dept_name, salary, 
		LAG(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC) lag_previous,
        LEAD(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC) lead_next
FROM EMP_HIERARCHY
ORDER BY 3, 4 DESC;

-- code 11-16 : NULL -> 0
SELECT employee_id, emp_name, dept_name, salary, 
		LAG(salary, 1, 0) OVER (PARTITION BY dept_name ORDER BY salary DESC) lag_previous_higherman_salary,
        LEAD(salary, 1, 0) OVER (PARTITION BY dept_name ORDER BY salary DESC) lead_next_lowerman_salary
FROM EMP_HIERARCHY
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, lag_previous_higherman_salary, lead_next_lowerman_salary
'205', 'Shelley Higgins', 'Accounting', '12008', '0', '8300'
'206', 'William Gietz', 'Accounting', '8300', '12008', '0'
'200', 'Jennifer Whalen', 'Administration', '4400', '0', '0'
'100', 'Steven King', 'Executive', '24000', '0', '17000'
'101', 'Neena Kochhar', 'Executive', '17000', '24000', '17000'
'102', 'Lex De Haan', 'Executive', '17000', '17000', '0'
'108', 'Nancy Greenberg', 'Finance', '12008', '0', '9000'
'109', 'Daniel Faviet', 'Finance', '9000', '12008', '8200'
'110', 'John Chen', 'Finance', '8200', '9000', '7800'
'112', 'Jose Manuel Urman', 'Finance', '7800', '8200', '7700'
'111', 'Ismael Sciarra', 'Finance', '7700', '7800', '6900'
'113', 'Luis Popp', 'Finance', '6900', '7700', '0'
'203', 'Susan Mavris', 'Human Resources', '6500', '0', '0'
'103', 'Alexander Hunold', 'IT', '9000', '0', '6000'
'104', 'Bruce Ernst', 'IT', '6000', '9000', '4800'
'105', 'David Austin', 'IT', '4800', '6000', '4800'
'106', 'Valli Pataballa', 'IT', '4800', '4800', '4200'
'107', 'Diana Lorentz', 'IT', '4200', '4800', '0'
'204', 'Hermann Baer', 'Public Relations', '10000', '0', '0'
*/

-- code 11-18 : earnings rate by year, using WITH subquery and LAG()
WITH BASIS AS
		(
        SELECT YEAR(release_date) years, sale_amt,
				LAG(sale_amt, 1, 0) OVER (ORDER BY YEAR(release_date)) lastyear_sale_amt
		FROM BOX_OFFICE
        WHERE ranks = 1
        )
SELECT years, FORMAT(sale_amt, 0) thisyearsales, FORMAT(lastyear_sale_amt, 0) lastyearsales,
		ROUND( (sale_amt - lastyear_sale_amt) / lastyear_sale_amt * 100, 2 ) increasedamount_rates
FROM BASIS
ORDER BY 1 DESC;
/*
# years, thisyearsales, lastyearsales, increasedamount_rates
'2019', '139651845516', '102666146909', '36.03'
'2018', '102666146909', '95853645649', '7.11'
'2017', '95853645649', '93178283048', '2.87'
'2016', '93178283048', '105168155250', '-11.4'
'2015', '105168155250', '135748398910', '-22.53'
'2014', '135748398910', '91431914670', '48.47'
'2013', '91431914670', '93664808500', '-2.38'
'2012', '93664808500', '74840681500', '25.15'
'2011', '74840681500', '81455728000', '-8.12'
'2009', '81025004000', '43747552000', '85.21'
'2009', '81455728000', '81025004000', '0.53'
'2008', '43747552000', '49339934700', '-11.33'
'2007', '49339934700', '66715713300', '-26.04'
'2006', '66715713300', '40328508500', '65.43'
'2005', '40328508500', '15687180500', '157.08'
'2004', '15687180500', '0', NULL
*/


-- CUME_DIST() : cumulative distribution value(누적 분포 값)
-- but in MySQL, (the values number under now row's number) / (all row number)
-- 'under' means all previous values by `ORDER BY`, in other words, the relative position in the group.

-- code 11-19 :
SELECT employee_id, emp_name, dept_name, salary,
		CUME_DIST() OVER (PARTITION BY dept_name ORDER BY salary DESC) rates
FROM emp_hierarchy
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, rates
'205', 'Shelley Higgins', 'Accounting', '12008', '0.5'
'206', 'William Gietz', 'Accounting', '8300', '1'
'200', 'Jennifer Whalen', 'Administration', '4400', '1'
'100', 'Steven King', 'Executive', '24000', '0.3333333333333333'
'101', 'Neena Kochhar', 'Executive', '17000', '1'
'102', 'Lex De Haan', 'Executive', '17000', '1'
'108', 'Nancy Greenberg', 'Finance', '12008', '0.16666666666666666'
'109', 'Daniel Faviet', 'Finance', '9000', '0.3333333333333333'
'110', 'John Chen', 'Finance', '8200', '0.5'
'112', 'Jose Manuel Urman', 'Finance', '7800', '0.6666666666666666'
'111', 'Ismael Sciarra', 'Finance', '7700', '0.8333333333333334'
'113', 'Luis Popp', 'Finance', '6900', '1'
'203', 'Susan Mavris', 'Human Resources', '6500', '1'
'103', 'Alexander Hunold', 'IT', '9000', '0.2'
'104', 'Bruce Ernst', 'IT', '6000', '0.4'
'105', 'David Austin', 'IT', '4800', '0.8'
'106', 'Valli Pataballa', 'IT', '4800', '0.8'
'107', 'Diana Lorentz', 'IT', '4200', '1'
'204', 'Hermann Baer', 'Public Relations', '10000', '1'
*/


-- NTILE(n) : divide the rows in a group to `n`. 
-- 'Which bucket should we put it in if we divide the rows?'

-- code 11-20 : give a grades in each department by salary
SELECT employee_id, emp_name, dept_name, salary,
		NTILE(3) OVER (PARTITION BY dept_name ORDER BY salary DESC) ntiles
FROM EMP_HIERARCHY
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, ntiles
'205', 'Shelley Higgins', 'Accounting', '12008', '1'
'206', 'William Gietz', 'Accounting', '8300', '2'
'200', 'Jennifer Whalen', 'Administration', '4400', '1'
'100', 'Steven King', 'Executive', '24000', '1'
'101', 'Neena Kochhar', 'Executive', '17000', '2'
'102', 'Lex De Haan', 'Executive', '17000', '3'
'108', 'Nancy Greenberg', 'Finance', '12008', '1'
'109', 'Daniel Faviet', 'Finance', '9000', '1'
'110', 'John Chen', 'Finance', '8200', '2'
'112', 'Jose Manuel Urman', 'Finance', '7800', '2'
'111', 'Ismael Sciarra', 'Finance', '7700', '3'
'113', 'Luis Popp', 'Finance', '6900', '3'
'203', 'Susan Mavris', 'Human Resources', '6500', '1'
'103', 'Alexander Hunold', 'IT', '9000', '1'
'104', 'Bruce Ernst', 'IT', '6000', '1'
'105', 'David Austin', 'IT', '4800', '2'
'106', 'Valli Pataballa', 'IT', '4800', '2'
'107', 'Diana Lorentz', 'IT', '4200', '3'
'204', 'Hermann Baer', 'Public Relations', '10000', '1'
*/



/* FRAME sentence -> next file */
