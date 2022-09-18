"""

"""


"""오답노트"""
/*- MySQL : 끝나는 날짜가 다음 날의 시작 날짜와 같거나, 다음 태스크(날짜)의 시작 날짜가 끝나는 날과 같거나 ... 하다가 어지러워져버렸다.-*/
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
