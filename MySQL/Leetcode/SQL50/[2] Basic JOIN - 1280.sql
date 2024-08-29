/*-
1280. Students and Examinations
https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find the number of times each student attended each exam.
  Return the result table ordered by student_id and subject_name.
  Table: Students                Table: Subjects
  +---------------+---------+    +--------------+---------+
  | Column Name   | Type    |    | Column Name  | Type    |
  +---------------+---------+    +--------------+---------+
  | student_id    | int     |    | subject_name | varchar |
  | student_name  | varchar |    +--------------+---------+
  +---------------+---------+
  Table: Examinations
  +--------------+---------+
  | Column Name  | Type    |
  +--------------+---------+
  | student_id   | int     |
  | subject_name | varchar |
  +--------------+---------+
-*/


/* 오답노트 */

-- 240827: 이것은 0회인 학생-과목에 대해 출력하지 않아 오답이다.
SELECT  s.student_id
      , s.student_name
      , e.subject_name
      , COUNT(e.student_id) AS attended_exams
  FROM  STUDENTS s RIGHT JOIN EXAMINATIONS e
        ON s.student_id = e.student_id
 GROUP  BY s.student_id, s.student_name, e.subject_name;

-- 240829: FULL JOIN을 쉽게 사용하기 위해 Oracle로 넘어왔으나 student_id 부터 null이 떠버렸다.
SELECT  DISTINCT e.student_id
      , s.student_name
      , e.subject_name
      , COUNT(e.student_id) AS attended_exams
  FROM  EXAMINATIONS e FULL JOIN STUDENTS s
        ON e.student_id = s.student_id
        FULL JOIN SUBJECTS sub
        ON e.subject_name = sub.subject_name
 GROUP  BY e.student_id, s.student_name, e.subject_name
 ORDER  BY 1, 3;
