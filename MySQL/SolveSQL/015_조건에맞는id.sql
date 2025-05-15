/*
조건에 맞는 셀러들 찾기
https://solvesql.com/problems/settled-sellers-2/
*/


-- 250509:
SELECT  seller_id
      , COUNT(DISTINCT order_id) AS orders  
  FROM  olist_order_items_dataset
 WHERE  price >= 50 
 GROUP  BY 1
HAVING  COUNT(DISTINCT order_id) >= 100
 ORDER  BY 2 DESC
 ;
