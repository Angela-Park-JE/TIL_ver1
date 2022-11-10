/* SELF CHECK in Chapter 12 */

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

-- mine: 접종 top10 CTE + 월별 확진과 백신접종 정보 => LAG() 사용하여 백신접종이 시작된 뒤로 전달에 비해 늘었는지 줄었는지 구하기
-- first, I get the top vaccination countries (CTE `TOPVACC`)
-- and I got the amount of cases and vaccinations after starting vaccination

-- part of CTE
WITH TOPVACC AS
	( -- top 10 vaccinated nations
    SELECT countrycode, SUM(new_vaccinations)
    FROM COVID19_DATA
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10
    ),
     MONTHLYVACC AS
     ( -- monthly vaccination and cases : 
	   -- I get the exact 'vaccination starting date' from the dataset directly, not using the given date(2020-12) from the quiz.
     SELECT EXTRACT(YEAR_MONTH FROM c.issue_date) months, c.countrycode, SUM(c.cases) new_cases, SUM(c.new_vaccinations) new_vaccinations
	 FROM COVID19_DATA c, TOPVACC cte1
	 WHERE 1 = 1
	   AND c.countrycode = cte1.countrycode
	   AND EXTRACT(YEAR_MONTH FROM c.issue_date) >= (SELECT MIN(EXTRACT(YEAR_MONTH FROM issue_date)) FROM COVID19_DATA WHERE new_vaccinations > 0) -- start of vaccination
	 GROUP BY 1, 2
	 ORDER BY 2, 1
     )

-- but the quiz require that the data since 2020-10, not the vaccination starting month(2020-12).
-- so I got the data after 2020-10.

WITH TOPVACC AS
	( -- top 10 vaccinated nations
    SELECT countrycode, SUM(new_vaccinations)
    FROM COVID19_DATA
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10
    ),
     MONTHLYVACC AS
     ( -- monthly vaccination and cases
     SELECT EXTRACT(YEAR_MONTH FROM c.issue_date) months, c.countrycode, 
			SUM(c.cases) new_cases, 
            LAG(SUM(c.cases)) OVER (PARTITION BY c.countrycode ORDER BY EXTRACT(YEAR_MONTH FROM c.issue_date)) pre_month_new_cases,
            SUM(c.new_vaccinations) new_vaccinations,
            LAG(SUM(c.new_vaccinations)) OVER (PARTITION BY c.countrycode ORDER BY EXTRACT(YEAR_MONTH FROM c.issue_date)) pre_month_vaccination
	 FROM COVID19_DATA c, TOPVACC cte1
	 WHERE 1 = 1
	   AND c.countrycode = cte1.countrycode
	   AND EXTRACT(YEAR_MONTH FROM c.issue_date) >= 202010
	 GROUP BY 1, 2
	 ORDER BY 2, 1
     )

SELECT c.countryname, cte2.months, cte2.new_cases, cte2.pre_month_new_cases, cte2.new_vaccinations,
		-- 'Increased' or 'Decreased' state column
	   CASE WHEN cte2.new_vaccinations >0 AND cte2.new_cases >= cte2.pre_month_new_cases THEN 'Increased' 
			WHEN cte2.new_vaccinations >0 AND cte2.new_cases < cte2.pre_month_new_cases THEN 'Decreased'
			ELSE NULL END case_state
FROM MONTHLYVACC cte2 JOIN COVID19_COUNTRY c ON cte2.countrycode = c.countrycode
ORDER BY 1, 2;


-- answer: doesn't care about the increasing or decreasing state, just the case sum after vaccination>0
-- In the main query, date format and the SUM of cases/vaccinations.
-- The first subquery (`EXISTS ~`) makes the main query choose all countries in the second subquery(`table alias c`)'s results.

SELECT b.countryname, 
	   DATE_FORMAT(a.issue_date, '%Y%M') months,
       SUM(a.cases) case_num,
       SUM(a.new_vaccinations) vaccine_num
FROM COVID19_DATA a INNER JOIN COVID19_COUNTRY b ON a.countrycode = b.countrycode
WHERE a.issue_date >= '2020-10-01'
  AND EXISTS (SELECT 1
				FROM
					  (SELECT countrycode, SUM(new_vaccinations) 
						FROM COVID19_DATA c 
					   WHERE new_vaccinations > 0
					   GROUP BY 1 ORDER BY 2 DESC LIMIT 10		-- TOP VACCINATION COUNTRIES
					  ) c
				WHERE a.countrycode = c.countrycode)
GROUP BY 1, 2;
		
