"""
183. Customers Who Never Order
https://leetcode.com/problems/customers-who-never-order/description/?envType=study-plan&id=sql-i

Write an SQL query to report all customers who never order anything.
Return the result table in any order.
"""

/* mysql : 바로 맞았지만, 실행시간이 우수한 성능을 보이지 못했다. 하위 18.72%라니... 하면서 다른 답들은 어떨까 둘러보러 갔지만 다 같은 답이었다. ...? */
SELECT name AS customers
FROM CUSTOMERS
WHERE id NOT IN (SELECT customerID FROM ORDERS);
