/*
그래서 도시별 VIP 찾기인데... 이게 도시별로 찾는게 맞나 싶음
https://solvesql.com/problems/vip-of-cities/
*/


/*풀이과정*/
-- 251224: 260331
-- -- 우선 도시별, 고객별, 총 주문 금액을 구한다
-- SELECT  city_id
--       , customer_id
--       , SUM(total_price) AS total
--       , RANK() OVER (PARTITION BY city_id ORDER BY SUM(total_price) DESC) AS ranks -- 최고 매출 고객 번호
--   FROM  transactions
--  WHERE  1=1
--    AND  is_returned = 0
--    AND  is_online_order = 0
--  GROUP  BY city_id, customer_id
-- ;

-- 해당 테이블에서 도시별로 window를 만들고 total이 제일 큰 row를 'ranks'를 통해 가져오도록 한다.
SELECT  city_id
      , customer_id
      , total_spent
  FROM  
        (
          SELECT  city_id
                , customer_id
                , SUM(total_price - discount_amount) AS total_spent -- 순매출
                , RANK() OVER (PARTITION BY city_id ORDER BY SUM(total_price - discount_amount) DESC) AS ranks -- 최고 매출 고객 번호
            FROM  transactions
           WHERE  1=1
             AND  is_returned = 0
             AND  is_online_order = 0
           GROUP  BY 1, 2
        ) total_spent_amount_by_city_ctm
 WHERE  ranks = 1
 ;

-- 그러나 이것은 답이 아니었는데, 고객별 순매출을 집계하고 도시별 최고 순매출 고객을 꼽으라고 한다.
-- 보니까 한 고객이 다른 곳에서도 사는 경우가 많던데, 도시별로 집계를 하면 안된다는 소리인가? (근데 1번 지역은 395번님이 맞긴 하는 것 같음)
-- 그럼 어떤 이유에서 1번 지역에선 395번이 맞는걸까?
-- -> 가. 1번 지역에서는 395번이 구매 총액이 제일 높다. / 나. 395번은 다른 지역보다 1번 지역에서 구매를 가장 많이 했다.
