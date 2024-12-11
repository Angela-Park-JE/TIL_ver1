/*
월간 매출 집계
https://solvesql.com/problems/shoppingmall-monthly-summary/
*/


-- 241208: 
SELECT  order_month
      , SUM(ordered_amount) AS ordered_amount
      , SUM(canceled_amount) AS canceled_amount
      , SUM(ordered_amount+canceled_amount) AS total_amount
  FROM  
        ( 
        SELECT  DATE_FORMAT(order_date, '%Y-%m') AS order_month
              , CASE WHEN oi.order_id LIKE 'C%' THEN 0 ELSE price*quantity END AS ordered_amount 
              , CASE WHEN oi.order_id NOT LIKE 'C%' THEN 0 ELSE price*quantity END AS canceled_amount 
          FROM  order_items oi LEFT JOIN orders o 
                ON oi.order_id = o.order_id
        ) tmp    -- 각 행별로 값을 만들어둔 테이블
 GROUP  BY order_month
 ORDER  BY 1
 ;
