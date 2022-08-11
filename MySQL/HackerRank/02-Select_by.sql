"""
Prepare > SQL > Basic Select > Select By ID
https://www.hackerrank.com/challenges/select-by-id/
Query all columns for a city in CITY with the ID 1661. 
The CITY table is described as follows:
"""

SELECT *
FROM CITY
WHERE ID = '1661'


"""
Prepare > SQL > Basic Select > Japanese Cities' Attributes
https://www.hackerrank.com/challenges/japanese-cities-attributes/
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
The CITY table is described as follows:
"""

SELECT *
FROM CITY
WHERE countrycode = 'JPN'


"""
Prepare > SQL > Basic Select > Japanese Cities' Names
https://www.hackerrank.com/challenges/japanese-cities-name/
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
The CITY table is described as follows:
"""

SELECT name
FROM CITY
WHERE countrycode = 'JPN'


"""
Prepare > SQL > Basic Select > Weather Observation Station 1
https://www.hackerrank.com/challenges/weather-observation-station-1/
Query a list of CITY and STATE from the STATION table.
The STATION table is described as follows:
"""

SELECT city, state
FROM STATION


"""
Prepare > SQL > Basic Select > Weather Observation Station 3
https://www.hackerrank.com/challenges/weather-observation-station-3/
Query a list of CITY names from STATION for cities that have an 'even' ID number. Print the results in any order, but exclude duplicates from the answer.
The STATION table is described as follows:,
where LAT_N is the northern latitude and LONG_W is the western longitude.
"""

SELECT DISTINCT city --중복제거
FROM STATION
WHERE id%2 = 0
