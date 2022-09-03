"""
Prepare> SQL> Basic Join> The Report
https://www.hackerrank.com/challenges/the-report/
You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
The report must be in descending order by grade -- i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve.
"""

-- name, grade, mark.
-- NO name grade lower than 8
-- descending order by grade 
-- same grade: order name alphabetically
-- lower than 8: use NULL in name  and grade desc order
-- same grade: order by those mark asc


/*- MySQL : 결과는 내가 문제를 이해한 바에 맞게 분명 출력이 되는데, 답이 아니라고 한다. 보니 8등급이상의 학생들이 알파벳순이 안됨. -*/
-- student list with grade
SELECT
    CASE WHEN s.marks < 70 THEN NULL
         ELSE s.name 
         END AS names,
         g.grade,
         s.marks
FROM STUDENTS s, GRADES g
WHERE 1=1 
    AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
ORDER BY 
    g.grade DESC, 
    (CASE WHEN names != NULL THEN s.name END) ASC,
    (CASE WHEN names = NULL THEN s.marks END) ASC;
    


-- SELECT s.id, s.name, s.marks, g.grade
-- FROM STUDENTS s, GRADES g
-- WHERE 1=1 
--     AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
