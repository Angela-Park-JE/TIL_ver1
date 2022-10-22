USE PRACTICE;

/** Titanic analysis project **/

/* Data import */
-- data reference : Kaggle

-- 1. Create Table

-- code12-19 :
CREATE TABLE titanic_data
	(
    passengerid			INT,
    survived			INT,
    pclass				INT,
    name				VARCHAR(100),
    gender				VARCHAR(50),
    age					DOUBLE,
    sibsp				INT,
    parch				INT,
    ticket				VARCHAR(80),
    fare				DOUBLE,
    cabin				VARCHAR(50),
    embarked			VARCHAR(20),
    PRIMARY KEY (passengerid)
    )
;

-- code12-20 : insert data with `03.titanic_data_insert.sql`

-- check
SELECT *
FROM TITANIC_DATA
LIMIT 10;
/*
-- passengerid, survived, pclass, name, gender, age, sibsp, parch, ticket, fare, cabin, embarked --
1, 0, 3, Braund, Mr. Owen Harris, male, 22, 1, 0, A/5 21171, 7.25, , S
2, 1, 1, Cumings, Mrs. John Bradley (Florence Briggs Thayer), female, 38, 1, 0, PC 17599, 71.2833, C85, C
3, 1, 3, Heikkinen, Miss. Laina, female, 26, 0, 0, STON/O2. 3101282, 7.925, , S
4, 1, 1, Futrelle, Mrs. Jacques Heath (Lily May Peel), female, 35, 1, 0, 113803, 53.1, C123, S
5, 0, 3, Allen, Mr. William Henry, male, 35, 0, 0, 373450, 8.05, , S
6, 0, 3, Moran, Mr. James, male, , 0, 0, 330877, 8.4583, , Q
7, 0, 1, McCarthy, Mr. Timothy J, male, 54, 0, 0, 17463, 51.8625, E46, S
8, 0, 3, Palsson, Master. Gosta Leonard, male, 2, 3, 1, 349909, 21.075, , S
9, 1, 3, Johnson, Mrs. Oscar W (Elisabeth Vilhelmina Berg), female, 27, 0, 2, 347742, 11.1333, , S
10, 1, 2, Nasser, Mrs. Nicholas (Adele Achem), female, 14, 1, 0, 237736, 30.0708, , C
*/


/* Data preprocessing */

-- To ease analyse, convert the data to simple words and save it to a new table.
-- code12-22 : 
CREATE TABLE titanic AS
SELECT passengerid, 
		CASE WHEN survived = 0 THEN '사망' ELSE '생존' END survived,
        pclass, name,
        CASE WHEN gender = 'male' THEN '남성' ELSE '여성' END gender,
        age, sibsp, parch, ticket, fare, cabin,
        CASE embarked WHEN 'C' THEN '프랑스 셰르부르'
					  WHEN 'Q' THEN '아일랜드 퀸즈타운'
                      ELSE '영국 사우샘프턴' END embarked
FROM TITANIC_DATA;
-- check
SELECT *
FROM TITANIC;

