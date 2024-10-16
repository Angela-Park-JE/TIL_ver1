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

-- 241016:
SELECT  
  FROM  DELIVERY
