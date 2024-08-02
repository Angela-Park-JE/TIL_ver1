/*-
problem set - SQL50 (https://leetcode.com/studyplan/top-sql-50/)
1757. Recyclable and Low Fat Products [Easy]
https://leetcode.com/problems/recyclable-and-low-fat-products/
  Write a solution to find the ids of products that are both low fat and recyclable.
  Return the result table in any order.
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | product_id  | int     |
  | low_fats    | enum    |
  | recyclable  | enum    |
  +-------------+---------+
-*/


-- 240802
SELECT  product_id
  FROM  PRODUCTS
 WHERE  low_fats = 'Y' 
   AND  recyclable = 'Y';
