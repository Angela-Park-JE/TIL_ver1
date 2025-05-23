/*
https://solvesql.com/problems/characteristics-of-orders/
*/


-- 250523: GROUP_CONCAT으로 묶어버린 다음 일일히 검색하여 1과 0으로 대치하는 비효율적 방법
-- 하지만 어떡해 다른 방법이 생각이 나질 않아 썸바리헲믜
SELECT  Region
      , SUM(IF(categories LIKE '%Furniture%', 1, 0)) AS 'Furniture'
      , SUM(IF(categories LIKE '%Office%', 1, 0)) AS 'Office Supplies'
      , SUM(IF(categories LIKE '%Technology%', 1, 0)) AS 'Technology'
  FROM  
        (
          SELECT  region
                , order_id
                , GROUP_CONCAT(category) AS categories
            FROM  records
          GROUP  BY region, order_id, category
        ) cat_concat_table
 GROUP  BY region
 ORDER  BY 1
;



/*오답노트*/
-- 250523: 아래의 두 쿼리는 같은 결과를 반환하는 멍청한 쿼리이다. ㅎㅎ 아무튼 한 주문번호 안에 여러 물건들을 다 각각 하나로 센다.
-- 이게 또... 아마... DISTINCT order_id 같은게 필요한 '사람마다 다르게 받아들일 말'...그치...그래
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
