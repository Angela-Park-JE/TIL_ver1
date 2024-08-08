/*-
1068. Product Sales Analysis I
https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
  Return the resulting table in any order.
  Table: Sales
  +-------------+-------+
  | Column Name | Type  |
  +-------------+-------+
  | sale_id     | int   |
  | product_id  | int   |
  | year        | int   |
  | quantity    | int   |
  | price       | int   |
  +-------------+-------+
  Table: Product
  +--------------+---------+
  | Column Name  | Type    |
  +--------------+---------+
  | product_id   | int     |
  | product_name | varchar |
  +--------------+---------+
-*/


-- 240808
SELECT  p.product_name
      , s.year
      , s.price
  FROM  SALES s LEFT JOIN PRODUCT p ON s.product_id = p.product_id;
