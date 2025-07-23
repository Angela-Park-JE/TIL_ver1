/*
미세먼지 수치의 계절별 중앙값과 평균
https://solvesql.com/problems/finedust-seasonal-summary/
*/


-- 250723: 아래 먼저 푼 1번 방법보다 더 나은 방법(+ cte에 대해 table이라는 이름을 빼고 _cte 라고 바꾸었다), 딱히 짧아진건 아니나 ROW_NUMBER를 한 번만 해서 성능이 더 낫다고 함.
-- 물론 원래 방법-줄세웠을 때 rownumber가 같은 혹은 비슷한 로우 끼리 제한해서 묶는 방법-의 문제점을 해결하기 위해 rankstable에 ORDER BY pm10 DESC, measured_at DESC 라는 조건을 달아줬다. measured_at이 겹치는 일은 없을테니까 말이다.
-- 문제는 다른 상황에서 다른 컬럼을 가지고 해야할 때에는 이 방법이 어려울 수도 있다. 따라서 다른 방법을 찾아보던 중 더 나은 방법을 찾아 만든 쿼리이다.
-- 이 방법은 전체 row 개수에 +1 을 한 수를 2로 나누어, 짝수도 홀수도 문제 없도록 FLOOR와 CEIL의 범위를 준 형식이다.
-- 예를 들어 전체가 10개면 (10 + 1)/2 = 5.5, FLOOR와 CEIL을 적용하면 5, 6 둘을 선택하도록,
-- 전체가 11개면 (11 + 1)/2 = 6, 올림과 내림을 적용하여도 6이니 6 하나를 선택하도록 고안되어있다.
-- 2번 방법
WITH 
  season_cte AS   -- 테이블 전부 포함 및 season 정보
  (
    SELECT  *
          , CASE WHEN MONTH(measured_at) BETWEEN  3 AND 5 THEN 'spring'
                 WHEN MONTH(measured_at) BETWEEN  6 AND 8 THEN 'summer'
                 WHEN MONTH(measured_at) BETWEEN  9 AND 11 THEN 'autumn'
                 ELSE 'winter' 
                 END AS season
      FROM  measurements
  )
  , ranks_cte AS    -- row number는 한 번만 매기고 해당 그룹의 총 개수를 'cnt_byseason_div2'라는 이름으로 세어둔다.
  (
    SELECT  *
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10 DESC, measured_at DESC) AS desc_ranks
          , (CONVERT(COUNT(1) OVER (PARTITION BY season), DECIMAL) + 1)/2 AS cnt_byseason_div2  -- CAST가 계속 오류나서 DECIMAL로 해둠
      FROM  season_cte
  )
  , seasons_avg_cte AS   -- 시즌별 평균 정보
  (
    SELECT  season
          , ROUND(AVG(pm10), 2) AS pm10_average
      FROM  ranks_cte
     GROUP  BY 1
  )


SELECT  season
      , AVG(pm10) AS pm10_median
      , (SELECT pm10_average FROM seasons_avg_cte s WHERE s.season = r.season) AS pm10_average
  FROM  ranks_cte r
 WHERE  desc_ranks BETWEEN FLOOR(cnt_byseason_div2) AND CEIL(cnt_byseason_div2)
 GROUP  BY 1

;


-- 250723: WITH문 많아도 딱 세 개만 쓰고 풀자 했는데 그렇게 됐다. 
-- 1번 방법
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
