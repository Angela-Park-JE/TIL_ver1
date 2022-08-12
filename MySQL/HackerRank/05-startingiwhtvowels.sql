"""
Prepare > SQL > Basic Select > Weather Observation Station 6
https://www.hackerrank.com/challenges/weather-observation-station-6/
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
"""

SELECT city
FROM STATION
WHERE city LIKE 'a%' 
    or city LIKE 'e%' 
    or city LIKE 'i%' 
    or city LIKE 'o%' 
    or city LIKE 'u%'
