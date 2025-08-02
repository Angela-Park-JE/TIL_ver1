/*
Advent of SQL 2024> 친구 수 집계하기 
https://solvesql.com/problems/number-of-friends/
*/


-- 250801: 엊그저께 일반 문제풀이에서 한 번 풀고 복습 겸(020 번 문제)
-- 뭔가 더 간단하게 된 느낌이다. 
WITH 
  all_edges AS  -- 모든 친구 관계 목록
  (
    SELECT  user_a_id, user_b_id
      FROM  edges
    UNION ALL
    SELECT  user_b_id, user_a_id
      FROM  edges
  )
  ,
  all_users AS  -- 모든 유저 목록
  (
    SELECT  user_id
      FROM  users 
    UNION
    SELECT  DISTINCT user_a_id
      FROM  all_edges
  )

SELECT  user_id
      , COUNT(user_b_id) AS num_friends
  FROM  all_users u 
        LEFT JOIN all_edges e 
        ON u.user_id = e.user_a_id
 GROUP  BY 1
 ORDER  BY 2 DESC, 1
;
