/*
퍼블리셔로 참가한 작품이 10개 이상인 회사이름 출력
https://solvesql.com/problems/publisher-with-many-games/
*/


-- 241206: 어려울 것 없다.
SELECT  c.name
  FROM  games g LEFT JOIN companies c ON g.publisher_id = c.company_id
 GROUP  BY c.company_id
HAVING  COUNT(g.game_id) >= 10
;
