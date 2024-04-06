/* 
연습 문제> 복수 국적 메달 수상한 선수 찾기
https://solvesql.com/problems/multiple-medalist/
*/

-- 240406: id가 나누어져있다보니 컬럼들 연결해서 보는데 시간이 조금 걸렸다. 
-- 테이블-컬럼 정보를 메모장에 옮겨두고 보면서 조인할 것을 적어놓고 시작하니 그래도 금방 끝났다.
-- 그리고 한 가지 더, medal은 빈 선수들도 많다^^ 획득한 메달 정보들이 있대서 당연히 수상한 선수들만 있는줄... 레벨3 딱 맞는것 같음
SELECT a.name
  FROM RECORDS r 
       LEFT JOIN GAMES g ON r.game_id = g.id
       LEFT JOIN ATHLETES a ON r.athlete_id = a.id
       LEFT JOIN TEAMS t ON r.team_id = t.id
 WHERE 1=1
       AND g.year >= 2000 
       AND r.medal IS NOT NULL
 GROUP BY a.id
HAVING COUNT(DISTINCT t.id)>=2
 ORDER BY 1 ASC;
