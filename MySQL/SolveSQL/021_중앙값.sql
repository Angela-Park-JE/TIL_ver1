/*
미세먼지 수치의 계절별 중앙값과 평균
https://solvesql.com/problems/finedust-seasonal-summary/
*/


-- 250723: WITH문 많아도 딱 세 개만 쓰고 풀자 했는데 그렇게 됐다. 
WITH 
  seasontable AS   -- 테이블 전부 포함 및 season 정보
  (
    SELECT  *
          , CASE WHEN MONTH(measured_at) BETWEEN  3 AND 5 THEN 'spring'
                 WHEN MONTH(measured_at) BETWEEN  6 AND 8 THEN 'summer'
                 WHEN MONTH(measured_at) BETWEEN  9 AND 11 THEN 'autumn'
                 ELSE 'winter' 
                 END AS season
      FROM  measurements
  ),
  rankstable AS  -- 시즌별로 rank를 순방/역방 전부 구함-참조:datarian
  -- pm10이 겹치는 경우에 대하여 고유한 row number를 위해 measured_at도 기준으로 넣어야 함
  -- 바로 이것을 해결한 다음 문제가 풀림.
  (
    SELECT  *
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10 DESC, measured_at DESC) AS desc_ranks
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10, measured_at) AS asc_ranks
      FROM  seasontable
  ),
  seasonsmediantable AS   -- 시즌별 중앙값 정보
  (
    SELECT  season
          , AVG(pm10) AS pm10_median
      FROM  rankstable r
     WHERE  asc_ranks IN (desc_ranks, desc_ranks + 1, desc_ranks - 1)
     GROUP  BY 1
  )


SELECT  t1.season
      , pm10_median
      , pm10_average
  FROM 
      (
        SELECT  season
              , ROUND(AVG(pm10), 2) AS pm10_average
          FROM  seasontable
         GROUP  BY 1
      ) t1 
      LEFT JOIN seasonsmediantable t2
      ON t1.season = t2.season
  
  ;



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
-- LIMIT  100;


-- 250723: 손으로 해보다가 분명 rank number로 풀면 좋을 것 같은데 어떻게 구현해야하는거지 medianranktable 만들다가 안돼서
-- 전에 하던 것을 더듬어 글을 읽으며 만든 쿼리이다.
-- 동작은 하지만 가장큰 문제는 spring에 한해서만 결과가 나온다는 것이다. 이게 말이되나!
-- 라고 하는 순간 이해했다. 바보다. WHERE절이 먼저 적용이 되면 AVG 같은 집계는 소용이 없다. 뭐하는 것인가!
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
  ranktable AS  -- 참조:datarian
  (
    SELECT  *
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10 DESC) AS desc_ranks
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10 ASC) AS asc_ranks
      FROM  seasontable
  ),
  mediantable AS
  (
    SELECT  season
          , AVG(pm10) AS pm10_median
          , ROUND(AVG(pm10), 2) AS pm10_average  -- 미리 구해두는 계절별 평균
      FROM  ranktable r
     WHERE  asc_ranks IN (desc_ranks, desc_ranks + 1, desc_ranks - 1)
     GROUP  BY season
  )

SELECT  * 
  FROM  mediantable
;
