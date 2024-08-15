/*-
577. Employee Bonus
https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
  Return the result table in any order.
  Table: Employee
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | empId       | int     |
  | name        | varchar |
  | supervisor  | int     |
  | salary      | int     |
  +-------------+---------+
  Table: Bonus
  +-------------+------+
  | Column Name | Type |
  +-------------+------+
  | empId       | int  |
  | bonus       | int  |
  +-------------+------+
-*/


-- 240815: 결과 테이블에서는 null도 포함한다. 보너스가 없는 것은 0이란 소리와 같은 것이니까!
-- 따라서 LEFT JOIN을 해서 BONUS 테이블에 없는 사람들도 모두 꺼내야 한다. 
-- 4.22%의 solution이 내 런타임과 같다는데. 좋은 것이겠지.
SELECT  e.name
      , b.bonus
  FROM  EMPLOYEE e LEFT JOIN BONUS b 
        ON e.empId = b.empID
 WHERE  b.bonus < 1000
    OR  b.bonus IS NULL;
-- WHERE 절 조건을 줄이려고 ON e.empId = b.empID AND b.bonus < 1000 라고 쓰면 LEFT JOIN이 그대로 남아서 모든 empId출력이 되므로 의미가 없게 되며,
-- JOIN을 하고 ON e.empId = b.empID AND b.bonus < 1000 라고 쓰면 보너스가 null일 사람들은 출력되지 않아서 의미가 없게 된다.
