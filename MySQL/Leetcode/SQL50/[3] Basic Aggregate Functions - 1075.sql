/*-
1075. Project Employees I
https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50
  Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
  Return the result table in any order.
  Table: Project
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | project_id  | int     |
  | employee_id | int     |
  +-------------+---------+
    (project_id, employee_id) is the primary key of this table.
    employee_id is a foreign key to Employee table.
  Table: Employee
  +------------------+---------+
  | Column Name      | Type    |
  +------------------+---------+
  | employee_id      | int     |
  | name             | varchar |
  | experience_years | int     |
  +------------------+---------+
  -*/


-- 240822: MySQL, Oracle 모두 가능한 답
-- 어렵지는 않으나 Beats가 10%대 나와서 다시돌리니 67정도 나온다 역시 뭔가가 뭔가다...
SELECT  p.project_id 
      , ROUND(AVG(experience_years), 2) AS average_years
  FROM  PROJECT p LEFT JOIN EMPLOYEE e
        ON p.employee_id = e.employee_id
 GROUP  BY p.project_id;



/*- MSSQL로 풀어보는 문제 -*/

-- 240822: MySQL류와 다른 점은 experience_years 즉 소수점표기를 해야하는 컬럼에 대해서 실수화 작업이 먼저 필요하다는 점이다.
-- 한 가지 더, AVG 한 후 ROUND 했을때 테스트케이스7번의 id=12번 프로젝트의 평균값이 소수점 두 번째 자리에서 달랐다. 더 작은 것이다. 15.475라는 값을 ROUND 했을 떄 15.47로 표기한 것이다. 세 번째 자리가 5일때인 다른 값들에 대해서는 정상적으로 작동하는데 왜일까?
SELECT  p.project_id 
      , ROUND(AVG(CONVERT(float, experience_years)), 2, 0) AS average_years -- ROUND(column, 자리수, 내림여부[0-반올림/1-내림])
  FROM  PROJECT p LEFT JOIN EMPLOYEE e
        ON p.employee_id = e.employee_id
 GROUP  BY p.project_id
 ORDER  BY 1;

-- id=1 프로젝트의 경우 ROUND(AVG), 3) 했을 때 16.235이 나온다. 이것을 ROUND(,2)로 한 번 더 감싸면 16.24가 아니라 16.23이라고 나온다.
-- 크게 5가지에서 차이가 났으며, 일일히 비교를 위해 노트를 작성해서 구했다.
"""
전자 `ROUND(AVG(CONVERT(float, experience_years)), 2)` 
바로 2자리 ROUND때렸을 때 || 정답 
|12         | 15.47  || 15.48         |

전자 `ROUND(ROUND(AVG(CONVERT(float, experience_years)), 3), 2)`
id | 3자리수로 하고 2자리로 다시 만든 것 | | id | 정답 | 3자리
1          | 16.23         | | 1          | 16.24         | 16.235        |
9          | 15.91         | | 9          | 15.92         | 15.915        |
12         | 15.47         | | 12         | 15.48         | 15.475        |
17         | 15.85         | | 17         | 15.84         | 15.845        |
31         | 17.61         | | 31         | 17.62         | 15.845        |

자릿수가 하나 더 높거나 낮거나 하는데. 짐작가는 것은 이런 차이가 있지 않을까 하는 점이다. 반올림하여 2자리 수까지 표기하라고 했을 때, (1) 3번째 자리에서 반올림하여 2번째 자리 표기 (2) 계산되어 나온 값들을 맨 뒤에서부터 반올림해와서 2번째 자리 표기
[MSSQL ROUND() 함수 설명](https://learn.microsoft.com/ko-kr/sql/t-sql/functions/round-transact-sql?view=sql-server-ver16) 에는 예시가 다소 극단적이어서 어쩔 수 없이 직접 자리수를 전부 표기하도록 해보았다.
| id         | ROUND 없이 출력한 값  | (2) 방법 | 정답 | (1) 방법 | ROUND(2) | -> 1방법으로 구해야 답이 나옴
| 1          | 16.235294117647058 | 16.24 | 16.24 | 16.24 | 16.24 
| 9          | 15.915254237288135 | 15.92 | 15.92 | 15.92 | 15.92
| 12         | 15.475             | 15.48 | 15.48 | 15.48 | 15.47 -> 왜 1이나 2이나 다르냐 이거야. 
| 17         | 15.844827586206897 | 15.85 | 15.84 | 15.84 | 15.84 
| 31         | 17.615384615384617 | 17.62 | 17.62 | 17.62 | 17.62 
"""
