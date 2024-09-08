/*-
197. Rising Temperature
https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
  Return the result table in any order. 
  Table: Weather
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | id            | int     |
  | recordDate    | date    |
  | temperature   | int     |
  +---------------+---------+
-*/


-- 240908: DATEDIFF는 맞고 날짜 연산은 틀리다
SELECT  w2.id AS id
  FROM  WEATHER w1 RIGHT JOIN WEATHER w2  -- 어제 날짜 기록이 있는 데이터 기준
        -- ON w1.recordDate - 1 = w2.recordDate 
        ON DATEDIFF(w2.recordDate, w1.recordDate) = 1
 WHERE  w1.temperature < w2.temperature
 ORDER  BY w1.id;



/* 오답노트 */

-- 240812: test case 한 개가 넘어가질 않는다.
SELECT  w2.id -- 오늘
  FROM  WEATHER w1 -- 어제 
        LEFT JOIN WEATHER w2    -- RIGHT 조인도 되지 않음
        ON w1.recordDate + 1 = w2.recordDate 
 WHERE  w1.temperature < w2.temperature;
