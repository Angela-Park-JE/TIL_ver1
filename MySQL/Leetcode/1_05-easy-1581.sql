"""
1581. Customer Who Visited but Did Not Make Any Transactions
https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/
Write an SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
Return the result table sorted in any order.

Input: 
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
"""


/* mine : 잠시 헤멨음 이게 무슨 말이야 했다가 안온 사람 세야한 다는 것을 다시 보고 알았다. 문제와 데이터를 제대로 아는게 중요. 
    UNION 문제라고 써있는데 유니온이 필요가 없다. */

-- MySQL 
SELECT v.customer_id, COUNT(v.customer_id) count_no_trans
FROM TRANSACTIONS t RIGHT JOIN VISITS v ON t.visit_id = v.visit_id
WHERE v.visit_id NOT IN (SELECT visit_id FROM TRANSACTIONS)
GROUP BY 1;



"""다른 풀이"""

-- MySQL by.AleksandrEfimenko : LEFT로 visit 에 붙이되 IS NULL로 'transaction_id'을 찾았다. 나와 방식은 같으나 반대로 한 것.
SELECT customer_id, COUNT(v.visit_id) as count_no_trans 
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id

-- MySQL : 같은 사람 것인데, 굳이 조인을 하지 않고 찾았다. 어차피 없는 것을 찾는 것이기 떄문이다. 결국 찾는건 customer_id이고.
SELECT customer_id, COUNT(visit_id) as count_no_trans 
FROM Visits
WHERE visit_id NOT IN (
	SELECT visit_id FROM Transactions
	)
GROUP BY customer_id

-- MySQL : NOT EXISTS 를 활요한다. WHERE 절에서 NOT EXSIT를 사용하면서 조인을 그 안의 쿼리에서 작동하도록 했다. 
-- 그래서 거래에 방문아이디가 없는 경우를 찾는 방식이다.
SELECT customer_id, COUNT(visit_id) as count_no_trans 
FROM Visits v
WHERE NOT EXISTS (
	SELECT visit_id FROM Transactions t 
	WHERE t.visit_id = v.visit_id
	)
GROUP BY customer_id
