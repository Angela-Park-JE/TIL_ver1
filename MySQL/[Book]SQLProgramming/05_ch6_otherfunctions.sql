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
-- You can't write with condition(like BETWEEN) WHEN usage(1).
-- `ELSE` can be dropped.
SELECT CASE 1 WHEN 0 THEN '1=0?' WHEN 1 THEN '1=1!' END CASE1,										-- : 1=1!
	   CASE 9 WHEN 0 THEN 'A' WHEN 1 THEN 'B' ELSE 'None' END CASE2,								-- : None
       CASE WHEN 25 BETWEEN 10 AND 20 THEN '10~20' WHEN 25 BETWEEN 20 AND 30 THEN '20~30' END CASE3;-- : 20~30



/*- OTHERS -*/

-- SLEEP(seconds) : temporarily stop the query during the signed seconds and return 0 in the column.
SELECT sysdate(), SLEEP(5), sysdate();		-- : 2022-10-02 21:46:39, 0, 2022-10-02 21:46:44

-- DATABASE(), SCHEMA(), USER() : return the database or schema and user name which are being used.
SELECT DATABASE(), SCHEMA(), USER();		-- : sakila, sakila, root@localhost



/*- practice -*/
USE world;

SELECT code, CONCAT(name, '(', continent, ')') names, region, population
FROM country
WHERE population BETWEEN 45000000 AND 550000000;

USE practice;

SELECT years, ranks, movie_name, release_date, audience_num, ROUND(sale_amt / 100000000) AS sales
FROM box_office
WHERE year(release_date) = 2019
	AND audience_num >= 5000000;
/*
'2019','1','±ØÇÑÁ÷¾÷','2019-01-23 00:00:00','16265618','1397'
'2019','2','¾îº¥Á®½º: ¿£µå°ÔÀÓ','2019-04-24 00:00:00','13934592','1222'
'2019','3','°Ü¿ï¿Õ±¹ 2','2019-11-21 00:00:00','13369064','1116'
'2019','4','¾Ë¶óµò','2019-05-23 00:00:00','12552283','1070'
'2019','5','±â»ýÃæ','2019-05-30 00:00:00','10085275','859'
'2019','6','¿¢½ÃÆ®','2019-07-31 00:00:00','9426011','792'
'2019','7','½ºÆÄÀÌ´õ¸Ç: ÆÄ ÇÁ·Ò È¨','2019-07-02 00:00:00','8021145','690'
'2019','8','¹éµÎ»ê','2019-12-19 00:00:00','6290502','529'
'2019','10','Á¶Ä¿','2019-10-02 00:00:00','5247874','454'
'2019','9','Ä¸Æ¾ ¸¶ºí','2019-03-06 00:00:00','5802810','515'
*/

SELECT ranks, movie_name, DAYNAME(release_date), 
	CASE WHEN QUARTER(release_date) IN (1, 2) THEN '상반기' ELSE '하반기' END CASE1
FROM box_office
WHERE YEAR(release_date) = 2019
	and ranks<= 10
ORDER BY 1;
/*
'1','±ØÇÑÁ÷¾÷','Wednesday','상반기'
'2','¾îº¥Á®½º: ¿£µå°ÔÀÓ','Wednesday','상반기'
'3','°Ü¿ï¿Õ±¹ 2','Thursday','하반기'
'4','¾Ë¶óµò','Thursday','상반기'
'5','±â»ýÃæ','Thursday','상반기'
'6','¿¢½ÃÆ®','Wednesday','하반기'
'7','½ºÆÄÀÌ´õ¸Ç: ÆÄ ÇÁ·Ò È¨','Tuesday','하반기'
'8','¹éµÎ»ê','Thursday','하반기'
'9','Ä¸Æ¾ ¸¶ºí','Wednesday','상반기'
'10','Á¶Ä¿','Wednesday','하반기'
*/



-- p.221 quiz
USE world;
SELECT name, IFNULL(indepyear, '없음') as indepyear
FROM country;
