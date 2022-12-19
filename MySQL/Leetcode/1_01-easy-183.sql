"""
183. Customers Who Never Order
https://leetcode.com/problems/customers-who-never-order/description/?envType=study-plan&id=sql-i
Write an SQL query to report all customers who never order anything.
Return the result table in any order.

Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
"""



/* mine : 바로 맞았지만, 실행시간이 우수한 성능을 보이지 못했다. 하위 18.72%라니... 하면서 다른 답들은 어떨까 둘러보러 갔지만 다 같은 답이었다. ...? */

-- MySQL
SELECT name AS customers
FROM CUSTOMERS
WHERE id NOT IN (SELECT customerID FROM ORDERS);
