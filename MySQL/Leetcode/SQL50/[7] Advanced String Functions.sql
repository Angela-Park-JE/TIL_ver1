/*
1327. List the Products Ordered in a Period
https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
  Return the result table in any order.
  Table: Products
  +------------------+---------+
  | Column Name      | Type    |
  +------------------+---------+
  | product_id       | int     |
  | product_name     | varchar |
  | product_category | varchar |
  +------------------+---------+
  Table: Orders
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | product_id    | int     |
  | order_date    | date    |
  | unit          | int     |
  +---------------+---------+
  This table may have duplicate rows.
  product_id is a foreign key (reference column) to the Products table.
*/


-- 241113: 크게 어려울 것 없어서 쓰면서 해결해도 될 정도의 난이도. 사실 카테고리를 잘 모르겠다.
-- 한번에 97.3 beats 나온 정도면 준수한 코드인 것으로 생각된다.
-- 근데 duplicate rows 가 많다고 했는데 문제 없이 된 이유는... 뭘까...? group by가 중복을 제외하고 해주느게 아닌데
SELECT  p.product_name AS product_name
      , SUM(unit) AS unit
  FROM  ORDERS o 
        LEFT JOIN PRODUCTS p ON o.product_id = p.product_id
 WHERE  EXTRACT(YEAR_MONTH FROM o.order_date) = '202002'
 GROUP  BY o.product_id
HAVING  SUM(unit) >= 100
;
