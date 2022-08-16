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



"""
Prepare> SQL> Aggregation> Weather Observation Station 14
https://www.hackerrank.com/challenges/weather-observation-station-14/
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.
"""

--Oracle
SELECT TRUNC(MAX(lat_n), 4)
FROM STATION
WHERE lat_n <137.2345;

--MySQL
SELECT TRUNCATE(MAX(lat_n), 4)
FROM STATION
WHERE lat_n <137.2345;



"""
Prepare> SQL> Aggregation> Weather Observation Station 15
https://www.hackerrank.com/challenges/weather-observation-station-14/
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
Round your answer to 4 decimal places.
"""

--Oracle (방법1, 조인 - 물론 인라인 뷰로 넣어도 된다)
SELECT ROUND(long_w, 4)
FROM STATION 
    INNER JOIN
        (SELECT MAX(lat_n) AS maximum
        FROM STATION
        WHERE lat_n < 137.2345) s ON STATION.lat_n = s.maximum;
    
--MySQL (방법2, ORDER BY와 LIMIT을 사용해 보았다.)
SELECT ROUND(long_w, 4)
FROM STATION
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
LIMIT 1;

"""
더 좋은 답이 있지 않을까 찾아본 결과... 서브쿼리를 피하기위해 다른 방법을 쓰기도 했지만, 서브쿼리를 쓰는 것이 더 효율적이라는 의견이 조금더 많았다. 
"""
--MSSQL(by. zee1s) WHERE에 서브쿼리 결과를 바로 넣어버렸다. 멋지다.
Select format(LONG_W,'N4') from STATION 
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N<137.2345);

--Oracle(by. lelcat) 엄청 신기한 풀이. 변수를 사용하다니. 멋지다.
// Solution 2 -- assign max_lat_n variable and seek
variable max_lat_n number;
exec select max(LAT_N) into :max_lat_n from STATION where LAT_N<137.2345;
select round(LONG_W,4) from STATION where LAT_N=:max_lat_n;



"""
Prepare> SQL> Aggregation> Weather Observation Station 17
https://www.hackerrank.com/challenges/weather-observation-station-17/
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7880. 
Round your answer to 4 decimal places.
"""

--Oracle (이전 문제에서 배운 멋진 방법을 사용했다 킬킬)
SELECT ROUND(long_w, 4)
FROM STATION
WHERE lat_n = (SELECT MIN(lat_n) FROM STATION WHERE lat_n > 38.7880);



"""
Prepare> SQL> Aggregation> Weather Observation Station 18
https://www.hackerrank.com/challenges/weather-observation-station-18/
Consider P_1(a,b) and P_2(c,d) to be two points on a 2D plane.
'a' happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
'b' happens to equal the minimum value in Western Longitude (LONG_W in STATION).
'c' happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
'd' happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P_1 and P_2 and round it to a scale of 4 decimal places.
"""

--Oracle (문제읽고 바로 떠올랐던 쿼리형태)
SELECT ROUND((c-a + d-b), 4)
FROM 
    (SELECT MIN(lat_n) a, MIN(long_w) b, MAX(lat_n) c, MAX(long_w) d
    FROM STATION);

--MySQL (바로 연산하는 방식)
SELECT ROUND(MAX(long_w)-MIN(long_w) + MAX(lat_n)-MIN(lat_n), 4)
FROM STATION;



"""
Prepare> SQL> Aggregation> Weather Observation Station 19
https://www.hackerrank.com/challenges/weather-observation-station-19/
Consider P_1(a,b) and P_2(c,d) to be two points on a 2D plane 
where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) 
and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points P_1 and P_2 and format your answer to display 4 decimal digits.
"""

--Oracle, MySQL (위와 같은 방식, 둘다 같음, 레이텍스를 자주 사용하길 잘했다 sqrt 찾을뻔)
SELECT ROUND(SQRT(POWER(MAX(long_w)-MIN(long_w), 2) + POWER(MAX(lat_n)-MIN(lat_n), 2)), 4)
FROM STATION;

