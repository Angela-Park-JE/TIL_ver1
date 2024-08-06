/*-
1378. Replace Employee ID With The Unique Identifier
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
  Return the result table in any order.
  The result format is in the following example.
  
  Table: Employees
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | id            | int     |
  | name          | varchar |
  +---------------+---------+
  
  Table: EmployeeUNI
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | id            | int     |
  | unique_id     | int     |
  +---------------+---------+
-*/


-- 240806: IFNULL로 명시하긴 했는데 LEFT JOIN을 써서 굳이 사용하지 않아도 된다. 
-- 하지만 NULL이 먼저오는 곳이 있고 아닌 곳이 있기 떄문에 정렬이 필요한 문제의 경우 써주는 것이 좋다고 생각.
-- 같은 코드로도 leetcode runtime이 너무 들쑥날쑥이다. 
SELECT  IFNULL(eu.unique_id, NULL) AS unique_id
      , e.name
  FROM  EMPLOYEES e 
        LEFT JOIN EMPLOYEEUNI eu ON e.id = eu.id;
