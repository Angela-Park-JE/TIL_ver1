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


"""
Prepare> SQL> Aggregation> Weather Observation Station 13
https://www.hackerrank.com/challenges/weather-observation-station-13/
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. 
Truncate your answer to  decimal places.
"""

--Oracle
SELECT TRUNC(SUM(lat_N), 4)
FROM STATION
WHERE lat_n > 38.7880 
    AND lat_n < 137.2345;
    
--MySQL
SELECT TRUNCATE(SUM(lat_N), 4)
FROM STATION
WHERE lat_n > 38.7880 
    AND lat_n < 137.2345;
