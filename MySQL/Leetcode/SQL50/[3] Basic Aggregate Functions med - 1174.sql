/*
1174. Immediate Food Delivery II
https://leetcode.com/problems/immediate-food-delivery-ii/?envType=study-plan-v2&envId=top-sql-50
  If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
  The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
  Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
  Table: Delivery
  +-----------------------------+---------+
  | Column Name                 | Type    |
  +-----------------------------+---------+
  | delivery_id                 | int     |
  | customer_id                 | int     |
  | order_date                  | date    |
  | customer_pref_delivery_date | date    |
  +-----------------------------+---------+
*/


-- 241019: 먼저 아이디별 최초 오더를 구한 다음, JOIN으로 알맞은 customer_pref_delivery_date 을 찾아 붙여주면서 그 아이디별로 immediate order면 1, 아니면 0을 준다.
-- 그리고 그 결과를 바탕으로 AVG와 ROUND로 정답 구하기. join이랑 서브쿼리 안쓰고 싶었다...
SELECT  ROUND(AVG(immediates)*100, 2) AS immediate_percentage  
  FROM  (
            SELECT  tmp.customer_id
                  , SUM(IF(first_order = customer_pref_delivery_date, 1, 0)) /COUNT(delivery_id) AS immediates
              FROM  DELIVERY d
                    RIGHT JOIN ( 
                            SELECT  customer_id
                                  , MIN(order_date) AS first_order
                              FROM  DELIVERY
                             GROUP  BY customer_id
                            ) tmp ON d.customer_id = tmp.customer_id AND d.order_date = tmp.first_order
             GROUP  BY d.customer_id
         ) tmp2
--  GROUP  BY customer_id
 ;



/*오답노트*/

-- 241017: 오답이다. 처음에는 HAVING에서 MIN = order_date를 했었는데 그렇게 하면 첫 주문이 immediate가 아닌 사람은 아예 집계 대상이 제외된다.
-- 이것은 그 부분을 해결한 쿼리이다. 그러나 test case2에선가 안 된다.
SELECT  ROUND(AVG(immediates)*100, 2) AS immediate_percentage 
  FROM  (
        SELECT  customer_id
              , SUM(IF(first_order = customer_pref_delivery_date, 1, 0)) /COUNT(delivery_id) AS immediates
          FROM  (
                SELECT  customer_id, MIN(order_date) AS first_order, customer_pref_delivery_date, delivery_id
                  FROM  DELIVERY
                 GROUP  BY customer_id
                ) tmp
         GROUP  BY customer_id
        ) tmp2;
