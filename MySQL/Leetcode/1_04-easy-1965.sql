"""
1965. Employees With Missing Information
https://leetcode.com/problems/employees-with-missing-information/description/?envType=study-plan&id=sql-i
Write an SQL query to report the IDs of all the employees with missing information. 
The information of an employee is missing if:
  The employee's name is missing, or
  The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+

"""


/* mine : 처음에 습관적으로 FULL OUTER JOIN을 쓰려했는데 안된다는 것을 알아차리고 바꾼 UNION */

-- MySQL, Oracle
SELECT e.employee_id
FROM EMPLOYEES e
WHERE e.employee_id NOT IN (SELECT employee_id FROM SALARIES)
UNION
SELECT s.employee_id
FROM SALARIES s
WHERE s.employee_id NOT IN (SELECT employee_id FROM EMPLOYEES)
ORDER BY 1 ASC;



"""다른 답안"""

-- MySQL by.123_tripathi : 원래 처음 생각한 방식이 이런 식이었다. 조인을 사용해서 IS NULL로 체크하는 방식. 이분은 나랑 쿼리 쓰는 이 꽤 비슷하다 ㅠㅠ 신기하다.
Select e.employee_id from Employees e 
LEFT JOIN Salaries s 
ON e.employee_id = s.employee_id
WHERE s.salary  is NULL
UNION
Select s.employee_id from Salaries s
LEFT JOIN Employees e 
ON e.employee_id = s.employee_id
WHERE e.name is NULL
ORDER BY employee_id;
