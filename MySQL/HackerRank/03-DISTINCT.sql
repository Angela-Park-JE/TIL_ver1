"""
Prepare> SQL> Basic Select > Weather Observation Station 4
https://www.hackerrank.com/challenges/weather-observation-station-4/
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
The STATION table is described as follows:
where LAT_N is the northern latitude and LONG_W is the western longitude.

For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', 
there are 2 different city names: 'New York' and 'Bengalaru'. The query returns 3 - 2 = 1
"""

-- 오답
-- SELECT COUNT(STATION.id) - COUNT(uniquecity.city)
-- FROM STATION, (SELECT DISTINCT CITY FROM STATION) AS uniquecity

-- 정답: DISTINCT를 바로 쓸 수 있다. 
SELECT COUNT(city) - COUNT(DISTINCT city)
FROM STATION
