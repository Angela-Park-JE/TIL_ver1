/**- Titanic analysis project -**/
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


-- p. 482 quiz : Get survived and dead men's number by `embarked` port.
SELECT embarked, survived, COUNT(*) counts
FROM TITANIC
GROUP BY 1, 2
ORDER BY 1, 2;



/* SELF CHECK */

-- 1. NULL checking in table 'COVID19_DATA' refer to code12-8.

-- mine, answer: checking with Numeric Columns
WITH null_check1 AS
	( -- sum of numeric columns 
    SELECT cases + deaths + icu_patients + hosp_patients + tests + reproduction_rate + new_vaccinations + stringency_index AS plus_col
    FROM COVID19_DATA
    ),
    null_check2 AS
    ( -- Null or Not Null results
    SELECT CASE WHEN plus_col IS NULL THEN 'NULL' ELSE 'NOT NULL' END chk
    FROM null_check1
    )
SELECT chk, COUNT(*)
FROM null_check2
GROUP BY chk;


-- 2. survived and dead men's percentage by embarked port in table `TITANIC`

-- mine:
WITH CTE1 AS
	(
	SELECT embarked, survived, COUNT(*) counts
	FROM TITANIC
	GROUP BY 1, 2
	ORDER BY 1, 2
	)

SELECT embarked, survived, counts, ROUND(counts/(SUM(counts) OVER (PARTITION BY embarked)) * 100, 2) percentage
FROM CTE1;

-- anwser: it could be summed at once.
SELECT embarked, survived, COUNT(*), 
	   COUNT(*)/( SUM(COUNT(*)) OVER (PARTITION BY embarked) ) percentage
FROM TITANIC
GROUP BY embarked, survived
ORDER BY embarked, survived;


-- 3. Vaccinating was begin since 2020-12.
-- Compare the monthly cases and vaccination in 2020-10 ~ 2021-02, 
-- and analyze whether the new cases were decreased or increased among Vaccination top 10.

-- mine: 접종탑10 + 월별확진과 백신접종 정보 => LAG() 사용하여 백신접종이 시작된 뒤로 전달에 비해 늘었는지 줄었는지 구하기
WITH topvacc AS
	( -- top 10 vaccinated nations
    SELECT countrycode, SUM(new_vaccinations)
    FROM COVID19_DATA
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10
    ),
     mthvacc AS
     ( -- monthly vaccination and cases 
     SELECT EXTRACT(YEAR_MONTH FROM c.issue_date) months, c.countrycode, SUM(c.cases) new_cases, SUM(c.new_vaccinations) new_vaccinations
	 FROM COVID19_DATA c, topvacc cte1
	 WHERE 1 = 1
		   AND c.countrycode = cte1.countrycode
		   AND EXTRACT(YEAR_MONTH FROM c.issue_date) >= (SELECT MIN(EXTRACT(YEAR_MONTH FROM issue_date)) FROM COVID19_DATA WHERE new_vaccinations > 0) -- start of vaccination
	 GROUP BY 1, 2
	 ORDER BY 2, 1
     )
     
SELECT EXTRACT(YEAR_MONTH FROM c.issue_date) months, c.countrycode, cte2.new_cases, cte2.new_vaccinations,
	   CASE WHEN (LAG(cte2.new_vacc) OVER (PARTITION BY c.countrycode) != 0) 
			 AND (LAG(cte2.new_cases) OVER (PARTITION BY c.countrycode) != 0) < new_cases 
			THEN 'decreased' 
            ELSE NULL END fluctuation
FROM COVID19_DATA c, mthvacc cte2
WHERE 1 = 1
	  AND c.countrycode = cte2.countrycode
	  AND EXTRACT(YEAR_MONTH FROM c.issue_date) >= 202010
GROUP BY 1, 2
ORDER BY 2, 1;


Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use 
near '!= 0) AND (lag(new_cases, 1) < new_cases)     THEN 'decreased'              ELSE' at line 21

Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use 
near ')     THEN 'decreased'              ELSE NULL END fluctuation FROM COVID19_DATA ' at line 21
Error Code: 1054. Unknown column 'new_vacc' in 'field list'

