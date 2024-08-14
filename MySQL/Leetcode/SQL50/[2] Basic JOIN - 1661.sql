/*-
1661. Average Time of Process per Machine
-*/


-- 240814
SELECT  machine_id
      , ROUND(AVG(ts), 3) AS processing_time
  FROM (
        SELECT  machine_id
              , process_id
              , MAX(timestamp) - MIN(timestamp) ts
          FROM  ACTIVITY 
         GROUP  BY machine_id, process_id
        ) tmp
 GROUP  BY 1
