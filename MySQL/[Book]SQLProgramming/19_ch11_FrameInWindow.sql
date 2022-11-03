/**- Window Functions -**/
-- window : group of rows which is grouped by specific column values
-- if use `group by`, the row number decreases.
-- but if use window functions, we can maintain the row number and see the aggregated value.

/*	structure : `function part` OVER (PARTITION BY col1, col2, ... ORDER BY ... ) */
-- functions which can calculate wiht 'window' : Aggregating function, Window function
-- Window function MUST use `OVER` sentence
-- PARTIION BY : this sets the aggregating group, but it don't short the rows.



/*- FRAME sentence (프레임 절) -*/
-- ADJUST the range of aggregation with Window Functions.
-- frame : partitioned part(subaggregate) in `PARTITION BY` group
/* structure : {ROWS or RANGE} BETWEEN 'frame_start' AND 'frame_end' */
-- ROWS : set the frame range by just row in current row
-- RANGE : set the frame range by 'the value' in current row
-- BETWEEN 'frame_start' AND 'frame_end' : set the range using 

/* frame_start, frame_end options */
-- CURRENT ROW : current row
-- UNBOUNDED PRECEDING : first row in partition
-- UNBOUNDED FOLLOWING : last row in partition
-- n PRECEDING : {ROWS}: n'th previous row in current row | {RANGE}: a row which is (current row - n)
-- n FOLLOWING : {ROWS}: n'th next row in current row | {RANGE}: a row which is (current row + n)


USE practice;
-- code 11-21 : partial sum using FRAME sentence
SELECT employee_id, emp_name, dept_name, salary,
			SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC 
						  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) rows_value,
	    SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC
						  RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) range_value
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
ORDER BY 3, 4 DESC;
/* IT part
# employee_id, emp_name, dept_name, salary, rows_value, range_value
'103', 'Alexander Hunold', 'IT', '9000', '9000', '9000'
'104', 'Bruce Ernst', 'IT', '6000', '15000', '15000'
'105', 'David Austin', 'IT', '4800', '19800', '24600'		<- here is considered same frame with '106'employee,
'106', 'Valli Pataballa', 'IT', '4800', '24600', '24600'	<- so they has same range_value.
'107', 'Diana Lorentz', 'IT', '4200', '28800', '28800'
*/

-- code 11-22 : SUM of+- 1 row VS +-1000 values in range
SELECT employee_id, emp_name, dept_name, salary,
			SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC 
						  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) rows_value,
	    SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC
						  RANGE BETWEEN 1000 PRECEDING AND 1000 FOLLOWING) range_value
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, rows_value, range_value
'108', 'Nancy Greenberg', 'Finance', '12008', '21008', '12008'
'109', 'Daniel Faviet', 'Finance', '9000', '29208', '17200'
'110', 'John Chen', 'Finance', '8200', '25000', '32700'
'112', 'Jose Manuel Urman', 'Finance', '7800', '23700', '30600'
'111', 'Ismael Sciarra', 'Finance', '7700', '22400', '30600'
'113', 'Luis Popp', 'Finance', '6900', '14600', '22400'
'103', 'Alexander Hunold', 'IT', '9000', '15000', '9000'
'104', 'Bruce Ernst', 'IT', '6000', '19800', '6000'
'105', 'David Austin', 'IT', '4800', '15600', '13800'
'106', 'Valli Pataballa', 'IT', '4800', '13800', '13800'
'107', 'Diana Lorentz', 'IT', '4200', '9000', '13800'
*/

/* FRAME sentence with Window Functions */
-- these functions are used with frame sentence
-- FIRST_VALUE(), LAST_VALUE() : first/last value in the frame 
-- NTH_VALUE(expr) : the n'th `expr` row's value in the frame, if there's any 'true' value than return NULL.

-- FIRST_VALUE(), LAST_VALUE()
-- code 11-23 : the frame range is set as 3 rows, front row and following row in the window.
SELECT employee_id, emp_name, dept_name, salary,
			FIRST_VALUE(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC 
								  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) firstvalue,
	    LAST_VALUE(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC
								  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) lastvalue
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
ORDER BY 3, 4;
/*
# employee_id, emp_name, dept_name, salary, firstvalue, lastvalue
'113', 'Luis Popp', 'Finance', '6900', '7700', '6900'
'111', 'Ismael Sciarra', 'Finance', '7700', '7800', '6900'
'112', 'Jose Manuel Urman', 'Finance', '7800', '8200', '7700'
'110', 'John Chen', 'Finance', '8200', '9000', '7800'
'109', 'Daniel Faviet', 'Finance', '9000', '12008', '8200'
'108', 'Nancy Greenberg', 'Finance', '12008', '12008', '9000'
'107', 'Diana Lorentz', 'IT', '4200', '4800', '4200'
'105', 'David Austin', 'IT', '4800', '6000', '4800'
'106', 'Valli Pataballa', 'IT', '4800', '4800', '4200'
'104', 'Bruce Ernst', 'IT', '6000', '9000', '4800'
'103', 'Alexander Hunold', 'IT', '9000', '9000', '6000'
*/

