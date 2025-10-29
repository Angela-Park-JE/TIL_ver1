/*
Page With No Likes
Facebook SQL Interview Question
https://datalemur.com/questions/sql-page-with-no-likes
*/


-- 251029: 테이블 파악부터 작성까지 이렇게 쉬운 문제가 나오기도 하는구나 했다!
SELECT  page_id 
  FROM  pages
 WHERE  page_id NOT IN (SELECT DISTINCT page_id FROM page_likes)
;
