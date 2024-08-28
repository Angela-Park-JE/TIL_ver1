/*-
1633. Percentage of Users Attended a Contest
https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
  Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
  Table: Users
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | user_id     | int     |
  | user_name   | varchar |
  +-------------+---------+
  Table: Register
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | contest_id  | int     |
  | user_id     | int     |
  +-------------+---------+
-*/


-- 240828: USERS table을 FROM 에서 사용하는 것보다 이게 훨씬 빠르다.
SELECT  contest_id
      , ROUND(COUNT(DISTINCT user_id)
                /(SELECT COUNT(DISTINCT user_id) FROM USERS)*100, 2) AS percentage
  FROM  REGISTER r
 GROUP  BY contest_id
 ORDER  BY 2 DESC, 1 ASC; 
