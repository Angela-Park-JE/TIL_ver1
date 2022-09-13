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

/*- MySQL : 머리를 리프레시 하고 다시 와서 풀으니 어렵지 않게 되었다. 
    NULL은 어차피 NULL이고 서로 다 동등하기 때문에 굳이 grade에 따라 나누어서 정렬을 하려고 UNION 같은 것을 생각할 필요가 없었다. -*/
SELECT 
    CASE WHEN tb1.grade>=8 THEN tb1.name ELSE NULL END AS names,
    tb1.grade, tb1.marks
FROM 
    (
    SELECT s.name, s.marks, g.grade FROM STUDENTS s, GRADES g
    WHERE (g.min_mark <= s.marks AND g.max_mark >= s.marks)
    ) tb1
ORDER BY tb1.grade DESC, names ASC, tb1.marks;



"""오답노트"""

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


/*- MySQL : 이렇게 하는 것은... 안된다. DESC가 먹지 않는다.-*/
(SELECT  s.name,
         g.grade,
         s.marks
FROM STUDENTS s, GRADES g
WHERE 1=1 
    AND s.marks >=70
    AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
ORDER BY 2 DESC, 1 ASC
)
UNION ALL

(SELECT 
    CASE WHEN s.marks < 70 THEN "NULL"
         ELSE s.name
         END AS names,
         g.grade,
         s.marks
FROM STUDENTS s, GRADES g
WHERE 1=1 
    AND s.marks < 70
    AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
ORDER BY 2 DESC, 3 ASC
);


/*- MySQL : 안타깝게도 SELECT FROM 안에 서브쿼리로 두어번 감싸도 되지 않는다. ORDER BY는 전체에 따로 적용되게 된다는 것. 
            이젠 아예 DESC도 먹지를 않는다. -*/
SELECT * FROM (
    SELECT * FROM (
        SELECT  s.name,
                 g.grade,
                 s.marks
        FROM STUDENTS s, GRADES g
        WHERE 1=1 
            AND s.marks >=70
            AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
        -- ORDER BY g.grade DESC, s.name ASC
    ) a
ORDER BY a.grade DESC, a.name ASC) aa 

UNION

SELECT * FROM (
    SELECT * FROM (
        SELECT 
            CASE WHEN s.marks < 70 THEN "NULL"
                 ELSE s.name
                 END AS names,
                 g.grade,
                 s.marks
        FROM STUDENTS s, GRADES g
        WHERE 1=1 
            AND s.marks < 70
            AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
        -- ORDER BY 2 DESC, 3 ASC
    ) b
ORDER BY b.grade DESC, .name ASC) bb;

/*- MySQL : 임의의 컬럼을 만들어서 오더를 주는 것도 말을 듣지 않는다. grade desc가 아예 먹지를 않고 grade 오름차순, 이름 오름차순, 아래는 grade 오름차순, mark 오름차순이 된다.-*/
SELECT a.name, a.grade, a.marks
FROM (SELECT  s.name,
             g.grade,
             s.marks,
             'a' AS src
    FROM STUDENTS s, GRADES g
    WHERE 1=1 
        AND s.marks >=70
        AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
    ORDER BY src, g.grade DESC, s.name ASC
    ) a
    
UNION ALL

SELECT b.names, b.grade, b.marks
FROM (SELECT 
        CASE WHEN s.marks < 70 THEN "NULL"
             ELSE s.name
             END AS names,
             g.grade,
             s.marks,
             'b' AS src
    FROM STUDENTS s, GRADES g
    WHERE 1=1 
        AND s.marks < 70
        AND (s.marks > g.min_mark) AND (s.marks < g.max_mark)
    ORDER BY src, g.grade DESC, s.marks ASC
    ) b;


/*- MySQL : 이것도 마찬가지 결과이다. 일부러 alias를 따로 주었는데 이조차 말을 듣지 않는다. -*/
SELECT a.name, a.grade, a.marks
FROM (SELECT  s1.name,
             g1.grade,
             s1.marks,
             'a' AS src
    FROM STUDENTS s1, GRADES g1
    WHERE 1=1 
        AND s1.marks >=70
        AND (s1.marks > g1.min_mark) AND (s1.marks < g1.max_mark)
    ORDER BY g1.grade DESC, s1.name ASC
    ) a
    
UNION ALL

SELECT b.names, b.grade, b.marks
FROM (SELECT 
        CASE WHEN s2.marks < 70 THEN "NULL"
             ELSE s2.name
             END AS names,
             g2.grade,
             s2.marks,
             'b' AS src
    FROM STUDENTS s2, GRADES g2
    WHERE 1=1 
        AND s2.marks < 70
        AND (s2.marks > g2.min_mark) AND (s2.marks < g2.max_mark)
    ORDER BY g2.grade DESC, s2.marks ASC
    ) b;
