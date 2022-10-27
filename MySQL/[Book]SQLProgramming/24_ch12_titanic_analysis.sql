/** Titanic analysis project **/
-- data reference : Kaggle

/* Data Analyzing */

-- 1. survived and dead men's rate by gender 

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

-- code12-24: using FROM subquery and put `SUM() OVER (PARTITION` directly in calculating rates
SELECT gender, survived, ROUND(counts/SUM(counts) OVER (PARTITION BY gender), 2) rates
FROM (
	SELECT gender, survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY gender, survived ORDER BY 1, 2
    ) TB1;


-- 2. survived and dead men's rate by age groups
-- mine : refered only age group name(Korean and numbering)
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

-- code12-27 : just get the numbers(not rate) and processed `NULL`
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


-- 3. survived and dead men's number by age and pclass

-- mine :
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
		pclass,
		survived, COUNT(*) counts
FROM TITANIC
GROUP BY 1, 2, 3 ORDER BY 1, 2, 3;

-- code12-29 : many rows make looking complex, so pivoting is needed.
-- make `pclass` to a column.
WITH RAW_DATA AS
	(SELECT CASE WHEN age BETWEEN 0 AND 9 THEN '1.10대 이하' 
				WHEN age BETWEEN 10 AND 19 THEN '2.10대'
				WHEN age BETWEEN 20 AND 29 THEN '3.20대'
				WHEN age BETWEEN 30 AND 39 THEN '4.30대'
				WHEN age BETWEEN 40 AND 49 THEN '5.40대'
				WHEN age BETWEEN 50 AND 59 THEN '6.50대'
				WHEN age BETWEEN 60 AND 69 THEN '7.60대'
				WHEN age>= 70 THEN '8.70대 이상'
				WHEN age IS NULL THEN '알수없음'
				END ages, 
			pclass,
			survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY 1, 2, 3 ORDER BY 1, 2, 3
    )

SELECT ages, survived, 
	SUM(CASE WHEN pclass = 1 THEN counts ELSE 0 END) first_class,
    SUM(CASE WHEN pclass = 2 THEN counts ELSE 0 END) business_class,
    SUM(CASE WHEN pclass = 3 THEN counts ELSE 0 END) economy_class
FROM RAW_DATA
GROUP BY 1, 2 ORDER BY 1, 2;

-- death is many in the economy class.
-- but I wondered about the death rate by each class's passengers number.

WITH RAW_DATA AS
	(SELECT CASE WHEN age BETWEEN 0 AND 9 THEN '1.10대 이하' 
				WHEN age BETWEEN 10 AND 19 THEN '2.10대'
				WHEN age BETWEEN 20 AND 29 THEN '3.20대'
				WHEN age BETWEEN 30 AND 39 THEN '4.30대'
				WHEN age BETWEEN 40 AND 49 THEN '5.40대'
				WHEN age BETWEEN 50 AND 59 THEN '6.50대'
				WHEN age BETWEEN 60 AND 69 THEN '7.60대'
				WHEN age>= 70 THEN '8.70대 이상'
				WHEN age IS NULL THEN '알수없음'
				END ages, 
			pclass,
			survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY 1, 2, 3 ORDER BY 1, 2, 3
    ),
    PIVOTED_DATA AS
    (SELECT ages, survived, 
		SUM(CASE WHEN pclass = 1 THEN counts ELSE 0 END) first_class,
		SUM(CASE WHEN pclass = 2 THEN counts ELSE 0 END) business_class,
		SUM(CASE WHEN pclass = 3 THEN counts ELSE 0 END) economy_class
	FROM RAW_DATA
	GROUP BY 1, 2 ORDER BY 1, 2
    )

SELECT ages, survived, 
	ROUND(first_class/SUM(first_class) OVER (PARTITION BY ages) * 100, 2) fc_rate,
    ROUND(business_class/SUM(business_class) OVER (PARTITION BY ages) * 100, 2) bc_rate,
    ROUND(economy_class/SUM(economy_class) OVER (PARTITION BY ages) * 100, 2) ec_rate
FROM PIVOTED_DATA
GROUP BY 1, 2 ORDER BY 1;
/*
# ages, survived, fc_rate, bc_rate, ec_rate
'1.10대 이하', '사망', '50.00', '9.09', '55.36'
'1.10대 이하', '생존', '50.00', '90.91', '44.64'
'2.10대', '사망', '22.73', '51.72', '68.48'
'2.10대', '생존', '77.27', '48.28', '31.52'
'3.20대', '사망', '32.69', '61.11', '75.25'
'3.20대', '생존', '67.31', '38.89', '24.75'
'4.30대', '사망', '30.56', '62.50', '73.96'
'4.30대', '생존', '69.44', '37.50', '26.04'
'5.40대', '사망', '50.00', '61.29', '88.10'
'5.40대', '생존', '50.00', '38.71', '11.90'
'6.50대', '사망', '47.83', '70.59', '100.00'
'6.50대', '생존', '52.17', '29.41', '0.00'
'7.60대', '사망', '57.14', '71.43', '75.00'
'7.60대', '생존', '42.86', '28.57', '25.00'
'8.70대 이상', '사망', '60.00', '100.00', '100.00'
'8.70대 이상', '생존', '40.00', '0.00', '0.00'
'알수없음', '사망', '58.97', '68.75', '73.08'
'알수없음', '생존', '41.03', '31.25', '26.92'
*/
-- I don't think using a good room didn't necessarily mean the survival rate of survival was good.


-- 4. survived and dead men's rate by accompaning family or not

-- mine :
SELECT accompanies, survived, counts, 
	   ROUND(counts/SUM(counts) OVER (PARTITION BY accompanies) * 100, 2) rates
FROM
	(
	SELECT CASE WHEN sibsp + parch > 0 
				THEN 'accompanied' 
                ELSE 'alone' END accompanies, 
			survived, count(*) counts
	FROM TITANIC
	GROUP BY 1, 2
	) TB1;

-- code12-30 : using CTE and all rates of each part.
WITH RAW_DATA AS
	(
    SELECT CASE WHEN sibsp + parch > 0 
				THEN 'accompanied' 
                ELSE 'alone' END accompanies, 
			survived, count(*) counts
	FROM TITANIC
	GROUP BY 1, 2
    )
SELECT accompanies, survived, counts, 
	   counts/SUM(counts) OVER (PARTITION BY accompanies) companied_rate,
       counts/SUM(counts) OVER () total_rates 			-- < here : PARTITION's object is all
FROM RAW_DATA
ORDER BY 1, 2;



-- p. 482 quiz : Get survived and dead men's number by `embarked`
SELECT
FROM 
