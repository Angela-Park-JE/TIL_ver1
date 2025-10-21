/*
전력 소비의 moving average in 1hour
https://solvesql.com/problems/moving-average-of-power-consumption/
*/


-- 241220: 부끄러울 정도의 실수...! window 함수를 사용한다는 사실 자체에 빠져서 PARTITION BY를 자각을 못하고...
-- refreshed brain으로 다음날 보니 바로 보여서 스스로 부끄러웠다.
SELECT  DATE_ADD(measured_at, INTERVAL +10 MINUTE) AS end_at
      , ROUND(AVG(zone_quads) OVER 
              (ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_quads
      , ROUND(AVG(zone_smir) OVER 
              (ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_smir
      , ROUND(AVG(zone_boussafou) OVER 
              (ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_boussafou
  FROM  power_consumptions
 WHERE  measured_at >= '2017-01-01 00:00:00' 
   AND  measured_at < '2017-02-01 00:00:00'
 ORDER  BY 1
;



/*오답노트*/
-- 241219: 먼저 10분 단위의 평균을 내기 위해 해당 시간의 LAG LEAD를 구..하는 것보다
-- 윈도우 함수가 최적일 것 같다.
SELECT  measured_at AS end_at
      , ROUND(AVG(zone_quads) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_quads
      , ROUND(AVG(zone_smir) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_smir
      , ROUND(AVG(zone_boussafou) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_boussafou
  FROM  power_consumptions
 WHERE  measured_at BETWEEN '2017-01-01 00:10:00' AND '2017-02-01 00:00:00'
 ORDER  BY 1
; 
-- 잘 구현하긴 했지만, 시간 기간의 문제에서 00:10:00 자체가 끝시간이 되어야 한다. 즉 시간이 10분씩 미루어져야 한다는 점. 

-- 이 경우에는 DATE_ADD를 사용하여 표기 날짜를 더해준 것인데, BETWEEN을 사용했다보니 끝 시간 까지 들어가서 2월 1일 0시 10분까지 들어가 있다.
-- 따라서 시간 제한을 예쁘게 다시 해줘야 함
-- 그리고 값이 첫 번째 로우 말고는 다르다는 것을 알게되었다. 따라서 window frame을 수정해야했다. 바보였나보다. 직전 한시간의 이동평균을 구해야 하는 건데.
SELECT  DATE_ADD(measured_at, INTERVAL +10 MINUTE) AS end_at
      , ROUND(AVG(zone_quads) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_quads
      , ROUND(AVG(zone_smir) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_smir
      , ROUND(AVG(zone_boussafou) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS zone_boussafou
  FROM  power_consumptions
 WHERE  measured_at BETWEEN '2017-01-01 00:00:00' AND '2017-02-01 00:00:00'
 ORDER  BY 1
;

-- 241219: 고쳤는데도 어떤 부분이 문제인지 찾지 못했다.
SELECT  DATE_ADD(measured_at, INTERVAL +10 MINUTE) AS end_at
      , ROUND(AVG(zone_quads) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_quads
      , ROUND(AVG(zone_smir) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_smir
      , ROUND(AVG(zone_boussafou) OVER 
              (PARTITION BY measured_at ORDER BY measured_at
              ROWS BETWEEN 5 PRECEDING AND CURRENT ROW), 2) AS zone_boussafou
  FROM  power_consumptions
 WHERE  measured_at >= '2017-01-01 00:00:00' 
   AND  measured_at < '2017-02-01 00:00:00'
 ORDER  BY 1
;
