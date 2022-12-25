"""
1148. Article Views I
https://leetcode.com/problems/article-views-i/description/?envType=study-plan&id=sql-i
There is no primary key for this table, it may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
 
Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.

Input: 
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output: 
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
"""



/* mine : having을 오랜만에 썼다 부끄럽게도(?). 순간 GROUP BY를 나중에 써서 오류가 났었다. */
-- MySQL
SELECT author_id id
FROM VIEWS 
WHERE author_id = viewer_id 
GROUP BY author_id
HAVING COUNT(view_date) > 0
ORDER BY author_id;


"""다른 풀이"""
-- MySQL by.treemantan : 정말 쉽게 문제를 풀었다.

-- 1. 고유한 것만 추려도 된다.
SELECT DISTINCT author_id AS id FROM Views 
where author_id = viewer_id 
ORDER BY id;

--2. 쓴사람 본사람 같은 데이터에서 id를 가지고 group by 를 한다. 만약 다른 컬럼들도 필요할 때 쓰기 좋다.
SELECT id from (SELECT author_id AS id FROM Views 
where author_id = viewer_id 
ORDER BY id)a
GROUP BY id;

--3. 그냥 group by를 바로 써서 간단하게.
SELECT author_id AS id FROM Views 
where author_id = viewer_id 
GROUP BY id
ORDER BY id;
