/*-
1141. User Activity for the Past 30 Days I
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
  A user was active on someday if they made at least one activity on that day.
  Return the result table in any order.
  Table: Activity
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | user_id       | int     |
  | session_id    | int     |
  | activity_date | date    |
  | activity_type | enum    |
  +---------------+---------+
-*/


-- 240902: BETWEEN 0 AND 29는 된다 (Editorial 참고)
SELECT  activity_date AS day
      , COUNT(DISTINCT user_id) AS active_users 
  FROM  ACTIVITY 
 WHERE  DATEDIFF('2019-07-27', activity_date) BETWEEN 0 AND 29
 GROUP  BY activity_date;



/* 오답노트 */
-- BETWEEN은 먹지 않는다. 30일로 해도 29일로 해도 안된다. 2019-06-25일이 출력되는 문제가 있다.
-- 말하자면 정확히 전달 27일부터 출력되도록 하는 것 같은데, 문제에서 30 days라고 정해준 것에 문제가 있다.
-- 실제로 comment들을 보면 문제를 명확히 쓰던지 문제를 지워달라고 하는 것을 보니 나만 겪은 문제가 아닌 것 같다.
SELECT  activity_date AS day
      , COUNT(DISTINCT user_id) AS active_users 
  FROM  ACTIVITY 
 WHERE  activity_date BETWEEN '2019-07-27' -29  AND '2019-07-27'
 GROUP  BY activity_date;
