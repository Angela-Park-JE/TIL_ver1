/*
연속으로 먼지 방야방야 해진 날
https://solvesql.com/problems/bad-finddust-days-in-a-row/
*/


-- 251207: 세 번째 날을 메인으로 붙이도록, 즉 이전 이틀을 차례로 붙이도록 하는 무식한 방법
SELECT  day3_table.measured_at AS date_alert
--      , day3_table.pm10 AS pm10_day3			-- 수치 확인용
--      , day2_table.pm10 AS pm10_day2
--      , day1_table.pm10 AS pm10_day1
  FROM  measurements day3_table 
        LEFT JOIN measurements day2_table 
               ON DATE_ADD(day3_table.measured_at, INTERVAL -1 DAY) = day2_table.measured_at
        LEFT JOIN measurements day1_table
               ON DATE_ADD(day2_table.measured_at, INTERVAL -1 DAY) = day1_table.measured_at
 WHERE  1=1
   AND  day3_table.pm10 >= 30					-- 세 번째 날이 30 이상이고
   AND  day3_table.pm10 > day2_table.pm10       -- 그 전날과 전 전날을 검사하도록
   AND  day2_table.pm10 > day1_table.pm10
  ;