-- code 11-24 : the frame range is set through the current value's +1000 and -1000 in the window.
SELECT employee_id, emp_name, dept_name, salary,
			FIRST_VALUE(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC 
								  RANGE BETWEEN 1000 PRECEDING AND 1000 FOLLOWING) firstvalue,
	    LAST_VALUE(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC
								  RANGE BETWEEN 1000 PRECEDING AND 1000 FOLLOWING) lastvalue
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
ORDER BY 3, 4;
/*
# employee_id, emp_name, dept_name, salary, firstvalue, lastvalue
'113', 'Luis Popp', 'Finance', '6900', '7800', '6900'
'111', 'Ismael Sciarra', 'Finance', '7700', '8200', '6900'
'112', 'Jose Manuel Urman', 'Finance', '7800', '8200', '6900'
'110', 'John Chen', 'Finance', '8200', '9000', '7700'
'109', 'Daniel Faviet', 'Finance', '9000', '9000', '8200'
'108', 'Nancy Greenberg', 'Finance', '12008', '12008', '12008'
'107', 'Diana Lorentz', 'IT', '4200', '4800', '4200'
'105', 'David Austin', 'IT', '4800', '4800', '4200'
'106', 'Valli Pataballa', 'IT', '4800', '4800', '4200'
'104', 'Bruce Ernst', 'IT', '6000', '6000', '6000'
'103', 'Alexander Hunold', 'IT', '9000', '9000', '9000'
*/


-- NTH_VALUE()
-- code 11-25 : 
SELECT employee_id, emp_name, dept_name, salary,
			NTH_VALUE(salary, 2) OVER (PARTITION BY dept_name ORDER BY salary DESC 
								  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) rowvalue,
	    NTH_VALUE(salary, 3) OVER (PARTITION BY dept_name ORDER BY salary DESC
								  RANGE BETWEEN 1000 PRECEDING AND 1000 FOLLOWING) rangevalue
FROM EMP_HIERARCHY
WHERE dept_name IN('IT', 'Finance')
ORDER BY 3, 4 DESC;
/*
# employee_id, emp_name, dept_name, salary, rowvalue, rangevalue
'108', 'Nancy Greenberg', 'Finance', '12008', '9000', NULL
'109', 'Daniel Faviet', 'Finance', '9000', '9000', NULL
'110', 'John Chen', 'Finance', '8200', '8200', '7800'
'112', 'Jose Manuel Urman', 'Finance', '7800', '7800', '7700'
'111', 'Ismael Sciarra', 'Finance', '7700', '7700', '7700'
'113', 'Luis Popp', 'Finance', '6900', '6900', '6900'
'103', 'Alexander Hunold', 'IT', '9000', '6000', NULL
'104', 'Bruce Ernst', 'IT', '6000', '6000', NULL
'105', 'David Austin', 'IT', '4800', '4800', '4200'
'106', 'Valli Pataballa', 'IT', '4800', '4800', '4200'
'107', 'Diana Lorentz', 'IT', '4200', '4200', '4200'
*/



/* Using ALIAS to Window */
-- Named Window : window which is given an alias
-- next `WHERE`, write `WINDOW` , alias and AS, than write original window sentence.
/* structure
SELECT ..., 
		FUNCTION() OVER `ALIAS` `col_alias` 
FROM ...
WHERE ...
WINDOW `ALIAS` AS (PARTITION BY ... ORDER BY ... ROWS|RANGE ... )
ORDER BY ...; */

-- code 11-26 : code 11-23 USING window alias
SELECT employee_id, emp_name, dept_name, salary,
				FIRST_VALUE(salary) OVER wa firstvalue, 
        LAST_VALUE(salary) OVER wa lastvalue
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
WINDOW wa AS (PARTITION BY dept_name ORDER BY salary DESC
			  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
ORDER BY 3, 4;



-- p.433 quiz : Among the top 10 and 2019 released movies, Show rank, name, sales, total sales in BOX_OFFICE table, order by sales.
-- mine : the result is same with the answer.
SELECT ranks, movie_name, sale_amt, 
				SUM(sale_amt) OVER (PARTITION BY YEAR(release_date)) total_sales,
        CUME_DIST() OVER sale_win cume_sales									-- > WINDOW sale_win has `ORDER BY` so it worked.
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
	AND ranks <= 10
WINDOW sale_win AS (PARTITION BY YEAR(release_date) ORDER BY sale_amt DESC)
ORDER BY 1, 3, 4;
-- answer : Because the results are only in 2019, so this is a partition.
-- so it doesn't need another `PARTITION` sentence
SELECT ranks, movie_name, sale_amt, 
				SUM(sale_amt) OVER () total_sales,
        CUME_DIST() OVER (ORDER BY sale_amt DESC) cume_sales  -- > CUME_DIST() needs `ORDER BY` !!!
FROM BOX_OFFICE
WHERE YEAR(release_date) = 2019
  AND ranks <=10
ORDER BY ranks;
/*
# ranks, movie_name, sale_amt, total_sales, cume_sales
'1', '±ØÇÑÁ÷¾÷', '139651845516', '864306256605', '0.1'
'2', '¾îº¥Á®½º: ¿£µå°ÔÀÓ', '122182694160', '864306256605', '0.2'
'3', '°Ü¿ï¿Õ±¹ 2', '111596248720', '864306256605', '0.3'
'4', '¾Ë¶óµò', '106955138359', '864306256605', '0.4'
'5', '±â»ýÃæ', '85883963645', '864306256605', '0.5'
'6', '¿¢½ÃÆ®', '79232012162', '864306256605', '0.6'
'7', '½ºÆÄÀÌ´õ¸Ç: ÆÄ ÇÁ·Ò È¨', '69010000100', '864306256605', '0.7'
'8', '¹éµÎ»ê', '52905789770', '864306256605', '0.8'
'9', 'Ä¸Æ¾ ¸¶ºí', '51507488723', '864306256605', '0.9'
'10', 'Á¶Ä¿', '45381075450', '864306256605', '1'
*/
