/*
데이터 포인트 x나 y가 맥스인 데이터포인트 찾기
https://solvesql.com/problems/max-row/
*/


-- 241211:  
SELECT  id
  FROM  points
 WHERE  x = (SELECT MAX(x) FROM points)
    OR  y = (SELECT MAX(y) FROM points)
 ORDER  BY 1
;
