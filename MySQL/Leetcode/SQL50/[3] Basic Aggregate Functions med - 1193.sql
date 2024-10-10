/*
1193. Monthly Transactions I
https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50
  Write an SQL query to find for each month and country, the number of transactions and their total amount, 
  the number of approved transactions and their total amount.
  Return the result table in any order.
  Table: Transactions
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | id            | int     |
  | country       | varchar |
  | state         | enum    |
  | amount        | int     |
  | trans_date    | date    |
  +---------------+---------+
*/


-- 241010: EXTRACT를 버릇처럼 썼다가, month 형식이 YYYY-MM 인 것을 보고 고쳤다.
SELECT  DATE_FORMAT(trans_date, '%Y-%m') AS month
      , country 
      , COUNT(id) AS trans_count 
      , SUM(IF(state = "approved", 1, 0)) AS approved_count 
      , SUM(amount) AS trans_total_amount 
      , SUM(IF(state = "approved", amount, 0)) AS approved_total_amount 
  FROM  TRANSACTIONS
 GROUP  BY  DATE_FORMAT(trans_date, '%Y-%m'), country;



/* 다른 풀이*/
-- https://leetcode.com/problems/monthly-transactions-i/solutions/5615808/easy-my-sql-solution
-- 이 방법이 내가 처음 배웠던 SQL식의 사고 방식이었던 것 같다.
SELECT LEFT(trans_date, 7) AS month,
      country, 
      COUNT(id) AS trans_count,
      SUM(state = 'approved') AS approved_count,
      SUM(amount) AS trans_total_amount,
      SUM((state = 'approved') * amount) AS approved_total_amount
FROM Transactions
GROUP BY month, country;
