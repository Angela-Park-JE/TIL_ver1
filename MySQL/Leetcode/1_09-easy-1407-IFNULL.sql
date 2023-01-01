"""
1407. Top Travellers
https://leetcode.com/problems/top-travellers/description/?envType=study-plan&id=sql-i
Write an SQL query to report the distance traveled by each user.
Return the result table ordered by travelled_distance in descending order, 
if two or more users traveled the same distance, order them by their name in ascending order.
- USER 
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
name is the name of the user.
- RIDES
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| user_id       | int     |
| distance      | int     |
+---------------+---------+
id is the primary key for this table.
user_id is the id of the user who traveled the distance "distance".
"""



/*- mine : RIDES 기록에 없는 사람은 0 처리가 아니라 NULL 처리 되기 때문에 CASE WHEN을 사용하는 방법 뿐이었다.! -*/
-- MySQL
SELECT u.name, 
        CASE WHEN u.id NOT IN (SELECT user_id FROM RIDES) THEN 0
             ELSE SUM(r.distance) 
        END travelled_distance
FROM RIDES r RIGHT JOIN USERS u ON r.user_id = u.id
GROUP BY r.user_id
ORDER BY 2 DESC, 1;



"""다른 답안"""

-- MySQL by.Ginny47 : IFNULL 이라는 좋은 것이 있었다 나는 바보야 
select u.name, ifnull(sum(r.distance), 0) as travelled_distance
from users u
left join rides r
on u.id = r.user_id
group by r.user_id
order by travelled_distance desc, u.name asc



"""오답노트"""

-- LEFT JOIN 을 했더니 거리가 0인 사람이 결과에 나오지 않았다. (0인 사람은 왜 있는거야...ㅠ)
SELECT u.name, SUM(r.distance) travelled_distance
FROM RIDES r LEFT JOIN USERS u ON r.user_id = u.id
GROUP BY r.user_id
ORDER BY 2 DESC, 1;


