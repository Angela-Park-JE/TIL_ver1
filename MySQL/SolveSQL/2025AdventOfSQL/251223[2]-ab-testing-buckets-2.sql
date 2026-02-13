/*
A/B테스트를 위한 사용자 버킷 나누기 문제
https://solvesql.com/problems/ab-testing-buckets-2/
*/





/*오답노트*/

-- 251225: 
SELECT  bucket
      , COUNT(DISTINCT customer_id) AS user_count
      , COUNT(transaction_id)/COUNT(DISTINCT customer_id) AS avg_orders
      , COUNT(total_price)/COUNT(DISTINCT customer_id) AS avg_revenue
  FROM  
        (
          SELECT  t.* 
                , CASE WHEN customer_id%10 = 0 THEN 'A' ELSE 'B' END AS bucket
            FROM  transactions t
           WHERE  is_returned = 0
        ) buc_table
 GROUP  BY bucket
 ORDER  BY 1;

-- 260211:
SELECT  trans1.bucket
      , COUNT(DISTINCT trans1.customer_id) AS user_count
      , ROUND(AVG(trans2.ord_cnt), 2) AS avg_orders
      , ROUND(AVG(trans1.total_price), 2) AS avg_revenue
  FROM 
        (
          SELECT  CASE WHEN (customer_id)%10 = 0 THEN 'A' ELSE 'B' END AS bucket
                , customer_id
                , total_price
            FROM  transactions
           WHERE  is_returned != 1
        ) trans1
        ,
        (
          SELECT  customer_id
                , COUNT(*) AS ord_cnt
            FROM  transactions
           WHERE  is_returned != 1
           GROUP  BY customer_id
        ) trans2
 WHERE  trans1.customer_id = trans2.customer_id
 GROUP  BY trans1.bucket
 ;
