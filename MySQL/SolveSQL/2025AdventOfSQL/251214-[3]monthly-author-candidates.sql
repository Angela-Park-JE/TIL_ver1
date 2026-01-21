/*
조건에 맞는 후보 작가 산출
https://solvesql.com/problems/monthly-author-candidates/
*/


-- 251225: 조건 안에 서브쿼리로 리스트를 만들어 두도록 했다.
SELECT  DISTINCT author
  FROM  books b1  
 WHERE  1=1
   AND  genre = 'Fiction'
   AND  name IN (SELECT name FROM books GROUP BY name HAVING COUNT(*) >= 2)
   AND  (SELECT AVG(user_rating) FROM books b2 WHERE b1.author = b2.author GROUP BY author) >= 4.5
   AND  author IN
              (
              SELECT  author
                FROM  books
               GROUP  BY author
              HAVING  AVG(reviews) >= (SELECT AVG(reviews) FROM books WHERE genre = 'Fiction')
              )

 ORDER  BY 1
  ;
