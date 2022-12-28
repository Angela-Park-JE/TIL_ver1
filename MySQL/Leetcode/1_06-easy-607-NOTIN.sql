"""
607. Sales Person
https://leetcode.com/problems/sales-person/?envType=study-plan&id=sql-i
Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
Return the result table in any order.
Input: 
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output: 
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation: 
According to orders 3 and 4 in the Orders table, it is easy to tell that only salesperson John and Pam have sales to company RED, so we report all the other names in the table salesperson.
"""



/*- mine : 잘못 이해했었으나 다시 이해하고 풀이. NOT IN 을 사용하여서 'RED' 사 주문을 한 sales_id만 데려온 뒤에 SALESPERSON 테이블에서 그들을 뺀다. 
    실제로 공식 SQL문에서도 같게 풀이함. -*/

-- MySQL
SELECT DISTINCT name
FROM SALESPERSON
WHERE sales_id NOT IN 
    (
    SELECT o.sales_id
    FROM ORDERS o LEFT JOIN COMPANY c ON c.com_id = o.com_id
    WHERE c.name = 'RED'
    );



"""오답노트"""
-- 질문을 잘못 알아듣고, 오더를 안했고, 회사이름은 RED인 사람을 찾았었다. 그게 아니라 RED에서 오더를 안한 sales_name을 원하는 것이었다!
-- 1. 결과 없음
SELECT s.name
FROM SALESPERSON s, COMPANY c, ORDERS o
WHERE o.sales_id = s.sales_id
  AND o.com_id = c.com_id
  AND INSTR(c.name, 'RED') > 0
  AND s.sales_id NOT IN (SELECT sales_id FROM ORDERS);

-- 2. 결과 없음
SELECT s.name
FROM ORDERS o LEFT JOIN SALESPERSON s ON o.sales_id = s.sales_id
              LEFT JOIN COMPANY c ON o.com_id = c.com_id
WHERE INSTR(c.name, 'RED') > 0
  AND s.sales_id NOT IN (SELECT sales_id FROM ORDERS);

-- 3. 결과가 나오지만, 한 명이 안나옴 : GREEN 이라는 회사에 주문한 사람이 안뜸
SELECT DISTINCT s.name
FROM SALESPERSON s, COMPANY c, ORDERS o
WHERE o.com_id = c.com_id
  AND INSTR(c.name, 'RED') > 0
  AND s.sales_id NOT IN (SELECT sales_id FROM ORDERS);
