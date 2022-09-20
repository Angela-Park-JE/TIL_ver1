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

