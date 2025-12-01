/*
사랑과 관련된 영화 
https://solvesql.com/problems/movies-about-love/
*/


-- 251201: 조건이 쉬워서 금방 작성하는 쿼리
SELECT  title
      , year
      , rotten_tomatoes
  FROM  movies
 WHERE  title LIKE '%Love%' OR title LIKE '%love%'
 ORDER  BY 3 DESC, 2 DESC
;
