/* 
연습 문제> 멘토링 짝꿍 리스트
https://solvesql.com/problems/mentor-mentee-list/
*/

-- 240412: SQLite는 날짜단위 연산이 간편한 편이 아니라서 JULIANDAY로 구하고 연산을 하거나 CAST를 활용해야만 했다.
-- STRFTIME 연산 도움이 된 곳: https://royzero.tistory.com/entry/sqlite-to-lookup-date-diff
-- 조건에는 매칭이 안되더라도 멘티는 모두 출력이 되어야 한다고 했기에 멘티 테이블로 추린다음 멘티에 멘토를 붙이는 방식으로 풀었다.
-- 문제가 원하는 것은 멘티 한명에 여러 멘토 매칭 결과 전부를 원하는 것이니 어렵게 생각할 필요는 없는 문제였다.
WITH joinmonth AS 
  (
    SELECT  employee_id
          , name  
          , department
          -- , TIMESTAMPDIFF(MONTH, '2021-12-31', join_date) -- Mysql
          , CAST((STRFTIME('%Y', '2021-12-31')
              -STRFTIME('%Y', join_date)) AS INTEGER)*12
            + CAST((STRFTIME('%m', '2021-12-31')
              -STRFTIME('%m', join_date)) AS INTEGER) AS MONTHDIFF
      FROM  EMPLOYEES
    ),
    mentee AS
    (
    SELECT  employee_id, name, department, MONTHDIFF
      FROM  joinmonth
     WHERE  MONTHDIFF <=3
    )

SELECT  m.employee_id AS mentee_id
      , m.name AS mentee_name
      , j.employee_id AS mentor_id
      , j.name AS mentor_name
  FROM  mentee m
        LEFT JOIN joinmonth j ON m.department <> j.department 
          AND j.MONTHDIFF>=24
 ORDER  BY 1, 3;
