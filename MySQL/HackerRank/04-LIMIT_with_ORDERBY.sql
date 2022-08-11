"""
Prepare > SQL > Basic Select > Weather Observation Station 5
https://www.hackerrank.com/challenges/weather-observation-station-5/
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
(i.e.: number of characters in the name). If there is more than one smallest or largest city, 
choose the one that comes first when ordered alphabetically.
The STATION table is described as follows:
-- When ordered alphabetically, the CITY names are listed as ABC, DEF, PQRS, and WXY, with lengths 3, 3, 4 and 3. 
-- The longest name is PQRS, but there are 3 options for shortest named city. Choose ABC, because it comes first alphabetically.
You can write two separate queries to get the desired output. It need not be a single query.
"""

--제출
SELECT DISTINCT city, MIN(LENGTH(city))
FROM STATION
GROUP BY 1
ORDER BY 2, 1 
LIMIT 1;

SELECT DISTINCT city, MAX(LENGTH(city))
FROM STATION
GROUP BY 1
ORDER BY 2 DESC, 1 ASC
LIMIT 1;

"""
(Oracle)ROWNUM -> (MySQL)LIMIT | (MSSQL) SELECT TOP 1, 
거의 30분 이상 걸렸던 문제... 그럼에도 더 나은 방법이 있다. 
MIN MAX가 따로 필요할게 아니었고, ORDER의 문제였다. 
근데 출제문제 자체의 문제가, 같은 길이값이면 텍스트 순서대로 가져오라고 했다. 
다들 너무 간단하게 order by를 해두었다. 만약 max length가 같은 텍스트였으면 오류났을텐데...
"""

--보완
SELECT DISTINCT city, LENGTH(city)
FROM STATION
ORDER BY 2, 1 
LIMIT 1;

SELECT DISTINCT city, LENGTH(city)
FROM STATION
ORDER BY 2 DESC, 1 ASC
LIMIT 1;


"""
FROM DISCUSSION
"""
by: niromy98, 1years ago
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY), CITY ASC LIMIT 1; 
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC LIMIT 1;
