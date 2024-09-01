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


-- [Oracle] 240829: (다시 쓰면,) 따라서 해당 NVL2를 SUM으로 집계해주면된다! - 그럼에도 809ms, Beats 92.42%로 박수 마크가 떴다.
-- 코드가 간단하다. (간단하다고 생각한다.) cross join을 문제 풀때 사용한 건 처음이다. (cross가 생각이 안나서 cartesian product sql을 검색했다)
SELECT  tmp.*
      , SUM(NVL2(e.student_id, 1, 0)) AS attended_exams
  FROM  
         (
           SELECT  *
            FROM  STUDENTS s CROSS JOIN SUBJECTS sub     
         ) tmp 
         LEFT JOIN EXAMINATIONS e ON tmp.student_id = e.student_id AND tmp.subject_name = e.subject_name 
 GROUP  BY tmp.student_id, tmp.student_name, tmp.subject_name 
 ORDER  BY 1, 3;



/* 오답노트 */

-- 240827: 이것은 0회인 학생-과목에 대해 출력하지 않아 오답이다.
SELECT  s.student_id
      , s.student_name
      , e.subject_name
      , COUNT(e.student_id) AS attended_exams
  FROM  STUDENTS s RIGHT JOIN EXAMINATIONS e
        ON s.student_id = e.student_id
 GROUP  BY s.student_id, s.student_name, e.subject_name;

-- [Oracle] 240829: FULL JOIN을 쉽게 사용하기 위해 Oracle로 넘어왔으나 student_id 부터 null이 떠버렸다.
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

-- [Oracle] 240829:
-- 이 문제는 student랑 subject랑 cartesian product (크로스 조인)으로 해결할 수 있다.
-- 여기까지 했을 때 해당 학생이 시험에 왔으면 attended 컬럼이 1 아니면 0이 된다.
-- 컴퓨팅 파워 상 좋은 방법은 아니나 내 기준에서 가장 간단하게 쓴다면 이 방법이 될 것 같았다. 이것을 다시 정답에 맞게 집계 등을 한 것이 위의 해답.
SELECT  tmp.*
      , NVL2(e.student_id, 1, 0) AS attended 
  FROM  
         (
           SELECT  *
            FROM  STUDENTS s CROSS JOIN SUBJECTS sub     
         ) tmp 
         LEFT JOIN EXAMINATIONS e ON tmp.student_id = e.student_id AND tmp.subject_name = e.subject_name 
