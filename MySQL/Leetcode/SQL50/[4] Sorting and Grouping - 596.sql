/*
596. Classes More Than 5 Students
https://leetcode.com/problems/classes-more-than-5-students/description/?envType=study-plan-v2&envId=top-sql-50
*/


-- 240913: 전형적인 HAVING 문제
SELECT  class 
  FROM  COURSES
 GROUP  BY class
HAVING  COUNT(student) >= 5;
