/*
펭귄의 종과 몸무게
https://solvesql.com/problems/species-and-mass-of-penguins/
*/


-- 251203: 문제가 어려운 것은 한 가지도 없다. 다만 두 컬럼 모두 null 이 아닌 데이터를 대상으로 한대서 아이디어를 내보았다.
SELECT  species
      , body_mass_g
  FROM  penguins
 WHERE  ISNULL(species) + ISNULL(body_mass_g) = 0
 ORDER  BY 2 DESC, 1
 ;
