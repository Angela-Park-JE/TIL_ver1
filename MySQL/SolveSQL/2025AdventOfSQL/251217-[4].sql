/*
어떤 카테고리를 사러 첫 주문을 하게 되는걸까
https://solvesql.com/problems/first-order-category/
*/


/*풀이과정*/
-- 251217: 260316
SELECT  *
  FROM  customer_stats cs 
        LEFT JOIN records r
        ON cs.first_order_date = DATE(order_date)
      LIMIT 100

-- "모든 카테고리와 서브 카테고리의 조합에 대해 "
-- > category 와 sub_category를 묶어 하나의 category로 만든 뒤 출력할 때 나누는게 좋을 것 같음.
-- > 왜냐면 category 별 및 sub_category 별 각각의 첫 구매 주문건수가 아니라 결국 sub_category 별이니까
