/*
https://solvesql.com/problems/characteristics-of-orders/
*/



-- 250523: 아래의 두 쿼리는 같은 결과를 반환하는 멍청한 쿼리이다.
-- 이게 또... 아마... DISTINCT order_id 같은게 필요한 '사람마다 다르게 받아들일 말' 숨어있는지도 모른다
SELECT  Region
      , SUM(IF(category = 'Furniture', 1, 0)) AS 'Furniture'
      , SUM(IF(category = 'Office Supplies', 1, 0)) AS 'Office Supplies'
      , SUM(IF(category = 'Technology', 1, 0)) AS 'Technology'
  FROM  records r
 GROUP  BY  region  
 ORDER  BY 1
;

SELECT  Region
      , SUM(f) AS 'Furniture'
      , SUM(o) AS 'Office Supplies'
      , SUM(t) AS 'Technology'
  FROM  (
          SELECT  Region
                , IF(category = 'Furniture', 1, 0) f
                , IF(category = 'Office Supplies', 1, 0) o
                , IF(category = 'Technology', 1, 0) t
            FROM  records r
        ) byregion
 GROUP  BY Region
 ORDER  BY 1
;
