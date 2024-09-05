/*-
1729. Find Followers Count
https://leetcode.com/problems/find-followers-count/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution that will, for each user, return the number of followers.
  Return the result table ordered by user_id in ascending order.
  Table: Followers
  +-------------+------+
  | Column Name | Type |
  +-------------+------+
  | user_id     | int  |
  | follower_id | int  |
  +-------------+------+
  (user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
-*/


-- 240905: 민망할 정도로 간단한 문제(믿기지 않는 난이도...!)
-- MSSQL의 경우 GROUP BY에 컬럼명을 명시해주어야 한다(컬럼 순서 번호로는 안됨)
SELECT  user_id
      , COUNT(follower_id) AS followers_count
  FROM  FOLLOWERS
 GROUP  BY 1
 ORDER  BY 1;
