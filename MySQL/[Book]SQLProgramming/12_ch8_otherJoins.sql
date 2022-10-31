 /**- JOIN -**/
 
-- MUST know the 'join' columns name
-- CAN 'join' more than two tables
-- MUST state the table alias'
-- MUST write the 'join' condition (stating the 'join' columns name)

-- Other joins : Natural Join, Cross Join(Cartesian Product)



/*- NATURAL JOIN -*/
-- no join condition
-- need to join columns have to be 'same name' and 'same data type' column in each tables,
-- and if it satisfied, MySQL automatically make a condition with two tables' column.
-- NATURAL | NATURAL INNER : natural inner join
-- NATURAL LEFT | NATURAL RIGHT : nataural outer join
/* structure
SELECT ...
FROM table1 [AS] alias1 NATURAL [INNER|{LEFT|RIGHT} [OUTER]] JOIN table2 [AS] alias2
WHERE ... ; */

-- case1: natural join need to have same name and data type
USE world;
SELECT a.continent, COUNT(*), COUNT(b.name)
FROM COUNTRY a NATURAL JOIN CITY b 
GROUP BY 1;
-- there's no error but it has no results. 
-- "becuase countrycode and code columns have 'different name'."

-- case2: 
SELECT *
FROM CITY a NATURAL JOIN COUNTRYLANGUAGE b;
-- they have normal join columns.
-- "if use * in SELECT, the join column comes out once."



/*- CARTESIAN PRODUCT(CROSS JOIN) -*/
-- no join condition
-- it makes automatically joins two tables
-- but the direction of joining is to make 'all possible combinations' with two tables.
/* structure : INNER JOIN without `ON`
SELECT ...
FROM table1 [AS] alias1 {INNER JOIN|CROSS JOIN} table2 [AS] alias2
WHERE ... ; */

-- case1: cartesian product makes all combinations with tables' rows so the result data is massively big.
SELECT a.continent, COUNT(*) all_, COUNT(b.name) cities
FROM COUNTRY a INNER JOIN CITY b
GROUP BY a.continent;

-- case2(p.283 quiz): can use `CROSS JOIN` (SQL Standard)
SELECT a.continent, COUNT(*) all_, COUNT(b.name) cities
FROM COUNTRY a CROSS JOIN CITY b
GROUP BY a.continent;
