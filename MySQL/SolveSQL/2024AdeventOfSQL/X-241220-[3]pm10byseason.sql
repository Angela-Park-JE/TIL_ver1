/*
https://solvesql.com/problems/finedust-seasonal-summary/
*/



/*오답노트*/
-- 250428: 안해버릇하니 중앙값 구하는데 헤메고있다. 반성해!
WITH  
  season_table AS 
  (
    SELECT  CASE  WHEN MONTH(measured_at) BETWEEN 3 AND 5 THEN 'spring'
                  WHEN MONTH(measured_at) BETWEEN 6 AND 8 THEN 'summer' 
                  WHEN MONTH(measured_at) BETWEEN 9 AND 11 THEN 'autumn' 
                  ELSE 'winter' 
                  END AS season
          , pm10
      FROM  measurements
  ),
  rownums_table AS
  (
    SELECT  season
          , ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10) AS rownums
          , pm10
      FROM  season_table
  )

SELECT  season
      , CASE WHEN MAX(rownums)%2=1 THEN ROW_NUMBER() 
  FROM  rownums_table r1
 GROUP  BY 1
;
