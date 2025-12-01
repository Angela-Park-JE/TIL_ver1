/*
작년 같은 월에 비해 이용율이 떨어지는 station 찾기
https://solvesql.com/problems/find-unnecessary-station-2/
*/






/*오답노트*/
-- 풀이과정1
-- 250108: 각각에 대해 구해야 하기 때문에 각각을 다 구하려고 WITH 문을 쓰긴 했다. 근데 메인 쿼리를 작성하다보니 비효율적이라는 생각이 들었다.
-- 원래의 station에 각각에 대해 SELECT 문으로 붙이는게 오히려 낫지 않았을까? 라는 생각이 들었다.
WITH 
  rent_201810
  AS 
  (
    SELECT  rent_station_id AS station_id
          , COUNT(*) AS rent18
      FROM  rental_history
     WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = 201810
     GROUP  BY rent_station_id
    HAVING  COUNT(*) != 0
  )
  ,
  rent_201910
  AS
  (
    SELECT  rent_station_id AS station_id
          , COUNT(*) AS rent19
      FROM  rental_history
     WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = 201910
     GROUP  BY rent_station_id
    HAVING  COUNT(*) != 0
  )
  ,
  return_201810
  AS
  (
    SELECT  return_station_id AS station_id
          , COUNT(*) AS return18
      FROM  rental_history
     WHERE  EXTRACT(YEAR_MONTH FROM return_at) = 201810
     GROUP  BY return_station_id
    HAVING  COUNT(*) != 0
  )
  ,
  return_201910
  AS
  (
    SELECT  return_station_id AS station_id
          , COUNT(*) AS return19
      FROM  rental_history
     WHERE  EXTRACT(YEAR_MONTH FROM return_at) = 201910
     GROUP  BY return_station_id
    HAVING  COUNT(*) != 0
  )
-- SELECT  station_id
--       , rent18 + (SELECT return18 FROM return_201810 WHERE station_id = 
--   FROM  station_id s LEFT JOIN  rent_201810 r18 ON s.station_id = r18.station_id
-- ;

-- 풀이과정2
-- 250110: 다 만들었는데, logic은 맞는 것 같은데 오랫동안 실행 돌려도 SQL 오류도 안나고 결과는 안나오는 현상... 메모리 usage 문제인건가..?
WITH  
  station_usage_cnt AS 
  (
  SELECT  s.station_id
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201810) AS rent18
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201810) AS return18
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201910) AS rent19
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201910) AS return19
    FROM  station s
  )
  ,
  station_usage_pct AS 
  (
  SELECT  station_id
        , ROUND( (rent19 + return19) / (rent18 + return18) * 100, 2) AS usage_pct
    FROM  station_usage_cnt
   WHERE  rent18 + return18 != 0  -- 폐쇄
     AND  rent19 + return19 != 0  -- 신규
  )

SELECT  p.station_id
      , s.name
      , s.local
      , p.usage_pct
  FROM  station_usage_pct p LEFT JOIN station s ON p.station_id = s.station_id
 WHERE  p.usage_pct <= 50
  ;
-- 250110: 수정하였다 메모리 덜먹게
WITH  
  station_usage_cnt AS 
  (
  SELECT  s.station_id
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201810) -- AS rent18
        + (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201810) AS cnt18
        , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201910) -- AS rent19
        + (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201910) AS cnt19
    FROM  station s
  )
  ,
  station_usage_pct AS 
  (
  SELECT  station_id
        , ROUND( cnt19 / cnt18 * 100, 2) AS usage_pct
    FROM  station_usage_cnt
   WHERE  cnt19*cnt18 != 0 
  )

SELECT  p.station_id
      , s.name
      , s.local
      , p.usage_pct
  FROM  station_usage_pct p LEFT JOIN station s ON p.station_id = s.station_id
 WHERE  p.usage_pct <= 50
  ;

-- 풀이과정3
-- 250113: SELECT 절을 자주 쓰는것 자체가 부하를 많이 가져오는 걸까..? 한눈에 들어오는 모양은 아니지만 FROM절 서브쿼리로 옮기고 했는데도 무한로딩이다.
SELECT  station_usage_pct.station_id
      , station.name
      , station.local
      , ROUND( cnt19 / cnt18 * 100, 2) AS usage_pct
  FROM  
     (
    SELECT  s.station_id
          , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201810)
          + (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201810) AS cnt18
          , (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM rent_at) = 201910)
          + (SELECT COUNT(*) FROM rental_history r WHERE s.station_id = r.return_station_id AND EXTRACT(YEAR_MONTH FROM return_at) = 201910) AS cnt19
      FROM  station s
      ) AS station_usage_pct 
      LEFT JOIN station 
             ON station_usage_pct.station_id = station.station_id
 WHERE  ROUND( cnt19 / cnt18 * 100, 2) <= 50
   AND  cnt19*cnt18 != 0 
  ;

