"""
Prepare> SQL> Aggregation> Weather Observation Station 2
https://www.hackerrank.com/challenges/weather-observation-station-2/
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
"""

--Oracle
SELECT ROUND(SUM(lat_N), 2), ROUND(SUM(long_w), 2)
FROM STATION;

--MySQL
SELECT ROUND(SUM(lat_N), 2), ROUND(SUM(long_w), 2)
FROM STATION;
