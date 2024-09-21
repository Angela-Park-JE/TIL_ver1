/*
1789. Primary Department for Each Employee
https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
  Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. 
  Note that when an employee belongs to only one department, their primary column is 'N'.
  Write a solution to report all the employees with their primary department. 
  For employees who belong to one department, report their only department.
  Return the result table in any order.
  Table: Employee
  +---------------+---------+
  | Column Name   |  Type   |
  +---------------+---------+
  | employee_id   | int     |
  | department_id | int     |
  | primary_flag  | varchar |
  +---------------+---------+
  (employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
*/


-- 240921: WINDOW 함수로 COUNT하는 방식으로 이게 primary인지 아닌지 체크하도록 만들었다.
-- 1개면 primary, 2개 이상이면 'Y'가 있는 것이 primary로 department_id를 남기고, 
-- 그 외는 0으로 처리한 다음 department_id 가 0이 아닌 것만 걸러지도록 했다.
-- (1) 만약 department_id가 0이나 NULL 있는 회사 데이터라면 기존 데이터 형식이 아닌 (e.g. VARCHAR) 임의의 데이터를 넣는 것도 방법이고,
-- (2) 아니면 아예 새 컬럼을 만들거나 COUNT(primary_flag)가 1개인 경우 'Y'가 되도록 primary_flag 컬럼을 새로 수정한 뒤 그것을 기준으로 필터링 해도 좋다.
-- 처음엔 5% beats를 기록했으나 다시 제출하니 89%가 나온다. 역시 믿을게 못되는 leetcode runtime!
SELECT  employee_id
      , department_id
  FROM  (
        SELECT  employee_id
              , CASE WHEN COUNT(primary_flag) OVER (PARTITION BY employee_id) = 1 THEN department_id
                     WHEN COUNT(primary_flag) OVER (PARTITION BY employee_id) > 1 
                          AND primary_flag = 'Y' THEN department_id
                     ELSE 0 
                     END AS department_id
          FROM  EMPLOYEE
        ) tmp
 WHERE  department_id != 0;
