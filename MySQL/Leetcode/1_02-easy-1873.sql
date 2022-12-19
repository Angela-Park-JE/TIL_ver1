"""
1873. Calculate Special Bonus
https://leetcode.com/problems/calculate-special-bonus/?envType=study-plan&id=sql-i
Write an SQL query to calculate the bonus of each employee. 
The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character 'M'. 
The bonus of an employee is 0 otherwise.
Return the result table ordered by 'employee_id'.

Input: 
Employees table:
+-------------+---------+--------+
| employee_id | name    | salary |
+-------------+---------+--------+
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addilyn | 7400   |
| 8           | Juan    | 6100   |
| 9           | Kannon  | 7700   |
+-------------+---------+--------+
Output: 
+-------------+-------+
| employee_id | bonus |
+-------------+-------+
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |
+-------------+-------+
"""

/*- mine: 아니 임플로이 아이디가 홀수이고 이름이 M으로 시작하지 않으면 보너스를 100%받는다고요? -*/

SELECT employee_id, 
        CASE WHEN (MOD(employee_id, 2) = 1) 
              AND (SUBSTR(name,1,1) != 'M') 
                THEN salary
             ELSE 0
        END bonus
FROM EMPLOYEES
ORDER BY 1;
