/** COVID-19 analysis project **/

/* Data analysis */

-- 1. TOP 10 country by death in 2020
-- code12-9 :
SELECT c.countryname, SUM(d.deaths) death_num, SUM(d.cases) case_num
FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode = c.countrycode
WHERE YEAR(d.issue_date) = 2020
GROUP BY c.countryname
ORDER BY 2 DESC 
LIMIT 10;

-- 2. death and cases per population in 2020
-- mine : death/population do not work by above(12-9) SELECT column
SELECT c.countryname, 
		ROUND(death_num/c.population * 100, 5) death_per_pop_rate,
		ROUND(case_num/c.population * 100, 5) case_per_pop_rate
FROM 
	(SELECT c.countryname, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode = c.countrycode
	WHERE YEAR(d.issue_date) = 2020
	GROUP BY c.countryname
	ORDER BY 2 DESC 
    ) TB1, COVID19_COUNTRY c
WHERE TB1.countryname = c.countryname;
-- code12-10 : put the population info column in the subquery, and ORDER BY death and cases, and LIMIT 10
SELECT countryname, death_num, case_num, population, population_density,
		ROUND(death_num/population * 100, 5) death_per_pop_rate,
		ROUND(case_num/population * 100, 5) case_per_pop_rate
FROM 
	(SELECT c.countryname, c.population, c.population_density, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode = c.countrycode
	WHERE YEAR(d.issue_date) = 2020
	GROUP BY c.countryname, c.population, c.population_density
	ORDER BY 4 DESC 
    LIMIT 10
    ) TB1
ORDER BY 6 DESC, 7 DESC;
/*
# countryname, death_num, case_num, population, population_density, death_per_pop_rate, case_per_pop_rate
'Italy', '74159', '2107166', '60461828', '205.859', '0.12265', '3.48512'
'Spain', '50837', '1928265', '46754783', '93.105', '0.10873', '4.12421'
'United Kingdom', '73622', '2496235', '67886004', '272.898', '0.10845', '3.6771'
'United States', '351817', '20061902', '331002647', '35.608', '0.10629', '6.06095'
'France', '64759', '2677666', '65273512', '122.578', '0.09921', '4.10222'
'Mexico', '125807', '1426094', '128932753', '66.444', '0.09758', '1.10608'
'Brazil', '194949', '7675973', '212559409', '25.04', '0.09172', '3.61121'
'Iran', '55223', '1225142', '83992953', '49.831', '0.06575', '1.45862'
'Russia', '56271', '3127347', '145934460', '8.823', '0.03856', '2.14298'
'India', '148738', '10266674', '1380004385', '450.419', '0.01078', '0.74396'
*/


-- 3. Monthly deaths and cases in Korea occured in all date ranges
-- code12-11 :
SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(deaths), SUM(cases)
FROM COVID19_DATA d
WHERE countrycode = 'KOR'
GROUP BY 1
ORDER BY 1;
-- code12-12 : with subtotal
SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(deaths), SUM(cases)
FROM COVID19_DATA d
WHERE countrycode = 'KOR'
GROUP BY 1 WITH ROLLUP
ORDER BY 1;
-- code 12-13 : `months` to column
WITH raw_data1 AS
	(
    SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(deaths) death_num, SUM(cases) case_num
	FROM COVID19_DATA d
	WHERE countrycode = 'KOR'
	GROUP BY 1
	ORDER BY 1
    )

SELECT CASE WHEN months = 202001 THEN case_num ELSE 0 END "202001",
	   CASE WHEN months = 202002 THEN case_num ELSE 0 END "202002",
       CASE WHEN months = 202003 THEN case_num ELSE 0 END "202003",
       CASE WHEN months = 202004 THEN case_num ELSE 0 END "202004",
       CASE WHEN months = 202005 THEN case_num ELSE 0 END "202005",
       CASE WHEN months = 202006 THEN case_num ELSE 0 END "202006",
       CASE WHEN months = 202007 THEN case_num ELSE 0 END "202007",
       CASE WHEN months = 202008 THEN case_num ELSE 0 END "202008",
       CASE WHEN months = 202009 THEN case_num ELSE 0 END "202009",
       CASE WHEN months = 202010 THEN case_num ELSE 0 END "202010",
       CASE WHEN months = 202011 THEN case_num ELSE 0 END "202011",
       CASE WHEN months = 202012 THEN case_num ELSE 0 END "202012",
       CASE WHEN months = 202101 THEN case_num ELSE 0 END "202101",
       CASE WHEN months = 202102 THEN case_num ELSE 0 END "202102"
