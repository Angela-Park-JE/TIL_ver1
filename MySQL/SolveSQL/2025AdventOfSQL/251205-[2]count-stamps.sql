/*
도장 이벤트를 하려는데
https://solvesql.com/problems/count-stamps/
*/


-- 251205: 어렵지 않게 순차적으로 조건
SELECT  stamp
      , COUNT(*) AS count_bill
  FROM  
      (
        SELECT  CASE WHEN total_bill >= 25 THEN 2 
                     WHEN total_bill >= 15 THEN 1
                     ELSE 0 END
                 AS stamp
          FROM  tips
      ) stamps_cnttable
 GROUP  BY 1
 ORDER  BY 1
 ;
