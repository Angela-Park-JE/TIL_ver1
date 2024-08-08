/*-
1581. Customer Who Visited but Did Not Make Any Transactions
https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50
Write a solution to find the IDs of the users who visited without making any transactions 
  and the number of times they made these types of visits.
Return the result table sorted in any order.
Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
-*/


-- 240809: 문제만 이해하면 어렵지 않은 문제였다.
SELECT  customer_id
      , COUNT(visit_id) AS count_no_trans
  FROM  VISITS
 WHERE  visit_id NOT IN (SELECT visit_id FROM TRANSACTIONS)
 GROUP  BY customer_id;
