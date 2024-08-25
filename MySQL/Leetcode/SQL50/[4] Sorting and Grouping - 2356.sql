/*-
2356. Number of Unique Subjects Taught by Each Teacher
https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to calculate the number of unique subjects each teacher teaches in the university.
  Return the result table in any order.
  Table: Teacher
  (subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
  +-------------+------+
  | Column Name | Type |
  +-------------+------+
  | teacher_id  | int  |
  | subject_id  | int  |
  | dept_id     | int  |
  +-------------+------+
-*/


-- [MySQL, Oracle, MSSQL] 240825: 어려울 것 없는 문제
SELECT  teacher_id
      , COUNT(DISTINCT subject_id) AS cnt
  FROM  TEACHER
 GROUP  BY teacher_id;
