/*
친구취향 와인찾기
https://solvesql.com/problems/wines-for-friends/
*/


-- 251208: 친구 취향의 와인을 출력해보자. 해당 조건에 맞는 것을 찾기만 하면 돼서, 조건문을 쓰는 방법을 묻는 문제로 생각된다.
SELECT  *
  FROM  wines
 WHERE  1=1
   AND  color = 'white'
   AND  quality >= 7
   AND  density > (SELECT AVG(density) FROM wines)
   AND  residual_sugar > (SELECT AVG(residual_sugar) FROM wines)
   AND  pH < (SELECT AVG(pH) FROM wines WHERE color = 'white')
   AND  citric_acid > (SELECT AVG(citric_acid) FROM wines WHERE color = 'white')
   ;
