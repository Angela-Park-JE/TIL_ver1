/*
누락된 정보가 있는 게임
https://solvesql.com/problems/predict-game-scores-1/
*/


-- 241211: 밀린거 푸는 중 이건 어려울 것 없었다 오히려 이게 2단계 아니냐고 ㅜ
WITH CTE AS ( 
SELECT  genre_id
      , ROUND(AVG(critic_score), 3) AS acs
      , CEIL(AVG(critic_count)) AS acc
      , ROUND(AVG(user_score), 3) AS aus
      , CEIL(AVG(user_count)) AS auc
  FROM  games
 GROUP  BY genre_id
)  -- 먼저 누락된 값을 채울 정보를 만들어 둔다

SELECT  game_id
      , name
      , IFNULL(critic_score, acs) AS critic_score
      , IFNULL(critic_count, acc) AS critic_count
      , IFNULL(user_score, aus) AS user_score
      , IFNULL(user_count, auc) AS user_count
  FROM  games, CTE
 WHERE  games.genre_id = CTE.genre_id
   AND  year >= 2015
   AND  critic_score+critic_count+user_score+user_count IS NULL  -- 하나라도 누락이 있으면 NULL
 ORDER  BY  1
 ;
