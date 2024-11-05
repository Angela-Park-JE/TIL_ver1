/*
1341. Movie Rating
https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50
  Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
  Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/



/*오답노트*/
-- 241103: max rating이 둘 이상일 경우 제대로 집계되지 않는다.
(
SELECT  (SELECT name FROM USERS u WHERE u.user_id = r.user_id) AS results
  FROM  MOVIERATING r
 GROUP  BY user_id
 ORDER  BY MAX(rating) DESC, 1 ASC  LIMIT 1
)
UNION 
(
SELECT  (SELECT title FROM MOVIES m WHERE m.movie_id = r.movie_id)
  FROM  MOVIERATING r
 WHERE  EXTRACT(YEAR_MONTH FROM created_at) = 202002
 GROUP  BY movie_id
 ORDER  BY AVG(rating) DESC, 1 ASC  LIMIT 1
);
