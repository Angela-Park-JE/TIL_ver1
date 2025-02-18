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


-- 250218: 해답은 되지만 TIME LIMIT EXCEEDED 걸린 ... 쿼리
SELECT  ROUND(COUNT(DISTINCT player_id) 
        / (SELECT COUNT(DISTINCT player_id) FROM Activity) , 2) AS fraction
  FROM  
        (
        SELECT  player_id
              , event_date
          FROM  Activity a1
         WHERE  event_date = (SELECT DATE_ADD(MIN(event_date), INTERVAL 1 DAY) FROM Activity a2 WHERE a1.player_id = a2.player_id GROUP BY a2.player_id)
        ) preproceedstable  -- 해당날짜가 첫번째 로그인날에+1한 날인 경우만 추출!

;



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


-- 241023: 시도 그리고 해석오류 발견!
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
--  WHERE  player_id IN (
--                         SELECT  player_id
--                         FROM  ACTIVITY
--                         GROUP  BY player_id
--                         HAVING  COUNT(event_date) > 1
--                      )
 GROUP  BY player_id
HAVING  MIN(event_date) = event_date;


-- 250218: 테스트 케이스는 통과했으나 본 케이스에서 통과가 안되었던 쿼리.
-- event_date에서 하루 더 한 날이 a2.event_date와 같은 조건으로 엮도록 한 다음 a2.event_date가 NULL이 아닌 행을 가진 유저들을 대상으로 COUNT하는 방식.
SELECT  ROUND(COUNT(DISTINCT player_id) 
        / (SELECT COUNT(DISTINCT player_id) FROM Activity) , 2) AS fraction
  FROM  
        (
        SELECT  a1.player_id
              , a1.event_date
          FROM  Activity a1 
                LEFT JOIN Activity a2 
                ON DATE_ADD(a1.event_date, INTERVAL 1 DAY) = a2.event_date
         WHERE  a2.event_date IS NOT NULL     
        ) consecutive_logined_users
 ;
-- 결국 돌고돌아 이전에 한 것처럼 돌아오나보다. 결국 LEAD나 LAG를 사용해서 일치하는지 아닌지로 확인하도록 바꾸는데,
-- LAG문은 WHERE에 사용할 수 없다고 나왔다. WHERE는 결과를 한 차례 뽑는데, LAG나 LEAD같은 WINDOW함수는 결과를 뽑은 다음 사용할 수 있어서인듯.
SELECT  player_id
    --   , LAG(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) AS
      , event_date
  FROM  Activity 
 WHERE  LAG(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) 
        = DATE_SUB(event_date, INTERVAL 1 DAY)
-- 쓸만하게 만든 쿼리 형식이다. 전날 + 1일 한 것이 당일과 같을 경우 데려오도록 한다.
-- 이제 여기에 첫 로그인 날짜가 맞는지만 확인하도록 하면 된다.
SELECT  ROUND(COUNT(DISTINCT player_id) 
        / (SELECT COUNT(DISTINCT player_id) FROM Activity) , 2) AS fraction
  FROM  
        (
        SELECT  player_id
              , DATE_ADD(LAG(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date), INTERVAL 1 DAY) AS adddate_at_previous_date
              , event_date
          FROM  Activity 
        ) preproceedstable
 WHERE  adddate_at_previous_date = event_date
 ;
-- 다시 짜고 보니 깨달았다. '첫번째 로그인 날'이라는 조건이 좀더 간단한 쿼리를 짤 수 있는 데 도움이 된다는 사실을... (해답)
SELECT  ROUND(COUNT(DISTINCT player_id) 
        / (SELECT COUNT(DISTINCT player_id) FROM Activity) , 2) AS fraction
  FROM  
        (
        SELECT  player_id
            --   , DATE_ADD(LAG(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date), INTERVAL 1 DAY) AS adddate_at_previous_date 
              , event_date
          FROM  Activity a1
         WHERE  event_date = (SELECT DATE_ADD(MIN(event_date), INTERVAL 1 DAY) FROM Activity a2 WHERE a1.player_id = a2.player_id GROUP BY a2.player_id)
        ) preproceedstable
--  WHERE  1=1
--    AND  adddate_at_previous_date = event_date
 ;
