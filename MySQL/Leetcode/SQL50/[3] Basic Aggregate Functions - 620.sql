/*-
620. Not Boring Movies
https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
  Return the result table ordered by rating in descending order.
  Table: Cinema
  +----------------+----------+
  | Column Name    | Type     |
  +----------------+----------+
  | id             | int      |
  | movie          | varchar  |
  | description    | varchar  |
  | rating         | float    |
  +----------------+----------+
-*/


-- 240816:
SELECT  *
  FROM  CINEMA
 WHERE  id %2 = 1
   AND  description NOT LIKE '%boring%' 
 ORDER  BY rating DESC;
