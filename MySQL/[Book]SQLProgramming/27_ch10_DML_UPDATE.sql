/**- INSERT/UPDATE/DELETE -**/

/*- UPDATE -*/
-- update(commit) data in the table 
-- if 'WHERE' is omitted, all the data is updated with new value.
-- if 'ORDER BY' is used, the data is updated order by the written column.
-- you can limit the row number which is updated.

/* structure
UPDATE table_name
	SET col1 = val1,
		col2 = val2, ....
WHERE ...
ORDER BY ...
LIMIT ...;
*/

-- code 10-15: make sample table
CREATE TABLE emp_update AS			-- create and insert at once.
SELECT * FROM emp_test;

ALTER TABLE emp_update 
	ADD CONSTRAINT PRIMARY KEY (emp_no);	-- set 'primary key' because 'CREATE' don't copy the primary key or index.

CREATE TABLE emp_update2 AS
SELECT * FROM emp_test2;

ALTER TABLE emp_update2
	ADD CONSTRAINT PRIMARY KEY (emp_no);

-- code 10-16: if off 'safe update mode', you must reboot MySQL Workbench.
UPDATE emp_update
	SET emp_name = CONCAT(emp_name, '2'),
		salary	 = salary + 100; 
SELECT * FROM emp_update;

-- code 10-17: error - Error Code: 1062. Duplicate entry '1019' for key 'emp_update2.PRIMARY'
UPDATE emp_update2
	SET emp_no = emp_no +1
WHERE emp_no >= 1018;
-- 1018 + 1 = 1019, but 1019 is already there.

-- code 10-18: not error, with code 10-17.
UPDATE emp_update2
	SET emp_no = emp_no +1
WHERE emp_no >= 1018
ORDER BY emp_no DESC;
SELECT * FROM emp_update2;
/* changed correctly.
'1019','Sage','2022-02-14','3800'
'1020','Chamber','2022-02-15','4000'
*/



/* UPDATE multiple 'tables' */
-- (1) we can update the data refer to another table.
-- (2) we can update the same data in different tables coincidently
-- can write the join condition on 'WHERE'
-- CAN'T use 'ORDER BY', 'LIMIT'
/* structure
UPDATE table_name1, table_name2, ...
	SET col1 = val1,
		col2 = val2, ...
WHERE condition(tables join condition);
*/

-- code 10-19: (1)
UPDATE emp_update2 a, emp_update b
	SET a.salary = b.salary + 1000
WHERE a.emp_no = b.emp_no;			-- doesn't updated 2 rows (1019, 1020 aren't changed because aren't there in the referred table.)

SELECT * FROM emp_update2;
/*
'1000','Zett','2021-10-31',NULL
'1001','Phoenix','2022-01-01','2100'
'1002','Neon','2022-01-03',NULL
'1003','Sky','2022-01-18','3100'
'1005','Omen','2022-01-29','2900'
'1006','Breach','2022-02-01','3200'
'1007','Viper','2022-02-14','6100'
'1008','Sage','2022-02-14','4900'
'1009','Chamber','2022-02-15','5100'
'1019','Sage','2022-02-14','3800'
'1020','Chamber','2022-02-15','4000'
*/

SELECT * FROM emp_update;
/*
'1000','Zett2','2021-10-31',NULL
'1001','Phoenix2','2022-01-01','1100'
'1002','Neon2','2022-01-03',NULL
'1003','Sky2','2022-01-18','2100'
'1005','Omen2','2022-01-29','1900'
'1006','Breach2','2022-02-01','2200'
'1007','Viper2','2022-02-14','5100'
'1008','Sage2','2022-02-14','3900'
'1009','Chamber2','2022-02-15','4100'
'2001','Jang Young Sil2','2020-01-01','1600'
'2002','Choi Moo Sun2','2020-01-31',NULL
*/

-- code 10-20: (2)
UPDATE emp_update2 a, emp_update b
	SET b.salary = IFNULL(b.salary, 0),		-- this is occured first,
		a.salary = b.salary + 1000			-- NULL salary will be 1000.
WHERE a.emp_no = b.emp_no;

SELECT * FROM emp_update2; -- NULL O, and +1000

SELECT * FROM emp_update;	-- NULL X, NULL -> 0



/*- INSERT and UPDATE at once -*/
-- First check the condition, 
-- and if there's not the value, insert it. if there's the value, update it.
-- this is INSERT query, so we can use all commands of the INSERT.

/* structure
INSERT INTO table_name (col1, col2, ...)
VALUES sentence(or SELECT sentence)
	ON DUPLICATE KEY UPDATE col1 = val1, val2, ...;
*/
-- INSERT occured an error with duplicated value in 'primary key' column,
-- but this doesn't. just alter the data.

-- code 10-21:
INSERT INTO emp_update2
SELECT emp_no, emp_name, hire_date, salary
FROM emp_update a
WHERE emp_no BETWEEN 1003 AND 1005
	ON duplicate key update emp_name = a.emp_name, salary = a.salary;

SELECT * FROM emp_update2;
/*
'1003','Sky2','2022-01-18','2100'
'1005','Omen2','2022-01-29','1900'
*/



/* p.360 quiz: update the 1001, 1002 in 'emp_update2'
	with emp_name in 'emp_update', which are same emp_no. */
-- mine:
INSERT INTO emp_update2
SELECT *
FROM emp_update a
WHERE emp_no in (1001, 1002)
	ON DUPLICATE KEY UPDATE emp_name = a.emp_name;
/*	
'1001','Phoenix2','2022-01-01','2100'
'1002','Neon2','2022-01-03',NULL
*/

-- answer:
UPDATE emp_update2 a, emp_update b
	SET a.emp_name = b.emp_name
WHERE a.emp_no = b.emp_no
  AND a.emp_no IN (1001, 1002);
/*
'1001','Phoenix2','2022-01-01','2100'
'1002','Neon2','2022-01-03',NULL
*/

-- it's same!
SELECT * FROM emp_update2; 
