/**- FUNCTIONS -**/
-- If we do simpe calculate, we can write `SELECT` query without `FROM`.
-- BUT! we can not write SUM(), AVG() etc, aggregating functions. 

-- `ABS()` : absolute value
SELECT ABS(1), ABS(-1);
-- `LENGTH()` : length of string or values
SELECT LENGTH(135), length('Mysql workbench\'s interpace is really bad and syntex color is not my type.');

/*- Calculating Funtions -*/
-- it doesn't matter with 'space'
-- If I want to get a sum of numbers, I have to write them with '+', not SUM().
SELECT 3+5 + 6, 6 - 3 - 2, 8 * 2, 49/7;

-- %, MOD : remainder 
SELECT 19%2;
SELECT 19 MOD 2; 
SELECT MOD(19, 2); -- : 1

-- DIV : quotient in INTEGER
SELECT 19 DIV 2; -- : 9



/*- Mathmatic Funtions -*/

SELECT CEIL(3.5), FLOOR(3.5); -- : '4','3'

SELECT LN(100); -- what times need to multiply e to x
SELECT LOG(100); -- skip a parameter, it would be e.
SELECT LOG2(8);
SELECT LOG10(1000);

SELECT POW(3, 2), SQRT(POW(3, 2)),  SIGN(5), SIGN(-5); -- : 9, 3, 1, -1

-- ROUND(x) : rounding off the number, we can set the decimal point or cipher.
-- TRUNCATE(x, d) : cut off the rounded numbers, we *have to* set the decimal point or cipher.
SELECT ROUND(123.4567), ROUND(123.4567, 0), ROUND(123.4567, 1), ROUND(123.4567, 2), ROUND(123.4567, -1); 
-- : 123, 123, 123.5, 123.46, 120
SELECT TRUNCATE(123.4567,0), TRUNCATE(123.4567, 1), TRUNCATE(123.4567, 2), TRUNCATE(123.4567, -1); 
-- : 123, 123.4, 123.45, 120
