/*
어떤 카테고리를 사러 첫 주문을 하게 되는걸까
https://solvesql.com/problems/first-order-category/
*/


/*풀이과정*/
-- 251217: 260316
-- SELECT  *
--   FROM  customer_stats cs 
--         LEFT JOIN records r
--         ON cs.customer_id = r.customer_id AND cs.first_order_date = DATE(r.order_date)
--  ORDER  BY cs.first_order_date 
--   LIMIT 100
-- ;

-- "모든 카테고리와 서브 카테고리의 조합에 대해"
-- > category 와 sub_category를 묶어 하나의 category로 만든 뒤 출력할 때 나누는게 좋을 것 같음.
-- > 왜냐면 category 별 및 sub_category 별 각각의 첫 구매 주문건수가 아니라 결국 sub_category 별이니까
-- > 그렇지만 이걸 그냥 GROUP BY에 넣으면 되잖아 바보야... 간단하게 끝날걸 돌아갈뻔!

SELECT  category
      , sub_category
      , COUNT(DISTINCT cs.customer_id) AS cnt_orders
  FROM  customer_stats cs 
        LEFT JOIN records r
        ON cs.customer_id = r.customer_id AND cs.first_order_date = DATE(r.order_date)
 GROUP  BY 1, 2
 ORDER  BY 3 DESC
;
