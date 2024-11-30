/*
최근 올림픽이 개최되었던 도시를 2000년 이후 개최에 한정하여 앞에서 3글자만 따서 가져와 정렬하시오
https://solvesql.com/problems/olympic-cities/
*/

-- 241130: 
SELECT  year
      , UPPER(SUBSTR(city, 0, 4)) AS city
  FROM  games
 WHERE  year>=2000
 ORDER  BY year DESC
;
