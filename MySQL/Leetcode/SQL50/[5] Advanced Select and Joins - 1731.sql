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


-- 240916
