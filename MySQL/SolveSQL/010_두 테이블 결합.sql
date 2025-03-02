/*
https://solvesql.com/problems/join/
특정 종목에 출전한 선수의 id 추리기
*/


-- 250303: DISTINCT 빼먹지 않았다.
SELECT  DISTINCT r.athlete_id AS athlete_id
  FROM  records r LEFT JOIN events e ON r.event_id = e.id
 WHERE  e.sport = 'Golf'
;
