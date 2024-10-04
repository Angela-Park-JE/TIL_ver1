/*
1934. Confirmation Rate
https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50
The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. 
The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
Write a solution to find the confirmation rate of each user.
Return the result table in any order.
  Table: Signups
  +----------------+----------+
  | Column Name    | Type     |
  +----------------+----------+
  | user_id        | int      |
  | time_stamp     | datetime |
  +----------------+----------+
  Table: Confirmations
  +----------------+----------+
  | Column Name    | Type     |
  +----------------+----------+
  | user_id        | int      |
  | time_stamp     | datetime |
  | action         | ENUM     |
  +----------------+----------+
  (user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
*/


-- 241002: 복잡한 문제는 아닌데 어떻게 구현을 할 것인가 생각이 필요한 문제였다. 
-- 먼저 confirmed를 유저별로 1, 0을 해놓고 rate를 구한 다음, IFNULL로 CONFIRMATIONS에 없는 유저를 처리했다. 
-- WINDOW 함수를 이용하는 방법은 없을까 잠깐 고민했었다.
-- 다음은 수정한 후
SELECT  s.user_id
      , IFNULL(tmp.con_rate,0) AS confirmation_rate
  FROM  SIGNUPS s LEFT JOIN 
        (
        SELECT  user_id 
              , ROUND(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END)
                        /COUNT(action), 2) con_rate
          FROM  CONFIRMATIONS
         GROUP  BY user_id
        ) tmp 
        ON s.user_id = tmp.user_id;
-- 다음은 수정 전 로직을 짰던 쿼리이다.
SELECT  s.user_id
      , IFNULL(tmp.con_rate,0) AS confirmation_rate
  FROM  SIGNUPS s LEFT JOIN 
        (
        SELECT  user_id 
              , ROUND(SUM(c.con)/COUNT(c.con), 2) con_rate
          FROM  
                (
                SELECT  user_id
                      , CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END AS con
                  FROM  CONFIRMATIONS 
                ) c
        GROUP  BY user_id
        ) tmp 
        ON s.user_id = tmp.user_id;
