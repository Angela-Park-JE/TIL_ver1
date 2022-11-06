"""
Prepare> SQL> Advanced Join> SQL Project Planning
https://www.hackerrank.com/challenges/sql-projects/
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
If the End_Date of the tasks are consecutive, then they are part of the same project. 
Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
If there is more than one project that have the same number of completion days, then order by the start date of the project.
"""


"""오답노트"""
/*- MySQL : 끝나는 날짜가 다음 날의 시작 날짜와 같거나, 다음 태스크(날짜)의 시작 날짜가 끝나는 날과 같거나 ... 하다가 어지러워져버렸다.
    3 rows의 결과가 나오는데 아 어렵다 논리를 짜기가-*/
SELECT -- p1.task_id, 
        p1.start_date, 
        -- p1.end_date, 
        -- DATE_ADD(p1.end_date, INTERVAL 1 DAY) added_date, 
        -- p2.start_date, 
        p2.end_date
FROM PROJECTS p1, PROJECTS p2
WHERE 1=1
    AND DATE_ADD(p1.end_date, INTERVAL 1 DAY) = p2.start_date
    OR
        (p1.task_id +1 = p2.task_id
    AND DATE_ADD(p1.end_date, INTERVAL 1 DAY) = p2.start_date)
ORDER BY 2 desc, 1 asc;

/*- MySQL : 비슷하게 간 것 같았으나 `p1.task_id + 1 = p2.task_id` 에서 문제인 듯 하다 -*/
SELECT -- p1.task_id, 
        p1.start_date, 
        -- p1.end_date, 
        -- DATE_ADD(p1.end_date, INTERVAL 1 DAY) added_date, 
        -- p2.start_date, 
        p2.end_date
FROM PROJECTS p1, PROJECTS p2
WHERE 1=1
    AND p1.task_id + 1 = p2.task_id
    AND DATE_ADD(p1.end_date, INTERVAL 1 DAY)!= p2.start_date
ORDER BY 2 desc, 1 asc;

/*- MySQL : 꼬다가 내가 꼬인 상태. 시작날짜(1)가 다음 날의 시작날짜(2)와 같다면 (1)을 넣고, 다르다면 다음 날의 시작날짜(2)를 넣도록 하였는데.
    뭔가 안맞고있다...-*/
SELECT 
    CASE WHEN DATE_ADD(p1.start_date, INTERVAL 1 DAY) = p2.start_date
        THEN p1.start_date
        WHEN DATE_ADD(p1.start_date, INTERVAL 1 DAY) != p2.start_date
        THEN p2.start_date
        END starts,
    p2.end_date
FROM PROJECTS p1, PROJECTS p2
WHERE 1=1
    AND p1.task_id + 1 = p2.task_id;

/*- MySQL : 이어진 날짜의 첫번쨰 날이 안나오고 있는 상태라고 볼 수 있다.
    ELSE p2.start_date를 주석처리 했더니 NULL이 나온다. 전부 두번째 날로 나오고 있는 상태인 것이다. */
SELECT 
    CASE WHEN DATE_ADD(p1.start_date, INTERVAL 1 DAY) = p2.start_date
        THEN p1.start_date
        ELSE p2.start_date
        END starts
FROM PROJECTS p1, PROJECTS p2
WHERE 1=1 
    AND p1.task_id + 1 = p2.task_id
ORDER BY starts;

/*- MySQL : (1) 의 결과를 토대로 다시 만들어가기 시작했다. -*/
--(1) task_id와 start_date의 차순은 같지 않음을 판단, task_id 자체로 결과로 원하는 것을 내놓을 수 없는 것으로 생각됨.
-- 그리고 WITH 를 사용할 수 있음을...알았다
WITH TB1 AS 
    (SELECT p1.start_date keysd, p2.start_date p2sd, p2.end_date p2ed
    FROM PROJECTS p1, PROJECTS p2
    WHERE 1=1 
        AND p1.start_date + 1 = p2.start_date
    ORDER BY p1.start_date
    ) 

--(2) 다음 행을 조회하는 쿼리 
WITH TB1 AS
    (SELECT 
        p.task_id,
        p.start_date,
        p.end_date,
        LEAD(p.end_date, 1) OVER (ORDER BY p.start_date) nexttask_enddate
    FROM 
        PROJECTS p)

-- 시도: 또 첫날빼고 데려오고있음
WITH TB1 AS
    (SELECT 
        p.task_id,
        p.start_date,
        p.end_date,
        LEAD(p.end_date, 1) OVER (ORDER BY p.start_date) nexttask_enddate
    FROM 
        PROJECTS p)

SELECT TB1.start_date, TB1.end_date
FROM TB1 AS TB1, TB1 AS TB2
WHERE TB1.end_date = TB2.nexttask_enddate;

/*- MySQL : 새로 지어서 했음. 세번쨰 컬럼에 NULL이 뜨면 해당 로우의 두번째 컬럼으로 조회한 end_date가 프로젝트의 end임. -*/
SELECT p.task_id, p.start_date, 
    CASE WHEN LEAD(p.start_date, 1) OVER (ORDER BY p.start_date) = p.end_date
        THEN LEAD(p.end_date, 1) OVER (ORDER BY p.start_date) 
        END next_end_date
FROM PROJECTS p;


/*- MySQL : 2022.11.06  시간이 지나고 도전해보았으나 비슷한 난관에 부딪힌 듯 하다 -*/ 
WITH CTE_1 AS
    (
    SELECT task_id,
           LAG(end_date, 1) OVER (ORDER BY start_date) lagged_ed,
           start_date sd, 
           end_date ed,
           LEAD(start_date, 1) OVER (ORDER BY start_date) leaded_sd
    FROM PROJECTS 
    ORDER BY start_date, task_id
    ),
     CTE_2 AS
    (
    SELECT task_id, lagged_ed, sd, ed, leaded_sd
    FROM CTE_1
    WHERE (lagged_ed != sd) -- project opening
       OR (leaded_sd != ed) -- project ending
       OR sd = (SELECT MIN(start_date) FROM PROJECTS) -- data first row
    )

SELECT *
FROM CTE_2;
