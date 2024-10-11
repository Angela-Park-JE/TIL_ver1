/*
619. Biggest Single Number
https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50
  A single number is a number that appeared only once in the MyNumbers table.
  Find the largest single number. If there is no single number, report null.
  Table: MyNumbers
  +-------------+------+
  | Column Name | Type |
  +-------------+------+
  | num         | int  |
  +-------------+------+
    This table may contain duplicates (In other words, there is no primary key for this table in SQL).
    Each row of this table contains an integer.
*/


-- 241011: 
SELECT  IF( COUNT(num) = 0, NULL, MAX(num) ) AS num 
  FROM  
        (
        SELECT  num
          FROM  MYNUMBERS
         GROUP  BY num
        HAVING  COUNT(num) = 1
        ) tmp;
