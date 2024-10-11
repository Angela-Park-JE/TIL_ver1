/*
1978. Employees Whose Manager Left the Company
Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. 
When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
Return the result table ordered by employee_id.
The result format is in the following example.
  Table: Employees
  +-------------+----------+
  | Column Name | Type     |
  +-------------+----------+
  | employee_id | int      |
  | name        | varchar  |
  | manager_id  | int      |
  | salary      | int      |
  +-------------+----------+
*/


-- 241001: 어려울 것 없는 쿼리! IN 을 쓰는 면에서 서브쿼리 문제로 분류되나보다.
-- FROM에서 먼저 거르는 방법도 있을 수 있을 것 같다.
SELECT  employee_id 
  FROM  EMPLOYEES 
 WHERE  salary < 30000
   AND  manager_id NOT IN (SELECT employee_id FROM EMPLOYEES)
 ORDER  BY 1;
