/*
서식지별 펭귄을 중복없이 출
https://solvesql.com/problems/inspect-penguins/
*/

-- 241202: 밤에서야 생각나서 늦게 해버린 ㅠㅠ 
-- DISTINCT로 서식지별 종을 한 개씩만 출력하도록 한다.
SELECT  DISTINCT island
      , species
  FROM  penguins
 ORDER  BY 1, 2;