FROM raw_data1;
/*
# 202001, 202002, 202003, 202004, 202005, 202006, 202007, 202008, 202009, 202010, 202011, 202012, 202101, 202102
'10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '3139', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '6636', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '988', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '729', '0', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '1347', '0', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '1486', '0', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '5846', '0', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '3707', '0', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '0', '2746', '0', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '8017', '0', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '27117', '0', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '16739', '0'
'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '11523'
*/
-- code12-14 : in 1 row from code12-12 (like code12-13 query)
WITH raw_data1 AS
	(
    SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(deaths) death_num, SUM(cases) case_num
	FROM COVID19_DATA d
	WHERE countrycode = 'KOR'
	GROUP BY 1
	ORDER BY 1
    )

SELECT SUM(CASE WHEN months = 202001 THEN case_num ELSE 0 END) "202001",
	   SUM(CASE WHEN months = 202002 THEN case_num ELSE 0 END) "202002",
       SUM(CASE WHEN months = 202003 THEN case_num ELSE 0 END) "202003",
       SUM(CASE WHEN months = 202004 THEN case_num ELSE 0 END) "202004",
       SUM(CASE WHEN months = 202005 THEN case_num ELSE 0 END) "202005",
       SUM(CASE WHEN months = 202006 THEN case_num ELSE 0 END) "202006",
       SUM(CASE WHEN months = 202007 THEN case_num ELSE 0 END) "202007",
       SUM(CASE WHEN months = 202008 THEN case_num ELSE 0 END) "202008",
       SUM(CASE WHEN months = 202009 THEN case_num ELSE 0 END) "202009",
       SUM(CASE WHEN months = 202010 THEN case_num ELSE 0 END) "202010",
       SUM(CASE WHEN months = 202011 THEN case_num ELSE 0 END) "202011",
       SUM(CASE WHEN months = 202012 THEN case_num ELSE 0 END) "202012",
       SUM(CASE WHEN months = 202101 THEN case_num ELSE 0 END) "202101",
       SUM(CASE WHEN months = 202102 THEN case_num ELSE 0 END) "202102"
FROM raw_data1;
/*
# 202001, 202002, 202003, 202004, 202005, 202006, 202007, 202008, 202009, 202010, 202011, 202012, 202101, 202102
'10', '3139', '6636', '988', '729', '1347', '1486', '5846', '3707', '2746', '8017', '27117', '16739', '11523'
*/

-- 4. Monthly deaths and cases by country
-- mine : ...
SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, c.countryname, SUM(d.deaths) death_num, SUM(d.cases) case_num
FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode=c.countrycode
GROUP BY 1, 2
ORDER BY 1;
-- code 12-15:
-- montly country death and cases num in monthly row
SELECT c.countryname, EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode=c.countrycode
GROUP BY 1, 2;
WITH raw_data1 AS
	(
    SELECT c.countryname, EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode=c.countrycode
	GROUP BY 1, 2
    )

