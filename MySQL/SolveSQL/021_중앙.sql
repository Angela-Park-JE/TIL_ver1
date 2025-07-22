/*
미세먼지 수치의 계절별 중앙값과 평균
https://solvesql.com/problems/finedust-seasonal-summary/
*/



/*오답노트*/
-- 250722: 미완성인 쿼리다. 시즌을 나누고, 시즌 기준으로 집계하여 랭크를 먹인다음, 랭크를 기준으로 중앙값이 될 index 아 아니지 ROW_NUMBER를 찾는 형태를 원했는데
-- WITH문까지는 괜찮으나 지금 메인쿼리를 짜다가 잠깐... 그만... 정신을 잃고 만 것이에요.
WITH 
  seasontable AS 
  (
    SELECT  *
            , CASE WHEN MONTH(measured_at) BETWEEN  3 AND 5 THEN 'spring'
                  WHEN MONTH(measured_at) BETWEEN  6 AND 8 THEN 'summer'
                  WHEN MONTH(measured_at) BETWEEN  9 AND 11 THEN 'autumn'
                  ELSE 'winter' 
                  END AS season
      FROM  measurements
  ),
  ranktable AS 
  (
    SELECT  *
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10 DESC) AS ranks
      FROM  seasontable
  ),
  medianranktable AS
  (
    SELECT  season
          , ROUND(AVG(pm10), 2  -- 그냥 미리구해두는 계절별 평균
          , CASE WHEN MAX(ranks)%2 = 0 THEN (SELECT SUM(r2.pm10)/2 FROM ranktable r2 WHERE r2.ranks = MAX(r1.ranks)/2 
                 ELSE ROUND((MAX(ranks)/2))  
                 END median_ranks
      FROM  ranktable r1
     GROUP  BY season
  )

SELECT  r.season  
      , 
  FROM  ranktable r 
        LEFT JOIN medianranktable m 
        ON r.season = m.season and r.ranks = m.median_ranks
 WHERE  rank
 LIMIT  100;
