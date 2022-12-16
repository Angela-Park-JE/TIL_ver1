----------------
/**- INSERT/UPDATE/DELETE -**/

/*- DELETE -*/
-- don't need to write all columns 
-- [WARNNING!] if you didn't write 'WHERE', all the data would be deleted.

/* structure
DELETE FROM table_name
	WHERE condition
	ORDER BY ...
	LIMIT ...;
*/


-- code 10-22: create a sample table
CREATE TABLE emp_delete AS
	SELECT *
    FROM emp_test;

ALTER TABLE emp_delete
	ADD CONSTRAINT PRIMARY KEY (emp_no);

SELECT * FROM emp_delete;

-- code 10-23: delete some rows, if its salary value is NULL 
DELETE FROM emp_delete
WHERE salary IS NULL;

-- code 10-24: delete all rows
DELETE FROM emp_delete;				-- empty table!

-- code 10-25: insert the data in the empty table
INSERT INTO emp_delete
	SELECT * FROM emp_test2;

SELECT * FROM emp_delete ORDER BY emp_name;

-- code 10-26: DELETE DUPLICATED DATA
-- if we use the duplicated value, sql delete the all duplicated data.
-- it must to be write like this
DELETE FROM emp_delete
	WHERE emp_name = 'Chamber'
    ORDER BY emp_no DESC 		-- higher emp_no row will be deleted.
    LIMIT 1;					-- delete just 1 row

SELECT * FROM emp_delete WHERE emp_name = 'Chamber' ORDER BY emp_name; 		-- one lefts among two rows.



/*- DELETE coincidently in multiple tables -*/

/* structure 1
DELETE table_name1, table_name2, ...					<- delete!
	FROM table_name1 alias1, talbe_name2 alias2,...		<- reference
    WHERE condition;
*/

-- code 10-27: create sample table more
CREATE TABLE emp_delete2 AS
SELECT *
FROM emp_test2;

ALTER TABLE emp_delete2
	ADD CONSTRAINT PRIMARY KEY (emp_no);

SELECT * FROM emp_delete2;

-- code 10-28: delete data in two tables, at once!
-- if same emp_no, delete each other.
DELETE a, b
	FROM emp_delete a, emp_delete2 b		-- '=FROM emp_delete a INNER JOIN emp_delete2 b'
    WHERE a.emp_no = b.emp_no;

SELECT * FROM emp_delete;
/* no rows */
SELECT * FROM emp_delete2;
/* '1019','Chamber','2022-02-15','4000' */		-- In 'emp_delete', this was deleted when 'code 10-26'


/* structure 2
DELETE FROM alias1, alias2, ...								<- delete!
	USING table_name1 alias1, talbe_name2 alias2,...		<- reference
    WHERE condition;
*/

-- code 10-29: rollback the tables... 
DELETE FROM emp_delete2;

INSERT INTO emp_delete
SELECT *
FROM emp_test2
WHERE emp_no<>1019;

INSERT INTO emp_delete2
SELECT *
FROM emp_test2;

SELECT * FROM emp_delete;
/*
'1000','Zett','2021-10-31',NULL
'1001','Phoenix','2022-01-01','1000'
'1002','Neon','2022-01-03',NULL
'1003','Sky','2022-01-18','2000'
'1005','Omen','2022-01-29','1800'
'1006','Breach','2022-02-01','2100'
'1007','Viper','2022-02-14','5000'
'1008','Sage','2022-02-14','3800'
'1009','Chamber','2022-02-15','4000'
'1018','Sage','2022-02-14','3800'
*/
SELECT * FROM emp_delete2;
/*
'1000','Zett','2021-10-31',NULL
'1001','Phoenix','2022-01-01','1000'
'1002','Neon','2022-01-03',NULL
'1003','Sky','2022-01-18','2000'
'1005','Omen','2022-01-29','1800'
'1006','Breach','2022-02-01','2100'
'1007','Viper','2022-02-14','5000'
'1008','Sage','2022-02-14','3800'
'1009','Chamber','2022-02-15','4000'
'1018','Sage','2022-02-14','3800'
'1019','Chamber','2022-02-15','4000'
*/

-- code 10-30: only delete in b.
DELETE FROM b
	USING emp_delete a, emp_delete2 b		-- '=USING emp_delete a INNER JOIN emp_delete2 b'
    WHERE a.emp_no = b.emp_no;

SELECT * FROM emp_delete;
/* all data is alive */
SELECT * FROM emp_delete2;
/* '1019','Chamber','2022-02-15','4000' */


/* p.371 quiz : in emp_delete, delete name '플랑크', and delete lower emp_no. */