SELECT countryname, '1. Cases' division,
	   SUM(CASE WHEN months = 202001 THEN case_num ELSE 0 END) "202001",
	   SUM(CASE WHEN months = 202002 THEN case_num ELSE 0 END) "202002",
       SUM(CASE WHEN months = 202003 THEN case_num ELSE 0 END) "202003",
       SUM(CASE WHEN months = 202004 THEN case_num ELSE 0 END) "202004",
       SUM(CASE WHEN months = 202005 THEN case_num ELSE 0 END) "202005",
       SUM(CASE WHEN months = 202006 THEN case_num ELSE 0 END) "202006",
       SUM(CASE WHEN months = 202007 THEN case_num ELSE 0 END) "202007",
       SUM(CASE WHEN months = 202008 THEN case_num ELSE 0 END) "202008",
       SUM(CASE WHEN months = 202009 THEN case_num ELSE 0 END) "202009",
       SUM(CASE WHEN months = 202010 THEN case_num ELSE 0 END) "202010",
       SUM(CASE WHEN months = 202011 THEN case_num ELSE 0 END) "202011",
       SUM(CASE WHEN months = 202012 THEN case_num ELSE 0 END) "202012",
       SUM(CASE WHEN months = 202101 THEN case_num ELSE 0 END) "202101",
       SUM(CASE WHEN months = 202102 THEN case_num ELSE 0 END) "202102"
FROM raw_data1
GROUP BY 1, 2
UNION ALL
SELECT countryname, '2. Deaths' division,
	   SUM(CASE WHEN months = 202001 THEN death_num ELSE 0 END) "202001",
	   SUM(CASE WHEN months = 202002 THEN death_num ELSE 0 END) "202002",
       SUM(CASE WHEN months = 202003 THEN death_num ELSE 0 END) "202003",
       SUM(CASE WHEN months = 202004 THEN death_num ELSE 0 END) "202004",
       SUM(CASE WHEN months = 202005 THEN death_num ELSE 0 END) "202005",
       SUM(CASE WHEN months = 202006 THEN death_num ELSE 0 END) "202006",
       SUM(CASE WHEN months = 202007 THEN death_num ELSE 0 END) "202007",
       SUM(CASE WHEN months = 202008 THEN death_num ELSE 0 END) "202008",
       SUM(CASE WHEN months = 202009 THEN death_num ELSE 0 END) "202009",
       SUM(CASE WHEN months = 202010 THEN death_num ELSE 0 END) "202010",
       SUM(CASE WHEN months = 202011 THEN death_num ELSE 0 END) "202011",
       SUM(CASE WHEN months = 202012 THEN death_num ELSE 0 END) "202012",
       SUM(CASE WHEN months = 202101 THEN death_num ELSE 0 END) "202101",
       SUM(CASE WHEN months = 202102 THEN death_num ELSE 0 END) "202102"
FROM raw_data1
GROUP BY 1, 2
ORDER BY 1, 2;

-- if want to look specific country, save this as a view.
CREATE OR REPLACE VIEW covid19_summary1_v AS
WITH raw_data1 AS
	(
    SELECT c.countryname, EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_COUNTRY c ON d.countrycode=c.countrycode
	GROUP BY 1, 2
    )

SELECT countryname, '1. Cases' division,
	   SUM(CASE WHEN months = 202001 THEN case_num ELSE 0 END) "202001",
	   SUM(CASE WHEN months = 202002 THEN case_num ELSE 0 END) "202002",
       SUM(CASE WHEN months = 202003 THEN case_num ELSE 0 END) "202003",
       SUM(CASE WHEN months = 202004 THEN case_num ELSE 0 END) "202004",
       SUM(CASE WHEN months = 202005 THEN case_num ELSE 0 END) "202005",
       SUM(CASE WHEN months = 202006 THEN case_num ELSE 0 END) "202006",
       SUM(CASE WHEN months = 202007 THEN case_num ELSE 0 END) "202007",
       SUM(CASE WHEN months = 202008 THEN case_num ELSE 0 END) "202008",
       SUM(CASE WHEN months = 202009 THEN case_num ELSE 0 END) "202009",
       SUM(CASE WHEN months = 202010 THEN case_num ELSE 0 END) "202010",
       SUM(CASE WHEN months = 202011 THEN case_num ELSE 0 END) "202011",
       SUM(CASE WHEN months = 202012 THEN case_num ELSE 0 END) "202012",
       SUM(CASE WHEN months = 202101 THEN case_num ELSE 0 END) "202101",
       SUM(CASE WHEN months = 202102 THEN case_num ELSE 0 END) "202102"
