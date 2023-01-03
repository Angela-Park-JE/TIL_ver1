"""
1050. Actors and Directors Who Cooperated At Least Three Times
https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/?envType=study-plan&id=sql-i
Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
Return the result table in any order.
Input: 
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output: 
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
"""



/*- mine : 간단한 문제. HAVING 으로 필터링 해주면 된다! -*/

-- MySQL 
SELECT actor_id, director_id
FROM ACTORDIRECTOR 
GROUP BY actor_id, director_id
HAVING COUNT('timestamp') >= 3;



"""다른 풀이"""

-- MySQL by.joyjiang : WINDOW를 사용한 서브쿼리를 만들어서 풀었다. 물롬 서브쿼리를 쓸 거면 GROUP BY 하고 COUNT(timestamp) 해도 될 것.
SELECT DISTINCT(actor_id), director_id
FROM(
SELECT actor_id, director_id , COUNT(timestamp) OVER (Partition by actor_id, director_id) as number_of_times
FROM ActorDirector) AS temp
WHERE number_of_times >= 3
