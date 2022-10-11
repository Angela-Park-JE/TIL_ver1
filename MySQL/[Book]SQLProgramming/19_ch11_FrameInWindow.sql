/*** Window Functions ***/
-- window : group of rows which is grouped by specific column values
-- if use `group by`, the row number decreases.
-- but if use window functions, we can maintain the row number and see the aggregated value.

/*	structure : function part OVER (PARTITION BY col1, col2, ... ORDER BY ... ) */
-- functions which can calculate wiht 'window' : Aggregating function, Window function
-- Window function MUST use `OVER` sentence
-- PARTIION BY : this sets the aggregating group, but it don't short the rows.



/*** FRAME sentence (프레임 절) ***/
-- ADJUST the range of aggregation with Window Functions.
-- frame : partitioned part(subaggregate) in `PARTITION BY` group
/* structure : {ROWS or RANGE} BETWEEN 'frame_start' AND 'frame_end' */
-- ROWS : set the frame range by just row in current row
-- RANGE : set the frame range by the value in current row
-- BETWEEN 'frame_start' AND 'frame_end' : set the range using 

/* frame_start, frame_end options */
-- CURRENT ROW : current row
-- UNBOUNDED PRECEDING : first row in partition
-- UNBOUNDED FOLLOWING : last row in partition
-- n PRECEDING : {ROWS}: n'th previous row in current row | {RANGE}: a row which is (current row - n)
-- n FOLLOWING : {ROWS}: n'th next row in current row | {RANGE}: a row which is (current row + n)

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

-- code 11-22 : 
SELECT employee_id, emp_name, dept_name, salary,
		SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC 
						  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) rows_value,
	    SUM(salary) OVER (PARTITION BY dept_name ORDER BY salary DESC
						  RANGE BETWEEN 1000 PRECEDING AND 1000 FOLLOWING) range_value
FROM EMP_HIERARCHY
WHERE dept_name IN ('IT', 'Finance')
ORDER BY 3, 4 DESC;


/* FRAME sentence with Window Functions */
