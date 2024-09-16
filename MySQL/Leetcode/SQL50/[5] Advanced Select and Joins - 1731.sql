/*
1731. The Number of Employees Which Report to Each Employee
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
  For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
  Write a solution to report the ids and the names of all managers, 
  the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
  Return the result table ordered by employee_id.
  Table: Employees
  +-------------+----------+
  | Column Name | Type     |
  +-------------+----------+
  | employee_id | int      |
  | name        | varchar  |
  | reports_to  | int      |
  | age         | int      |
  +-------------+----------+
  employee_id is the column with unique values for this table.
*/


-- 240916: 먼저 원래 테이블에 테이블을 붙여 지목당한 사람별로 groupby 후 그들의 name과 나이를 센다.
-- 마지막에 두번째 줄 쓰는데 이게 됐었지 아마? 이렇게 셀픞조인 조회될거야 더듬더듬 해서 했다.
-- 문제는 그 즈음 해서 아니 나 왜 메인쿼리에 두 번 조인했나-했다.
SELECT  e1.reports_to AS employee_id
      , (SELECT e3.name FROM EMPLOYEES e3 WHERE e3.employee_id = e1.reports_to) AS name
      , COUNT(e2.employee_id) AS reports_count
      , ROUND(AVG(e1.age)) AS average_age
  FROM  EMPLOYEES e1 LEFT JOIN EMPLOYEES e2 
        ON e1.reports_to = e2.employee_id
 GROUP  BY e1.reports_to
HAVING  COUNT(e1.reports_to)>=1
 ORDER  BY 1;
