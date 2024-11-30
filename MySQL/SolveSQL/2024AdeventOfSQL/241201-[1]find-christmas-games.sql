/*
크리스마스나 산타라는 이름이 들어가는 게임 찾기 for 조카 in 크리스마스
https://solvesql.com/problems/find-christmas-games/
*/


-- 241201
SELECT  game_id
      , name
      , year
  FROM  GAMES 
 WHERE  name LIKE '%Christmas%'
    OR  name LIKE '%Santa%'
;
