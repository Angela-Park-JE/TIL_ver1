/*
1341. Movie Rating
https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50
  Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
  Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/


-- 241110:
(
SELECT  name AS results  
  FROM  MOVIERATING r 
        LEFT JOIN USERS u ON u.user_id = r.user_id
 GROUP  BY r.user_id 
 ORDER  BY COUNT(rating) DESC, 1 ASC  LIMIT 1
)
UNION ALL
(
SELECT  (SELECT title FROM MOVIES m WHERE m.movie_id = r.movie_id)
  FROM  MOVIERATING r
 WHERE  EXTRACT(YEAR_MONTH FROM created_at) = 202002
 GROUP  BY movie_id
 ORDER  BY AVG(rating) DESC, 1 ASC  LIMIT 1
);



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

-- 241109: 테스트 케이스 6에서 문제가 생겨 다시 보았다.
-- 단순히 평점 테이블에서 가장 큰 rating을 한 user 중 asc를 때린건데 제대로 나오지 않는다. 설마 이것도 feb2020이어야 하는걸까?
-- SELECT 절에서 고른다음 ASC를 해서 그런거라 생각하고 제대로 안시조인을 하도록 했다. 
-- 그러나 결과는 마찬가지로 안됐다. 그리고 문제를 깨달았다. 사람 뽑는 기준이 평점을 높게준 사람이 아니라 많은 영화를 평가한 사람이었던 것.
(
SELECT  name AS results  
  FROM  MOVIERATING r 
        LEFT JOIN USERS u ON u.user_id = r.user_id
 WHERE  rating = (SELECT MAX(rating) FROM MOVIERATING)
 ORDER  BY 1 ASC  LIMIT 1
)
UNION 
(
SELECT  (SELECT title FROM MOVIES m WHERE m.movie_id = r.movie_id)
  FROM  MOVIERATING r
 WHERE  EXTRACT(YEAR_MONTH FROM created_at) = 202002
 GROUP  BY movie_id
 ORDER  BY AVG(rating) DESC, 1 ASC  LIMIT 1
);

-- 241110: 사람 이름을 꼽는 기준은 greatest number of movies. 이다. 
-- But 테스트 케이스 18에서 문제가 생겼다. 영화이름도 유저이름도 같은 상황에서 rating table이 한 개만 있을 때 답은 두 줄이 나와야 하는데 한 줄만 나온다.
-- 따라서 아래와 달 UNION ALL 을 사용해야 한다.
(
SELECT  name AS results  
  FROM  MOVIERATING r 
        LEFT JOIN USERS u ON u.user_id = r.user_id
 GROUP  BY r.user_id 
 ORDER  BY COUNT(rating) DESC, 1 ASC  LIMIT 1
)
UNION 
(
SELECT  (SELECT title FROM MOVIES m WHERE m.movie_id = r.movie_id)
  FROM  MOVIERATING r
 WHERE  EXTRACT(YEAR_MONTH FROM created_at) = 202002
 GROUP  BY movie_id
 ORDER  BY AVG(rating) DESC, 1 ASC  LIMIT 1
);
