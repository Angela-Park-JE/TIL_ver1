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

