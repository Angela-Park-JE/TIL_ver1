/**- UNION -**/
-- UNION the tables' data on same column (opposite direction of join)
-- UNION results of each SELECT state
-- MUST the number of columns in each SELECT state.

-- UNION [DISTINCT] : remove duplicates from result set
-- UNION ALL : not remove duplicates from result set
-- the duplicates are depend on the columns in SELECT states.
/* structure
SELECT ...
	UNION [DISTINCT|ALL]
SELECT ...
	UNION [DISTINCT|ALL]
...;	*/

-- practice: creating tables
USE mywork;
CREATE TABLE tbl1 (col1 INT, col2 VARCHAR(20));
CREATE TABLE tbl2 (col1 INT, col2 VARCHAR(20));
INSERT INTO tbl1 VALUES (1, '가'), (2, '나'), (3, '다');
INSERT INTO tbl2 VALUES (1, 'a'), (2, 'b');
SELECT * FROM tbl1;
SELECT * FROM tbl2;

-- case1: UNION [DISTINCT] : whether it is duplicates or not depends on all colums in SELECT state.
SELECT col1 FROM tbl1 
UNION
SELECT col1 FROM tbl2;
/*
'1'
'2'
'3'
*/

-- case2: multiple columns
SELECT col1, col2 FROM tbl1 
UNION
SELECT col1, col2 FROM tbl2;
/*
# col1, col2
'1', '가'
'2', '나'
'3', '다'
'1', 'a'
'2', 'b'
*/

-- case3: UNION ALL : whether it is duplicates or not, depends on all colums in SELECT state.
SELECT col1 FROM tbl1 
UNION ALL
SELECT col1 FROM tbl2;
/*
'1'
'2'
'3'
'1'
'2'
*/

-- case4: if want to order the data, you have to use '(ORDER BY {} LIMIT {row_number})'
-- error
SELECT col1, col2 FROM tbl1
	ORDER BY 1 DESC
UNION 
SELECT col1, col2 FROM tbl2; 

-- bad : not ordered despite of writing ()
(SELECT col1, col2 FROM tbl1
		ORDER BY 1 DESC)
UNION 
SELECT col1, col2 FROM tbl2; 
/*
'1','가'
'2','나'
'3','다'
'1','a'
'2','b'
*/

-- good : ORDER BY works with LIMIT
(SELECT col1, col2 FROM tbl1
		ORDER BY 1 DESC LIMIT 3)
UNION 
SELECT col1, col2 FROM tbl2; 
/*
# col1, col2
'1', '가'
'2', '나'
'3', '다'
'1', 'a'
'2', 'b'
*/


-- p.289 quiz : tbl1 all data and tbl2 col1 = 1.
-- mine
SELECT col1, col2 FROM tbl1
UNION
SELECT col1, col2 FROM tbl2 WHERE col1 = 1;
/*
'1','가'
'2','나'
'3','다'
'1','a'
*/

-- answer :
SELECT * FROM tbl1
UNION ALL 
SELECT * FROM tbl2 
	WHERE col1=1;
/*
'1','가'
'2','나'
'3','다'
'1','a'
*/