FROM raw_data1
GROUP BY 1, 2
UNION ALL
SELECT countryname, '2. Deaths' division,
	   SUM(CASE WHEN months = 202001 THEN death_num ELSE 0 END) "202001",
	   SUM(CASE WHEN months = 202002 THEN death_num ELSE 0 END) "202002",
       SUM(CASE WHEN months = 202003 THEN death_num ELSE 0 END) "202003",
       SUM(CASE WHEN months = 202004 THEN death_num ELSE 0 END) "202004",
       SUM(CASE WHEN months = 202005 THEN death_num ELSE 0 END) "202005",
       SUM(CASE WHEN months = 202006 THEN death_num ELSE 0 END) "202006",
       SUM(CASE WHEN months = 202007 THEN death_num ELSE 0 END) "202007",
       SUM(CASE WHEN months = 202008 THEN death_num ELSE 0 END) "202008",
       SUM(CASE WHEN months = 202009 THEN death_num ELSE 0 END) "202009",
       SUM(CASE WHEN months = 202010 THEN death_num ELSE 0 END) "202010",
       SUM(CASE WHEN months = 202011 THEN death_num ELSE 0 END) "202011",
       SUM(CASE WHEN months = 202012 THEN death_num ELSE 0 END) "202012",
       SUM(CASE WHEN months = 202101 THEN death_num ELSE 0 END) "202101",
       SUM(CASE WHEN months = 202102 THEN death_num ELSE 0 END) "202102"
FROM raw_data1
GROUP BY 1, 2
ORDER BY 1, 2;

-- USA
SELECT *
FROM covid19_summary1_v
WHERE countryname = 'United States';
/*
# countryname, division, 202001, 202002, 202003, 202004, 202005, 202006, 202007, 202008, 202009, 202010, 202011, 202012, 202101, 202102
'United States', '1. Cases', '7', '17', '192276', '888718', '717694', '843368', '1924850', '1458662', '1206239', '1926939', '4496449', '6406683', '6125132', '2391465'
'United States', '2. Deaths', '0', '1', '5369', '60859', '41593', '19760', '26514', '29623', '23371', '24508', '39229', '80990', '96746', '64728'
*/


-- 5. accumulated monthly death and cases of Korea
-- mine : not work
WITH raw_data1 AS
	(
	SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA 
	WHERE countrycode = 'KOR'
	GROUP BY 1
    )

SELECT months, death_num, case_num,
	death_num OVER (ORDER BY months ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) accumulated_death,
    case_num OVER (PARTITION BY months ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) accumulated_case
FROM raw_data1;
-- code12-17 : 
WITH raw_data1 AS
	(
	SELECT EXTRACT(YEAR_MONTH FROM issue_date) months, SUM(deaths) death_num, SUM(cases) case_num
	FROM COVID19_DATA 
	WHERE countrycode = 'KOR'
	GROUP BY 1
    )

SELECT months, death_num, case_num,
	SUM(death_num) OVER (ORDER BY months) accumulated_death,
    SUM(case_num) OVER (ORDER BY months) accumulated_case
FROM raw_data1
ORDER BY 1;



	SELECT c.countryname, EXTRACT(YEAR_MONTH FROM d.issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_country c
	GROUP BY 1, 2;
-- 6. TOP 3 country about accumulated death
USE practice;
WITH raw_data1 AS -- SUM 
	(
	SELECT c.countryname, EXTRACT(YEAR_MONTH FROM d.issue_date) months, SUM(d.deaths) death_num, SUM(d.cases) case_num
	FROM COVID19_DATA d INNER JOIN COVID19_country c
	GROUP BY 1, 2
    ),
    raw_data2 AS -- accumulated SUM
	(
    SELECT countryname, months, death_num, case_num,
	SUM(death_num) OVER (PARTITION BY countryname ORDER BY months) accumulated_death,
    SUM(case_num) OVER (PARTITION BY countryname ORDER BY months) accumulated_case
	FROM raw_data1
	)
SELECT countryname, months, death_num, case_num, accumulated_death, accumulated_case
FROM raw_data2
ORDER BY 4 DESC
LIMIT 3;
