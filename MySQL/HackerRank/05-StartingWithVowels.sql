"""
Prepare > SQL > Basic Select > Weather Observation Station 6
https://www.hackerrank.com/challenges/weather-observation-station-6/
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
"""

--제출
SELECT city
FROM STATION
WHERE city LIKE 'a%' 
    or city LIKE 'e%' 
    or city LIKE 'i%' 
    or city LIKE 'o%' 
    or city LIKE 'u%'

"""
내가 무식한 것이라는 생각은 했지만 온갖 방법이 다있었다.
Discussion
"""
-- by NABA_NATH03 
SELECT DISTINCT(CITY) FROM STATION WHERE CITY RLIKE '^[aeiou]';
-- Oracle, by nchitturi
SELECT CITY FROM STATION WHERE LOWER(SUBSTR(CITY,1,1)) in ('a','e','i','o','u');
-- by melodyhe : 이 방법은 되지 않는다 
SELECT DISTINCT city from station where city LIKE '[a, e, i, o, u]%' ORDER BY city;
