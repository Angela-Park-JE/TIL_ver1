"""
Prepare> SQL> Aggregation> Weather Observation Station 20
https://www.hackerrank.com/challenges/weather-observation-station-20/
A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
"""

--MySQL (개수에 따른 순번을 하나 혹은 둘을 구하고, 구하고자 하는 데이터에 순번을 매겨주고, 두 테이블을 함께 조회하여 답을 도출하도록.)
--CASE WHEN에서 오래걸렸다. 하나하나 쿼리결과 넣기보다 딱 구해놓기로 하도록 WITH를 사용. 그리고 no를 매기는 것에서 오래걸렸다.
--MEDIAN 함수를 사용해도 되는데 굳이 이렇게 하려고 했던 이유는 뭘까... 객기였다...
WITH 
    numbers AS (
                SELECT CASE WHEN COUNT(lat_n) % 2 = 0
                            THEN COUNT(lat_n) / 2 + 1
                            WHEN COUNT(lat_n) % 2 = 1
                            THEN COUNT(lat_n) / 2 + 0.5 END as a,
                       CASE WHEN COUNT(lat_n) % 2 = 0
                            THEN COUNT(lat_n) / 2 END as b
                FROM STATION
                ),
    rownum_lat AS(
                    SELECT 
                           t.lat_n AS lat_n, 
                           @rownum := @rownum + 1 AS no
                    FROM 
                           (SELECT lat_n FROM STATION ORDER BY 1 ASC) AS t,
                           (SELECT @rownum :=0) AS r
                )

SELECT 
    CASE WHEN n.b is null -- number of lat_n is not even numbers
         THEN ROUND(r.lat_n, 4)
         WHEN n.b is not null -- number of lat_n is even numbers
         THEN ROUND(r.lat_n + (SELECT r.lat_n FROM numbers n, rownum_lat r WHERE n.b = r.no), 4)
         END as result
FROM numbers n, rownum_lat r
WHERE n.a = r.no;



--Oracle
--실패: plan1. nearest by avg 
SELECT ROUND((SELECT MIN(lat_n)
                FROM STATION
                WHERE lat_n > (SELECT AVG(lat_n) FROM STATION)) + 
            (SELECT MAX(lat_n)
                FROM STATION
                WHERE lat_n < (SELECT AVG(lat_n) FROM STATION)) / 2 , 4)
FROM dual;

--실패: plan2. count(lat_n)%2 =0 or not
-- SELECT count(lat_n), a+b
-- FROM STATION, (SELECT COUNT(lat_n) m FROM STATION) s
-- WHERE (CASE WHEN s.m%2 = 0
--             THEN a = COUNT(lat_n)/2 + 1 AND b = COUNT(lat_n)/2
--             WHEN COUNT(lat_n)%2 = 1
--             THEN a = COUNT(lat_n)/2 +0.5
--        ELSE a = COUNT(lat_n) END);