-- 풀이과정4
-- 250130
-- -- 대여/반남 건수를 간단하게 생각해보자. 그냥 rental_history 건수로 생각해보는 것이다. 근데 쿼리가 무한 로딩에 걸린다.
-- SELECT  rent_station_id
--       , ROUND(
--         (SELECT COUNT(*) FROM rental_history r1 WHERE r1.rent_station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM r1.rent_at) = '201810') 
--         / (SELECT COUNT(*) FROM rental_history r1 WHERE r1.rent_station_id = r.rent_station_id AND EXTRACT(YEAR_MONTH FROM r1.rent_at) = '201910') * 100 , 2 ) AS rent1819
--   FROM  rental_history r
--  WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = '201810'
--  GROUP  BY 1;

-- 일단 확인차 뽑아보려는데 전체 쿼리가 작동을 안한다.
SELECT  s.station_id
      , rent18
      , rent19
  FROM  station s 
        LEFT JOIN 
                  (
                    SELECT rent_station_id, COUNT(*) AS rent18
                      FROM rental_history  
                     WHERE EXTRACT(YEAR_MONTH FROM rent_at) = '201810'
                     GROUP BY rent_station_id
                    -- HAVING COUNT(*) != 0
                  ) r18  -- 서브쿼리는 정상 작동
                  ON s.station_id = r18.rent_station_id
        LEFT JOIN 
                  (
                    SELECT rent_station_id, COUNT(*) AS rent19
                      FROM rental_history 
                     WHERE EXTRACT(YEAR_MONTH FROM rent_at) = '201910'
                     GROUP BY rent_station_id
                    -- HAVING COUNT(*) != 0
                  ) r19
                  ON s.station_id = r19.rent_station_id
;

-- 풀이과정5
-- 250323: 뻑난다. 대여/반납 건수라는게 대여+반납 건수인지 대여만 확인해도 되는건지 참 어렵다. 대여만 해보자 하고 한건데...
WITH  rent19 AS
(
SELECT  rent_station_id
      , COUNT(*) AS cnt19
  FROM  rental_history 
 WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = '201910'
 GROUP  BY rent_station_id
HAVING  COUNT(*) != 0
),
rent18 AS
(
SELECT  rent_station_id
      , COUNT(*) AS cnt18
  FROM  rental_history 
 WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = '201810'
 GROUP  BY rent_station_id
HAVING  COUNT(*) != 0
)

SELECT  s.station_id
      , ROUND(cnt19/cnt18*100, 2)
  FROM  station s LEFT JOIN rent19 ON s.station_id = rent19.rent_station_id
                  LEFT JOIN rent18 ON s.station_id = rent18.rent_station_id
 WHERE  ROUND(cnt19/cnt18*100, 2) <= 50
 ;


-- 250512: 아 다시써야해ㅠㅠ

-- 풀이과정6
-- 250906: 아예 다시 하는 과정
-- 먼저 테이블을 확실히 해보기로 한다.
-- station 테이블에 모든 station_id가 있는가?
SELECT  COUNT(DISTINCT station_id)  
  FROM  station
UNION  ALL
SELECT  COUNT(DISTINCT rent_station_id)  
  FROM  rental_history
UNION  ALL
SELECT  COUNT(DISTINCT return_station_id)  
  FROM  rental_history
UNION  ALL
SELECT  COUNT(DISTINCT station_id)
  FROM
      (
        SELECT  station_id
          FROM  station
        UNION ALL
        SELECT  DISTINCT rent_station_id
          FROM  rental_history
        UNION ALL 
        SELECT  DISTINCT return_station_id
          FROM  rental_history
      ) tmp
-- 숫자는 station이 2153, 그다음 2149, 2150, 2153 이다.
-- 다 포함된 것으로 보이나 혹시나 아닐 수도 있어서 뒤에 다 합친 테이블에서 체크하도록 했다.
-- 이로써 station테이블에 모든 station_id 정보가 있는 것을 확인했다.
-- 그래서 이어서 써본 것인데 뻑난다... 결과가 안나온다.
-- 간단하게 생각해보자. 정류장 별로 대여된 횟수를 세는 쿼리와 반납된 횟수를 세는 쿼리를 만든다.
WITH 
  rent_case AS
  (
  SELECT  rent_station_id
        , SUM(CASE WHEN YEAR(rent_at) = 2018 THEN 1 ELSE 0 END) rented18
        , SUM(CASE WHEN YEAR(rent_at) = 2019 THEN 1 ELSE 0 END) rented19
    FROM  rental_history
  WHERE  EXTRACT(YEAR_MONTH FROM rent_at) IN ('201810', '201910')
  GROUP  BY 1
  )
  , 
  return_case AS
  (
  SELECT  return_station_id
        , SUM(CASE WHEN YEAR(return_at) = 2018 THEN 1 ELSE 0 END) returned18
        , SUM(CASE WHEN YEAR(return_at) = 2019 THEN 1 ELSE 0 END) returned19
    FROM  rental_history
  WHERE  EXTRACT(YEAR_MONTH FROM rent_at) IN ('201810', '201910')
  GROUP  BY 1
  )


SELECT  s.station_id
      , rented18
      , rented19
      , returned18
      , returned19
  FROM  station s
        LEFT JOIN  rent_case rnt ON s.station_id = rnt.rent_station_id
        LEFT JOIN  return_case rtn ON s.station_id = rtn.return_station_id

;   
