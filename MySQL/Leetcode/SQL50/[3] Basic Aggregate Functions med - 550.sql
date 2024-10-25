/*
550. Game Play Analysis IV
https://leetcode.com/problems/game-play-analysis-iv/?envType=study-plan-v2&envId=top-sql-50
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
  Table: Activity
  +--------------+---------+
  | Column Name  | Type    |
  +--------------+---------+
  | player_id    | int     |
  | device_id    | int     |
  | event_date   | date    |
  | games_played | int     |
  +--------------+---------+
  (player_id, event_date) is the primary key
*/



/*오답노트*/
-- 241022: WHERE 절에서 event_date가 연달아 있는지를 검사하고 싶었다. 하지만 완전히 틀린 쿼리ㅠㅠ
SELECT  player_id
      , event_date
  FROM  ACTIVITY
 WHERE  player_id IN (
                        SELECT  player_id
                        FROM  ACTIVITY
                        GROUP  BY player_id
                        HAVING  COUNT(event_date) > 1
                     )
--    AND  ( event_date = LAG(event_date, 1) OR event_date = LEAD(event_date, 1) )
   AND  event_date IN (LAG(event_date, 1)|LEAD(event_date, 1));

-- 241023: 
-- " logged in again on the day after the day they first logged in " so MIN(event_date)
-- 첫 로그인 다음 날에도 로그인을 한 사람의 비율을 구하는 것이 문제이다.
-- group by를 처음부터 붙이면 LEAD(event_date, 1)의 의미가 없어진다.
-- 따라서 WHERE를 붙이고 검색하면 우선 2번이상 접속한 사람 중 이어서 접속한 사람은 뜬다.
-- 하지만, 어차피 "PARTITION BY player_id ORDER BY event_date"를 하기 때문에 유저별 2회 이상 접속을 검색할 필요는 없다.
-- 따라서 WHERE로 검색했던 "HAVING COUNT(event_date) > 1"은 필요가 없어진다.
-- 그럼 이제 첫 event_date인지 아닌지 검사하는 것을 한 뒤
-- 모든 player_id 중 몇 명인지 집계하면 될 것 같다.
SELECT  player_id
      , event_date
      , CASE WHEN event_date = LEAD(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) -1 THEN 1 ELSE 0 END AS next_date
  FROM  ACTIVITY
 GROUP  BY player_id
HAVING  MIN(event_date) = event_date;
