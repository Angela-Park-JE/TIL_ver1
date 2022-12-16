 /**- INSERT/UPDATE/DELETE -**/

/*- INSERT -*/
-- insert data to table 
-- column list length must to be same with value list length.
-- and the sequence, data type must to be same each other, too.
-- (1) if you want to part of the columns, you must to set each other correctly.
-- (2) 'not null' column must to be given with value.
-- (3) 'primary key' column must to be filled with unique value.
-- (4) if you want to pass the column list, you must to write all values sorted by the column sequence.

/* structure
INSERT INTO table_name (col1, col2, ...)
		VALUES (val1, val2, ...);
*/

/* !!! */
-- if you check after making the table and inserting the data, there is 'null' row.
-- it isn't error, it is just like a spare box. don't confuse with real result.

-- code 10-1: make sample table
USE practice;

CREATE TABLE emp_test
(
	emp_no		INT 			NOT NULL,
    emp_name 	VARCHAR(30) 	NOT NULL,
    hire_date	DATE			NULL,
    salary		INT 			NULL,
    PRIMARY KEY (emp_no)
);

DESC emp_test;									-- view the table

-- code 10-2: insert data
INSERT INTO emp_test (emp_no, emp_name, hire_date, salary)
		VALUES (1001, 'Phoenix', '2022-01-01', 1000);

SELECT * FROM emp_test; 						-- view the table

-- code 10-3: insert data more but make a null
INSERT INTO emp_test (emp_no, emp_name, hire_date)
		VALUES (1002, 'Neon', '2022-01-03');	-- no salary column and value.

SELECT * FROM emp_test;

-- code 10-4: insert data more but make a null too
INSERT INTO emp_test (hire_date, emp_name, emp_no)
		VALUES ('2021-10-31', 'Zett', 1000);	-- switch the sequence, and no salary column/value.

SELECT * FROM emp_test;

-- code 10-6: (3), error - insert data with duplicated primary key value
INSERT INTO emp_test (emp_no, emp_name, hire_date)
		VALUES (1000, 'Yoru', '2021-11-01');	-- same key value with 'Zett'

-- code 10-7: (4) insert the data with only values list
INSERT INTO emp_test
		VALUES (1003, 'Sky', '2022-01-18', 2000);

SELECT * FROM emp_test;



/*- INSERT with multiple value lists -*/
-- 'ROW' can be passed.

/* structure 
INSERT INTO table_name (col1, col2, ...)
	VALUES [ROW] (val1, val2, ...), [ROW] (val1, val2, ...);
*/ 

-- code 10-8: 
INSERT INTO emp_test VALUES
	ROW(1005, 'Omen', '2022-01-29', 1800),
    ROW(1006, 'Breach', '2022-02-01', 2100);

SELECT * FROM emp_test;

-- code 10-9: 'ROW' omitted
INSERT INTO emp_test VALUES
	(1007, 'Viper', '2022-02-14', 5000),
    (1008, 'Sage', '2022-02-14', 3800),
    (1009, 'Chamber', '2022-02-15', 4000);

SELECT * FROM emp_test;



/*- INSERT WITH 'SELECT' -*/
-- insert the data is 'SELECT' query result.
-- the column length, sequence, data type must to be same each other(table and 'SELECT' results)
-- 'primary key' must to be unique values.
/* structure
INSERT INTO table_name (col1, col2, ...)
	SELECT ...
    FROM ...
    WHERE ...;
*/

-- code 10-10: make sample table
CREATE TABLE emp_test2
(
	emp_no		INT 			NOT NULL,
    emp_name 	VARCHAR(30) 	NOT NULL,
    hire_date	DATE			NULL,
    salary		INT 			NULL,
    PRIMARY KEY (emp_no)
);

-- code 10-11: insert the data in the sample table 'emp_test2'
INSERT INTO emp_test2			-- omitted the column list = insert values in all columns
	SELECT emp_no, emp_name, hire_date, salary
      FROM emp_test
     WHERE emp_no IN (1000, 1001, 1002);

SELECT * FROM emp_test2;		-- 1000(Zett), 1001(Phoenix), 1002(Neon) is inserted.

-- code 10-12: all omitted - must to be same all columnss
INSERT INTO emp_test2
	SELECT *
      FROM emp_test
	 WHERE emp_no = 1003;

-- code 10-13: It's recommended to write all columns in order to prevent the error.
-- and the error is occured when 'primary key' column receives duplicated values.
INSERT INTO emp_test2 (emp_no, emp_name, hire_date, salary)
	SELECT emp_no, emp_name, hire_date, salary
      FROM emp_test
	 WHERE emp_no >= 1003;

-- code 10-14:
INSERT INTO emp_test2 (emp_no, emp_name, hire_date, salary)
	SELECT emp_no + 10, emp_name, hire_date, salary		-- +10 emp_no if the emp_no >= 1008.
      FROM emp_test
	 WHERE emp_no >= 1008;

SELECT * FROM emp_test2;					-- 1008(Sage), 1009(Chamber) is inserted and will be duplicated data.



/* p.349 quiz : insert the data into emp_test, with only 1 'INSERT'. */
-- mine. answer omitted the column name list.
INSERT INTO emp_test (emp_no, emp_name, hire_date, salary)
	VALUES (2001, 'Jang Young Sil', '2020-01-01', 1500),
		   (2002, 'Choi Moo Sun', '2020-01-31', NULL);
