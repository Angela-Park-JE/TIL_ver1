/*
요일별 오염도, 요일을 한국어로 하되 order by 요일별
https://solvesql.com/problems/weekday-stats-airpollution/
*/


-- 241212: CASE WHEN 쓰는 게 매우 귀찮지만 어쩔 수 없군요.
-- ORDER BY 를 위해 서브쿼리를 활용하는 것이 나아보인다.
SELECT  CASE measured_at WHEN 0 THEN '월요일' 
                         WHEN 1 THEN '화요일'
                         WHEN 2 THEN '수요일'
                         WHEN 3 THEN '목요일'
                         WHEN 4 THEN '금요일'
                        WHEN 5 THEN '토요일'
                         WHEN 6 THEN '일요일'
             END AS 'weekday'
             , no2, o3, co, so2, pm10, pm2_5  -- 나머지 컬럼들
  FROM  
        (
        SELECT  WEEKDAY(measured_at) AS measured_at
              , ROUND(AVG(no2), 4) AS no2
              , ROUND(AVG(o3), 4) AS o3
              , ROUND(AVG(co), 4) AS co
              , ROUND(AVG(so2), 4) AS so2
              , ROUND(AVG(pm10), 4) AS pm10
              , ROUND(AVG(pm2_5), 4) AS pm2_5
          FROM  measurements
         GROUP  BY 1
        ) tmp
 ORDER  BY measured_at
;
