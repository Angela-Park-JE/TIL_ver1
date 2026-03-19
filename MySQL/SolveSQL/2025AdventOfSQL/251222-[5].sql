/*
하루만 주문이 밀려도 어떻게 되는지 볼까
https://solvesql.com/problems/cumulative-orders/
*/


-- 251222:260320
-- 그래도 한 번에!
SELECT  order_date
      , weekday
      , num_orders_today
      , SUM(num_orders_today) OVER (ORDER BY order_date ASC 
                                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS num_orders_from_yesterday -- order_date로 오름차순, 하나 전부터 현재 로우까지 SUM
  FROM 
      ( 
          SELECT  DATE_FORMAT(purchased_at, '%Y-%m-%d') AS order_date
                , DAYNAME(purchased_at) AS 'weekday'                                  -- DAYNAME!
                , COUNT(DISTINCT transaction_id) AS num_orders_today
            FROM  transactions
           WHERE  1=1
             AND  EXTRACT(YEAR_MONTH FROM purchased_at) IN ('202311', '202312')       -- 근데 11월 1일의 경우 10월 31일을 포함해야 하면 그냥 10월까지 포함한 뒤에 메인 쿼리에서 계산한 다음 한 번 더 감싸면서 날짜 처리 해줘야 함
             AND  is_online_order = 1
           GROUP  BY 1, 2
      ) AS orders_by_day
 ORDER  BY order_date
;
