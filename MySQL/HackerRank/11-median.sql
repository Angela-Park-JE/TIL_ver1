"""
Prepare> SQL> Aggregation> Weather Observation Station 20
https://www.hackerrank.com/challenges/weather-observation-station-20/
A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
"""

--Oracle
--실패: plan1. nearest by avg 
SELECT ROUND((SELECT MIN(lat_n)
                FROM STATION
                WHERE lat_n > (SELECT AVG(lat_n) FROM STATION)) + 
            (SELECT MAX(lat_n)
                FROM STATION
                WHERE lat_n < (SELECT AVG(lat_n) FROM STATION)) / 2 , 4)
FROM dual;
