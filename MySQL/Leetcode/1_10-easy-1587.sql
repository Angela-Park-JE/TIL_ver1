"""
1587. Bank Account Summary II
https://leetcode.com/problems/bank-account-summary-ii/description/?envType=study-plan&id=sql-i
Write an SQL query to report the name and balance of users with a balance higher than 10000. 
The balance of an account is equal to the sum of the amounts of all transactions involving that account.
Return the result table in any order.
Input: 
Users table:
+------------+--------------+
| account    | name         |
+------------+--------------+
| 900001     | Alice        |
| 900002     | Bob          |
| 900003     | Charlie      |
+------------+--------------+
Transactions table:
+------------+------------+------------+---------------+
| trans_id   | account    | amount     | transacted_on |
+------------+------------+------------+---------------+
| 1          | 900001     | 7000       |  2020-08-01   |
| 2          | 900001     | 7000       |  2020-09-01   |
| 3          | 900001     | -3000      |  2020-09-02   |
| 4          | 900002     | 1000       |  2020-09-12   |
| 5          | 900003     | 6000       |  2020-08-07   |
| 6          | 900003     | 6000       |  2020-09-07   |
| 7          | 900003     | -4000      |  2020-09-11   |
+------------+------------+------------+---------------+
Output: 
+------------+------------+
| name       | balance    |
+------------+------------+
| Alice      | 11000      |
+------------+------------+
"""



/*- mine : WINDOW 함수를 써서 해보고 싶었는데 잘 안됐다. HAVING 으로 해결하고 끝냈다. -*/

-- MySQL
SELECT u.name NAME, SUM(t.amount) BALANCE
FROM USERS u, TRANSACTIONS t
WHERE u.account = t.account
GROUP BY u.account
HAVING SUM(t.amount) > 10000;



"""다른 풀이"""

-- 보다보니 DISTINCT 로 WINDOW 사용시 모든 로우대로 출력이 되던 것을 `DISTINCT` 하나로 해결할 수 있었... 나 혹시 바보?
SELECT *
FROM 
    (
    SELECT DISTINCT u.name name, SUM(t.amount) OVER (PARTITION BY t.account) balance
    FROM USERS u, TRANSACTIONS t
    WHERE u.account = t.account
    ) tmp
WHERE balance > 10000;
