/*
데이터리안 SQL 캠프 실전반> 배송 예정일 예측 성공과 실패
https://solvesql.com/problems/estimated-delivery-date/
*/

-- 240409: 아래의 오답노트를 거쳐 완성한 쿼리
SELECT  DATE(purchase_time) purchase_date
      , COUNT(CASE WHEN yesorno = 1 THEN 1 END) AS 'success'
      , COUNT(CASE WHEN yesorno = 0 THEN 1 END) AS 'fail'
  FROM  (
        SELECT  order_purchase_timestamp AS purchase_time
              , CASE WHEN order_delivered_customer_date
                         <= order_estimated_delivery_date THEN 1
                     ELSE 0 END AS yesorno
          FROM  OLIST_ORDERS_DATASET
         WHERE  STRFTIME('%Y-%m', order_purchase_timestamp) = '2017-01'
           AND  order_delivered_customer_date IS NOT NULL
           AND  order_estimated_delivery_date IS NOT NULL
        ) tmp
 GROUP  BY 1
 ORDER  BY 1;

/* 오답노트 */
-- 240409 (1): 세번째 컬럼은 fail의 수를 세야 하는데 fail이 하나라도 있으면 1을 반환하라는 줄 알았다. (뭐 - 해!)
SELECT  DATE(purchase_time) purchase_date
        , SUM(yesorno) AS 'success'
        , CASE WHEN SUM(yesorno) = COUNT(*) THEN 0 -- 그래서 성공합과 카운트가 같으면 0(모두 성공) 아니면 1 로 세고 있었다.
               ELSE 1 END AS 'fail'
  FROM  (
        SELECT  order_purchase_timestamp AS purchase_time
                , CASE WHEN DATE(order_delivered_customer_date) 
                         <= DATE(order_estimated_delivery_date) THEN 1
                       ELSE 0 END AS yesorno
          FROM  OLIST_ORDERS_DATASET
         WHERE  STRFTIME('%Y-%m', order_purchase_timestamp) = '2017-01'
           AND  order_delivered_customer_date IS NOT NULL
           AND  order_estimated_delivery_date IS NOT NULL
        ) tmp
 GROUP  BY 1
 ORDER  BY 1;

-- 240409 (2): CASE WHEN 으로 바꾸었다. 그러나 안됐다. 문제는 설마했던 서브쿼리의 WHEN으로, DATE()로 절단되어버린 날짜였다.
-- 예상 시각은 모두 0시로, 2017-01-10 00:00:00이 되어있으나 2017-01-10 20:20:20 이면 늦은 것임에도 같은 것으로 되어버린다...바보!
SELECT  DATE(purchase_time) purchase_date
        , COUNT(CASE WHEN yesorno = 1 THEN 1 END) AS 'success'
        , COUNT(CASE WHEN yesorno = 0 THEN 1 END) AS 'fail'
  FROM  (
        SELECT  order_purchase_timestamp AS purchase_time
                , CASE WHEN DATE(order_delivered_customer_date) 
                         <= DATE(order_estimated_delivery_date) THEN 1
                       ELSE 0 END AS yesorno
          FROM  OLIST_ORDERS_DATASET
         WHERE  STRFTIME('%Y-%m', order_purchase_timestamp) = '2017-01'
           AND  order_delivered_customer_date IS NOT NULL
           AND  order_estimated_delivery_date IS NOT NULL
        ) tmp
 GROUP  BY 1
 ORDER  BY 1;
