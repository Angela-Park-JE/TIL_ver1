/*
https://solvesql.com/problems/blog-counter/
특정 기간동안 이벤트가 있다면 방문한것으로 집계하는 쿼리
*/


-- 250302
SELECT  event_date_kst AS dt 
      , COUNT(DISTINCT user_pseudo_id) AS users
  FROM  ga
 WHERE  event_date_kst BETWEEN '2021-08-02' AND '2021-08-09'
 GROUP  BY event_date_kst
;
