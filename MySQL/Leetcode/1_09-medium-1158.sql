"""
1158. Market Analysis I
Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.
Return the result table in any order.
Input: 
Users table:
+---------+------------+----------------+
| user_id | join_date  | favorite_brand |
+---------+------------+----------------+
| 1       | 2018-01-01 | Lenovo         |
| 2       | 2018-02-09 | Samsung        |
| 3       | 2018-01-19 | LG             |
| 4       | 2018-05-21 | HP             |
+---------+------------+----------------+
Orders table:
+----------+------------+---------+----------+-----------+
| order_id | order_date | item_id | buyer_id | seller_id |
+----------+------------+---------+----------+-----------+
| 1        | 2019-08-01 | 4       | 1        | 2         |
| 2        | 2018-08-02 | 2       | 1        | 3         |
| 3        | 2019-08-03 | 3       | 2        | 3         |
| 4        | 2018-08-04 | 1       | 4        | 2         |
| 5        | 2018-08-04 | 1       | 3        | 4         |
| 6        | 2019-08-05 | 2       | 2        | 4         |
+----------+------------+---------+----------+-----------+
Items table:
+---------+------------+
| item_id | item_brand |
+---------+------------+
| 1       | Samsung    |
| 2       | Lenovo     |
| 3       | LG         |
| 4       | HP         |
+---------+------------+
Output: 
+-----------+------------+----------------+
| buyer_id  | join_date  | orders_in_2019 |
+-----------+------------+----------------+
| 1         | 2018-01-01 | 1              |
| 2         | 2018-02-09 | 2              |
| 3         | 2018-01-19 | 0              |
| 4         | 2018-05-21 | 0              |
+-----------+------------+----------------+
"""


/*- mine: 무슨 문제인지 4가 곱한 답이 자꾸 나오더니 새로고침하고 되었다. 
   Leetcode가 전체적으로 깔끔하고 빠른건 좋은데 이런 문제가 있는 것 같다. 가끔 다음 문제로 넘어가도 데이터가 이전 문제 그대로 되어있어서 테이블을 찾을 수 없다거나 하는...
   아무튼, "IFNULL 사용법을 잘 못해서 이렇게 서브쿼리를 이용하고 NULL을 세는 방식"으로 밖에 하지 못했다. -*/

-- MySQL 
SELECT u.user_id buyer_id, u.join_date, IFNULL(tmp.orders_in_2019, 0) orders_in_2019
FROM
    (
    SELECT u.user_id, COUNT(o.order_id) orders_in_2019
    FROM USERS u LEFT JOIN ORDERS o ON u.user_id = o.buyer_id
    WHERE YEAR(o.order_date) = 2019
    GROUP BY u.user_id
    ) tmp RIGHT JOIN USERS u ON tmp.user_id = u.user_id;



"""다른 풀이"""

-- MySQL by.kshitijarora96 : 이 사람이 잘 써두었는데, 
-- https://leetcode.com/problems/market-analysis-i/solutions/2319471/simple-in-depth-explanation-of-where-and-is-null/?envType=study-plan&id=sql-i&orderBy=most_votes
SELECT u.user_id as buyer_id, u.join_date, count(o.order_id) as 'orders_in_2019'
FROM users u
LEFT JOIN Orders o
ON o.buyer_id=u.user_id AND YEAR(order_date)='2019'
GROUP BY u.user_id;
'''
ISNULL 체크를 하지 않는 이유: FROM에서 모든 유저를 선택해서, LEFT JOIN을 한다. 그리고 COUNT는 세고 없으면 0을 반환게 되기 때문.
더 중요한것! WHERE에서 안쓰고 조인 조건에 YEAR를 쓴 이유 : SQL 에서 명령어가 처리 되는 순서는 다음과 같다
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY ,
그래서 GROUP BY 나 SELECT 에서 세기 전에 WHERE에서 레코드를 지워버리기 때문에 아예 안나오게 된다.
'''



"""오답노트"""

-- 일단 IFNULL 을 쓰려고 했었는데, order_date 가 2019 가 아닌 것들이 아예 뜨지 않는 오류가 발생.
SELECT u.user_id buyer_id, u.join_date, 
       IFNULL(COUNT(o.order_id), 0) orders_in_2019
FROM USERS u LEFT JOIN ORDERS o ON u.user_id = o.buyer_id, ITEMS i
WHERE 1=1
  AND o.item_id = i.item_id
  AND YEAR(o.order_date) = 2019
GROUP BY o.buyer_id;
