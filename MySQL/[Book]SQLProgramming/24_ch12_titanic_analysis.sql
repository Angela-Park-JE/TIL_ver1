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


-- 2. survived and dead men rate by age groups

-- mine : refered only age group name
-- I already know that id has baby ages with float data type.
WITH CTE1 AS 
	(
	SELECT CASE WHEN age < 10 THEN '1.10대 이하' 
				WHEN age>= 10 AND age<20 THEN '2.10대'
				WHEN age>= 20 AND age<30 THEN '3.20대'
				WHEN age>= 30 AND age<40 THEN '4.30대'
				WHEN age>= 40 AND age<50 THEN '5.40대'
				WHEN age>= 50 AND age<60 THEN '6.50대'
				WHEN age>= 60 AND age<70 THEN '7.60대'
				WHEN age>= 70 THEN '8.70대 이상'
				END ages, 
			survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY 1, 2 ORDER BY 1, 2
	)
SELECT ages, survived, counts, ROUND(counts/SUM(counts) OVER (PARTITION BY ages) * 100, 2) rates
FROM CTE1;

-- code12-27 : just get the numbers and processed `NULL`
-- age column has some FLOAT data (baby under-1), and there are `null`s. 
-- so `between 1 AND 9` is wrong for this case
-- and handle the `NULL` separately.
SELECT CASE WHEN age BETWEEN 0 AND 9 THEN '1.10대 이하' 
			WHEN age BETWEEN 10 AND 19 THEN '2.10대'
			WHEN age BETWEEN 20 AND 29 THEN '3.20대'
			WHEN age BETWEEN 30 AND 39 THEN '4.30대'
			WHEN age BETWEEN 40 AND 49 THEN '5.40대'
			WHEN age BETWEEN 50 AND 59 THEN '6.50대'
			WHEN age BETWEEN 60 AND 69 THEN '7.60대'
			WHEN age>= 70 THEN '8.70대 이상'
            WHEN age IS NULL THEN '알수없음'
			END ages, 
		survived, COUNT(*) counts
FROM TITANIC
GROUP BY 1, 2 ORDER BY 1, 2;
