"""
1741. Find Total Time Spent by Each Employee
https://leetcode.com/problems/find-total-time-spent-by-each-employee/description/?envType=study-plan&id=sql-i

Write an SQL query to calculate the total time in minutes spent by each employee on each day at the office. 
Note that within one day, an employee can enter and leave more than once. 
The time spent in the office for a single entry is out_time - in_time.
Return the result table in any order.

Input: 
Employees table:
+--------+------------+---------+----------+
| emp_id | event_day  | in_time | out_time |
+--------+------------+---------+----------+
| 1      | 2020-11-28 | 4       | 32       |
| 1      | 2020-11-28 | 55      | 200      |
| 1      | 2020-12-03 | 1       | 42       |
| 2      | 2020-11-28 | 3       | 33       |
| 2      | 2020-12-09 | 47      | 74       |
+--------+------------+---------+----------+
Output: 
+------------+--------+------------+
| day        | emp_id | total_time |
+------------+--------+------------+
| 2020-11-28 | 1      | 173        |
| 2020-11-28 | 2      | 30         |
| 2020-12-03 | 1      | 41         |
| 2020-12-09 | 2      | 27         |
+------------+--------+------------+
"""


/*- mine: 원래는 out-in 한 서브쿼리를 만들어두고 거기서 SUM 을 하려고 했었는데 날짜 별 사람 별 합이길래 SUM을 한번에 갈겼다. -*/

-- MySQL
SELECT event_day day, emp_id, SUM(out_time - in_time) total_time
FROM EMPLOYEES 
GROUP BY 1, 2;
