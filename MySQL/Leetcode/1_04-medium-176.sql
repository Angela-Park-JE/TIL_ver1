"""
176. Second Highest Salary
https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan&id=sql-i
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.

Write an SQL query to report the second highest salary from the Employee table. 
If there is no second highest salary, the query should report null.
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
"""



/* mine : 먼저 단순하게 생각하는 것이 도움이 될 때도 있다 */

-- MySQL : 속도는 그다지 좋지 않았음
SELECT MAX(salary) SecondHighestSalary
FROM EMPLOYEE
WHERE salary != (SELECT MAX(salary) FROM EMPLOYEE);

-- 속도를 올리는 방법: != 으로 일일히 비교하게 만들지 말고 부등호를 쓰자
SELECT MAX(salary) SecondHighestSalary
FROM EMPLOYEE
WHERE salary < (SELECT MAX(salary) FROM EMPLOYEE);



"""오답노트"""
-- 괜히 medium 이라고 문제를 어렵게 풀어야할 것 같은 기분 때문에 복잡하게 WINDOW 함수를 쓰려고 했었다
-- 그러다가 맥스를 거른 것에서 맥스를 찾으면 되지 라는 것을... WHERE 절 가서 생각함
-- 
SELECT 
    CASE WHEN NTH_VALUE(salary, 2) OVER (ORDER BY salary DESC) IS NOT NULL THEN
        NTH_VALUE(salary, 2) OVER (ORDER BY salary DESC)
    END SecondHighestSalary
FROM EMPLOYEE
WHERE salary = ....

SELECT MAX(salary) SecondHighestSalary
FROM EMPLOYEE
WHERE salary != (SELECT MAX(salary) FROM EMPLOYEE);


-- 그리고 이런 방법도 생각했는데, 순위로 2등까지 자른다음 MIN을 찾으면 검색량이 줄어든다고 생각했던 것이다.
-- 이것은 만약 차순을 따질 수 없게 값이 하나일 뿐인 경우 해당 밸류를 내놓게 된다. (없으면 없는대로 안나오도록 해야함)
SELECT MIN(salary) SecondHighestSalary
FROM (SELECT salary FROM EMPLOYEE ORDER BY salary DESC LIMIT 2) tmp;
