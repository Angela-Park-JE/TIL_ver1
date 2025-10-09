/*
17세 미만은 혼자 빌릴 수 없으면서, 제목이 모음으로 끝나지 않는 영화제목 출력
https://solvesql.com/problems/film-ending-with-consonant/
*/


-- 241203: rating을 IN으로 걸어도, 반대 등급을 NOT IN으로 걸어도 된다.
SELECT  title
  FROM  film
 WHERE  rating IN ('R', 'NC-17')  -- 조건1
   AND  RIGHT(title, 1) NOT IN ('A', 'E', 'I', 'O', 'U')  -- 조건2
;
