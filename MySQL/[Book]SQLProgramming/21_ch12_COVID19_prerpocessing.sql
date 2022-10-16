/** COVID-19 analysis project **/


/* data insert */

USE practice;

-- country info
CREATE TABLE covid19_country
(
	COUNTRYCODE			VARCHAR(10) NOT NULL,
    COUNTRYNAME			VARCHAR(80) NOT NULL,
    CONTINENT			VARCHAR(50),
    POPULATION 			DOUBLE,
    POPULATION_DENSITY  DOUBLE,
    MEDIAN_AGE 			DOUBLE,
    AGED_65_OLDER 		DOUBLE,
    AGED_70_OLDER 		DOUBLE,
    HOSPITAL_BEDS_PER_THOUSAND INT,
    PRIMARY KEY (countrycode)
);

CREATE TABLE covid19_data
(
	COUNTRYCODE 		VARCHAR(80) NOT NULL,
    ISSUE_DATE 			DATE		NOT NULL,
    CASES 				INT,
    NEW_CASES_PER_MILLION DOUBLE,
    DEATHS 				INT,
    ICU_PATIENTS		INT,
    HOSP_PATIENTS		INT,
    TESTS				INT,
    REPRODUCTION_RATE	DOUBLE,
    NEW_VACCINATIONS	INT,
    STRINGENCY_INDEX 	DOUBLE,
    PRIMARY KEY (countrycode, issue_date)
);

-- insert files 

SELECT COUNT(*)
FROM COVID19_COUNTRY; -- 215

SELECT COUNT(*)
FROM COVID19_data;  -- 71957



/* I. DATA CLEANSING */
-- null to zero in INT column
-- string data consisting

-- 1. DELETE data which is useless

-- code 12-5 : countrycode starting with 'OWID', it's aggregated by OWID.
SELECT COUNTRYCODE, COUNTRYNAME
FROM COVID19_COUNTRY
WHERE COUNTRYCODE LIKE 'OWID%'
ORDER BY 1;							-- 11 rows returned
-- code 12-6 : 'OWID%' data they have to be deleted.
DELETE FROM COVID19_COUNTRY
WHERE COUNTRYCODE LIKE 'OWID%';		-- 11 rows affected
DELETE FROM COVID19_DATA
WHERE COUNTRYCODE LIKE 'OWID%';		-- 3923 rows affected

-- 2. NULL to 0 in INT column
-- code 12-7 : update the database 
UPDATE COVID19_COUNTRY
	SET population				= IFNULL(population, 0),
		population_density 		= IFNULL(population_density, 0),
        median_age				= IFNULL(median_age, 0),
        aged_65_older			= IFNULL(aged_65_older, 0),
        aged_70_older 			= IFNULL(aged_70_older, 0),
        hospital_beds_per_thousand = IFNULL(hospital_beds_per_thousand, 0); -- 46 rows changed
        
/* Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect. 
-- AND I did a solution. : set sql_safe_updates=0; */

UPDATE COVID19_DATA
	SET cases 					= IFNULL(cases, 0),
		new_cases_per_million	= IFNULL(new_cases_per_million, 0),
        deaths					= IFNULL(deaths, 0),
        icu_patients			= IFNULL(icu_patients, 0),
        hosp_patients			= IFNULL(hosp_patients, 0),
        tests					= IFNULL(tests, 0),
        reproduction_rate		= IFNULL(reproduction_rate, 0),
        new_vaccinations		= IFNULL(new_vaccinations, 0),
        stringency_index 		= IFNULL(stringency_index, 0);				-- 67204 rows changed

-- = UPDATE SET cases = 0 WHERE cases IS NULL 

-- code 12-8 : NULL CHECKING
-- If calculating with NULL, the results is NULL. So use '+'. SUM() can't be used because it calculates except NULL.
WITH null_check1 AS
	(SELECT population + population_density + median_age + aged_65_older + aged_70_older + hospital_beds_per_thousand AS plus_col
    FROM COVID19_COUNTRY
    ),
    null_check2 AS
    (SELECT CASE WHEN plus_col IS NULL THEN 'NULL' ELSE 'NOT NULL' END chk
    FROM null_check1
    )
SELECT chk, COUNT(*)
FROM null_check2
GROUP BY chk;
