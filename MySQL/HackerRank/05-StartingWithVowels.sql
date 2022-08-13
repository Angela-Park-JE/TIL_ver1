"""
배운것: 정규표현식으로 검색할 수 있는 방법이 RLIKE인데, '^a' 는 a로 시작, 'a$' 는 a로 끝나는 것을 검색한다.
"""


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
    or city LIKE 'u%';

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


"""
Prepare > SQL > Basic Select > Weather Observation Station 7
https://www.hackerrank.com/challenges/weather-observation-station-7/
Query the list of CITY names ending with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city RLIKE '[aeiou]$';


"""
Prepare > SQL > Basic Select > Weather Observation Station 8
https://www.hackerrank.com/challenges/weather-observation-station-8/
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city RLIKE '[aeiou]$' 
  and city RLIKE '^[aeiou]';


"""
Prepare > SQL > Basic Select > Weather Observation Station 9
https://www.hackerrank.com/challenges/weather-observation-station-9/
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city NOT RLIKE '^[aeiou]';


"""
Prepare > SQL > Basic Select > Weather Observation Station 10
https://www.hackerrank.com/challenges/weather-observation-station-10/
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city NOT RLIKE '[aeiou]$';


"""
Prepare > SQL > Basic Select > Weather Observation Station 11
https://www.hackerrank.com/challenges/weather-observation-station-11/
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city NOT RLIKE '^[aeiou]'
   or city NOT RLIKE '[aeiou]$';


"""
Prepare > SQL > Basic Select > Weather Observation Station 12
https://www.hackerrank.com/challenges/weather-observation-station-12/
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
"""

SELECT DISTINCT city
FROM STATION
WHERE city NOT RLIKE '^[aeiou]'
  and city NOT RLIKE '[aeiou]$';
