/*-
1148. Article Views I [Easy]
https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find all the authors that viewed at least one of their own articles.
  Return the result table sorted by id in ascending order.
  The result format is in the following example.
  
  Table: Views
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | article_id    | int     |
  | author_id     | int     |
  | viewer_id     | int     |
  | view_date     | date    |
  +---------------+---------+
-*/


-- 240804: 실행 속도가 중앙값보다 느리게 나오는데 더 나은 방법은 없을까?
SELECT  DISTINCT author_id AS id
  FROM  VIEWS
 WHERE  author_id = viewer_id
 ORDER  BY 1;
