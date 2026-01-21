/*
주중과 주말의 매출
https://solvesql.com/problems/revenue-weekday-weekend/
*/


-- 251213: case when 을 잘 쓰기만 하면 어려울 것 없는 문제!
SELECT  week
      , SUM(total_bill) AS sales
  FROM  
        (
          SELECT  CASE WHEN day in ('Sat', 'Sun') THEN 'weekend'
                      ELSE 'weekday'
                      END AS 'week'
                , total_bill
            FROM  tips
        ) weektable 
 GROUP  BY week
 ORDER  BY 2 DESC
 ;
