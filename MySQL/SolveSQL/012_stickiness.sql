/*
DAU, WAU, 그리고 stickiness(사용자 고착도) = DAU/WAU 일별 구하기.
https://solvesql.com/problems/stickiness-of-shoppingmall/
*/


-- 250402: JOIN 조건으로 기간을 정해서 INNER JOIN 시킨다
WITH  w_customer_counts AS 
      (
      SELECT  r1.order_date
            , COUNT(DISTINCT r1.customer_id) AS dau
            , COUNT(DISTINCT r2.customer_id) AS wau
        FROM  records r1
                JOIN records r2
                ON r2.order_date BETWEEN DATE_SUB(r1.order_date, INTERVAL 6 DAY) AND r1.order_date
       WHERE  EXTRACT(YEAR_MONTH FROM r1.order_date) = '202011'
       GROUP  BY r1.order_date
)
SELECT  order_date AS dt
      , dau
      , wau
      , ROUND(dau/wau, 2) AS stickiness
  FROM  w_customer_counts;



/*오답노트*/
-- 간단히 dau를 구하는 것
SELECT  order_date
      , COUNT(DISTINCT customer_id) AS dau
  FROM  records r1
 GROUP  BY order_date
 -- LIMIT 100
  ;
-- wau를 구하는 것: 이 부분에서 문제가 있었음. 
SELECT  r1.order_date
      , COUNT((SELECT  DISTINCT r2.customer_id FROM records r2 WHERE r2.order_date BETWEEN DATE_SUB(r1.order_date, INTERVAL 6 DAY) AND r1.order_date)) AS wau
  FROM  records r1
 WHERE  EXTRACT(YEAR_MONTH FROM r1.order_date) = '202011'
 GROUP  BY 1
 -- LIMIT 100
  ;
