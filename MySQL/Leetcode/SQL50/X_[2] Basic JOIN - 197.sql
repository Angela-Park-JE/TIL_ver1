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


-- 240812: test case 한 개가 넘어가질 않는다.
SELECT  w2.id -- 오늘
  FROM  WEATHER w1 -- 어제 
        LEFT JOIN WEATHER w2    -- RIGHT 조인도 되지 않음
        ON w1.recordDate + 1 = w2.recordDate 
 WHERE  w1.temperature < w2.temperature;
