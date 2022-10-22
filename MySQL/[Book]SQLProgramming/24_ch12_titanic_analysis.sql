/** Titanic analysis project **/
-- data reference : Kaggle

/* Data analyzing */

-- 1. survived and dead men rate by gender 

-- code12-23: simple count for code12-24
SELECT gender, survived, COUNT(*)
FROM TITANIC
GROUP BY gender, survived ORDER BY 1, 2;
/*
# gender, survived, COUNT(*)
'남성', '사망', '734'
'남성', '생존', '109'
'여성', '사망', '81'
'여성', '생존', '385'
*/
-- mine : results same with code 12-24
WITH CTE1 AS
	(
	SELECT gender, survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY gender, survived ORDER BY 1, 2
	),
    CTE2 AS
    (
	SELECT gender, survived, counts,
		SUM(counts) OVER (PARTITION BY gender) sums_by_gender
	FROM CTE1
    )
SELECT gender, survived, (counts/sums_by_gender) rates
FROM CTE2;
/*
# gender, survived, rates
'남성', '사망', '0.8707'
'남성', '생존', '0.1293'
'여성', '사망', '0.1738'
'여성', '생존', '0.8262'
*/

-- code12-24: put in `SUM() OVER (PARTITION` directly in calculating rates
SELECT gender, survived, ROUND(counts/SUM(counts) OVER (PARTITION BY gender), 2) rates
FROM (
	SELECT gender, survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY gender, survived ORDER BY 1, 2
    ) TB1;


-- 2. 
