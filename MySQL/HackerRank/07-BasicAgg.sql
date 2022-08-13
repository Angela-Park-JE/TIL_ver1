"""
Prepare> SQL > Aggregation > Revising Aggregations - The Count Function
https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/
Query a count of the number of cities in CITY having a Population larger than 100,000.
"""

SELECT COUNT(id)
FROM CITY
WHERE population > 100000;


"""
Prepare> SQL > Aggregation > Revising Aggregations - The Count Function
https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/
Query the total population of all cities in CITY where District is California.
"""

SELECT SUM(population)
FROM CITY
WHERE district = 'California';


"""
Prepare> SQL > Aggregation > Revising Aggregations - Averages
https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/
Query the total population of all cities in CITY where District is California.
"""

SELECT AVG(population)
FROM CITY
WHERE district = 'California';


"""
Prepare> SQL > Aggregation > Average Population
https://www.hackerrank.com/challenges/average-population/
Query the average population for all cities in CITY, rounded down to the nearest integer.
"""

SELECT ROUND(AVG(population), 0)
FROM CITY;


"""
Prepare> SQL > Aggregation > Population Density Difference
https://www.hackerrank.com/challenges/population-density-difference/
Query the difference between the maximum and minimum populations in CITY.
"""

SELECT MAX(population)-MIN(population) as diff_population
FROM CITY;
