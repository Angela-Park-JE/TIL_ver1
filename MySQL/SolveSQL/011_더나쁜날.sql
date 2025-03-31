/*
다음날 농도가 더 나쁜 날들 찾기
https://solvesql.com/problems/bad-finedust-measure/
*/


-- 250331: 어려울 것 없이 DATE_ADD로 해결되는 문제
SELECT  *
  FROM  
        (
          SELECT  m1.measured_at AS today
                , m2.measured_at AS next_day
                , m1.pm10 AS pm10
                , m2.pm10 AS next_pm10
            FROM  measurements m1 
                  LEFT JOIN measurements m2
                  ON DATE_ADD(m1.measured_at, INTERVAL 1 DAY) = m2.measured_at
        ) days_pm10
 WHERE  pm10<next_pm10
;
