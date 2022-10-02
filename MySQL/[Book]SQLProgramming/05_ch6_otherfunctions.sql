/*- Other FUNCTIONS -*/

/*- converting type functions -*/

-- CAST(expr AS type) : convert `expr` as `type`
-- = CONVERT(expr, type)
SELECT CAST(10 AS CHAR),					-- : 10
	   CAST('-10' AS SIGNED),				-- : -10
       CAST('100.2131' AS DECIMAL),			-- : 100
       CAST('100.2131' AS DECIMAL(6,4)),	-- : 99.9999
       CAST('100.2131' AS DOUBLE),			-- : 100.2131
       CAST('100.2131' AS FLOAT(5)),		-- : 100.213
       CAST('21-10-31' AS DATE),			-- : 2021-10-31
       CAST('2021-10-31' AS DATETIME);		-- : 2021-10-31 00:00:00
/*-- types:
CHAR([n]) : character type
SIGNED : integer type
DECIMAL[(M[, D])] : decimal type, m.d
DOUBLE : 
FLOAT[(p)] : float type
DATE : date type
DATETIME : date with time type 
--*/


/*- flow control functions -*/

-- IF(expr1, expr2, expr3) : if `expr1` is true return `expr2`, or return `expr3`.
SELECT IF(2>1, 1, 0),							-- : 1
	   IF(2<1, 1, 0),							-- : 0
       IF('A'='a', 'SAME', 'NOT SAME');			-- : SAME

-- IFNULL(expr1, expr2) : if `expr1` is not null return expr1, or return `expr2`.  
-- null with calculation is null.
SELECT IFNULL(1, 0),							-- : 1
	   IFNULL(null*3, 0);						-- : 0

-- NULLIF(expr1, expr2) : if `expr1` = `expr2` is true return null, or return `expr1`.
SELECT NULLIF(1, 1),							-- : null
	   NULLIF(1, 0),							-- : 1
       NULLIF(null, null*3);					-- : null

-- CASE
-- CASE is not function, it's kinda calculator. So in some DBMS, it's classified to expressions.
-- (1) CASE value WHEN compare_value1 THEN result1 WHEN compare_value2 THEN result2 ... ELSE result END (AS alias);
-- (2) CASE WHEN condition1 THEN result1 WHEN condition2 THEN result2 ... ELSE result END (AS alias);
-- You can't write with condition(like BETWEEN) WHEN use(1).
-- `ELSE` can be dropped.
SELECT CASE 1 WHEN 0 THEN '1=0?' WHEN 1 THEN '1=1!' END CASE1,										-- : 1=1!
	   CASE 9 WHEN 0 THEN 'A' WHEN 1 THEN 'B' ELSE 'None' END CASE2,								-- : None
       CASE WHEN 25 BETWEEN 10 AND 20 THEN '10~20' WHEN 25 BETWEEN 20 AND 30 THEN '20~30' END CASE3;-- : 20~30



/*- OTHERS -*/

-- SLEEP(seconds) : temporarily stop the query during the signed seconds and return 0 in the column.
SELECT sysdate(), SLEEP(5), sysdate();		-- : 2022-10-02 21:46:39, 0, 2022-10-02 21:46:44

-- DATABASE(), SCHEMA(), USER() : return the database or schema and user name which are being used.
SELECT DATABASE(), SCHEMA(), USER();		-- : sakila, sakila, root@localhost

