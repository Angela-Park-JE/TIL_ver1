/**- TCL : transaction control language -**/
-- TCL is used in the case when we do 'INSERT', 'UPDATE', 'DELETE'.

/*- COMMIT -*/
-- it means above queries worked right, so save the works(changes).
/*- ROLLBACK -*/
-- it means above queries worked wrong, so restore the works.


/* Autocommit mode */
-- this makes all works be reflected into database. 
-- 1: O , 0: X
-- if its value is 0, we will have to write 'COMMIT' explicitly.
-- this setting is maintained until the end of the session.
-- if want to off automaticaly setting, Preference-SQL Execution-New connections use auto commit mode [check]


-- code 10-31: setting
-- autocommit check
SELECT @@autocommit;		-- it was 1,
-- autocommit off
SET @@autocommit = 0;
-- check again
SELECT @@autocommit;		-- now it is 0.


/* USE TCL : CASE WHEN Autocommit mode off */
-- CREATE TABLE AS : this is DDL, so don't need to use 'COMMIT', 'ROLLBACK'.
-- if you use 'COMMIT' or 'ROLLBACK', the transaction is finished. 
-- so after the 'COMMIT' or 'ROLLBACK', new transactions(INSERT, UPDATE, DELETE) makes a start of session.


-- code 10-32: sample table
CREATE TABLE emp_tran1 AS
	SELECT *
    FROM emp_test;
ALTER TABLE emp_tran1
	ADD CONSTRAINT PRIMARY KEY (emp_no);
    
CREATE TABLE emp_tran2 AS
	SELECT *
    FROM emp_test;
ALTER TABLE emp_tran2
	ADD CONSTRAINT PRIMARY KEY (emp_no);

-- code 10-33: DELETE and check
DELETE FROM emp_tran1;
DELETE FROM emp_tran2;			-- two 'DELETE' would be one transaction, 
ROLLBACK;						-- and restored.

SELECT * FROM emp_tran1;
SELECT * FROM emp_tran2; 		-- 1, 2 all of them is restored.

-- code 10-34: DELETE and commmit, and check
DELETE FROM emp_tran1;
COMMIT;

DELETE FROM emp_tran2;
ROLLBACK;

SELECT * FROM emp_tran1;		-- nothing is left
SELECT * FROM emp_tran2; 		-- restored.

/*- USE TCL : CASE WHEN Autocommit mode on -*/
-- there a solution that you can handle a transaction when Autocommit mode on.
-- "explicitly" write a transaction. 

/* START TRANSACTION QUERY */
/* structure
START TRANSACTION;		-- set the start of a transaction
INSERT ;
UPDATE ;
DELETE ;
COMMIT (or ROLLBAKC);
*/

-- code 10-35: check- when turned on Autocommit
SET autocommit = 1;

INSERT INTO emp_tran1			-- empty table
SELECT * FROM emp_test;			-- Autocommit is on, so it is already saved after 'INSERT'.

ROLLBACK;						-- there's no transaction to process.

SELECT * FROM emp_tran1;		-- so all is lefted!

-- code 10-36: using 'START TRANSACTION' query when turned on Autocommit
START TRANSACTION;

DELETE FROM emp_tran1
	WHERE emp_no >= 1008;		-- in the book, 1006.

UPDATE emp_tran1
	SET salary = 0
    WHERE salary IS NULL;

ROLLBACK;						-- cancel all queries

SELECT * FROM emp_tran1;


/* SAVEPOINT QUERY */
-- 'START TRANSACTION' makes all DML into one chunk before you write TCL.
-- but you can set a savepoint to DMLs work separately!
-- you can use this after 'START TRANSACTION'.
-- if you write 'ROLLBACK TO SAVEPOINT identifier;', 
-- MySQL restores the works back to the start of a transaction, named 'identifier'.
-- [WARNING!] if you make a COMMIT, all previous DML is saved. CAN'T go back to the savepoint.

/* structure
SAVEPOINT identifier;

INSERT/UPDATE/DELETE 
ROLLBACK TO SAVEPOINT identifier;
*/

-- code 10-37:
START TRANSACTION;

SAVEPOINT A;					-- transaction point A start

DELETE FROM emp_tran1
	WHERE salary IS NULL;

SAVEPOINT B;					-- transaction point B start

DELETE FROM emp_tran1
	WHERE emp_name = 'Chamber'
    ORDER BY emp_no DESC
    LIMIT 1;

ROLLBACK TO SAVEPOINT B;

COMMIT;
SELECT * FROM emp_tran1;		-- no NULL, and 'Chamber' rows are alive.

-- if we rollback to savepoint A?
ROLLBACK TO SAVEPOINT A;
-- it already saved. because of 'COMMIT'.


/* p.385 quiz: scenario */
-- mine:
START TRANSACTION;

DELETE FROM emp_tran2
	WHERE salary = 100;

ROLLBACK;

DELETE FROM emp_tran2
	WHERE salary = 1000;

SELECT * FROM emp_tran2;		-- 'Phoenix's row is deleted.

-- answer:
START TRANSACTION;

DELETE FROM emp_tran2
	WHERE salary = 100;

SELECT * FROM emp_tran2;

ROLLBACK;

