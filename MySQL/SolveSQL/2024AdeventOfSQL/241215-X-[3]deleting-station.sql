/*
작년 같은 월에 비해 이용율이 떨어지는 station 찾기
https://solvesql.com/problems/find-unnecessary-station-2/
*/






/*풀이 과정*/
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
