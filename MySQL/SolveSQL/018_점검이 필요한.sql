/*
연습 문제> 점검이 필요한 자전거 찾기
https://solvesql.com/problems/inspection-needed-bike/
*/


-- 250717: 정답률이 50퍼 이하인게 조금 의아한 문제. 먼저 기한을 제한해 둔 다음 HAVING으로 조건을 건다.
SELECT  bike_id
  FROM  rental_history
 WHERE  EXTRACT(YEAR_MONTH FROM rent_at) = '202101'
 GROUP  BY  bike_id
HAVING  SUM(distance) >= 50000
;
