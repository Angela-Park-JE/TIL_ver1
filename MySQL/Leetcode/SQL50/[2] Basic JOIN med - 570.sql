/*
570. Managers with at Least 5 Direct Reports
https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find managers with at least five direct reports.
  Return the result table in any order.
  Table: Employee
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | id          | int     |
  | name        | varchar |
  | department  | varchar |
  | managerId   | int     |
  +-------------+---------+
  id is the primary key (column with unique values) for this table.
*/


-- 241015: I don't know whether this is right solution for Basic Join questions designated...
-- id 카운트가 5 이상인 managerid 목록에서 사람을 search!
SELECT  name
  FROM  EMPLOYEE
 WHERE  id IN (SELECT managerId FROM EMPLOYEE GROUP BY managerid HAVING COUNT(id)>=5);
