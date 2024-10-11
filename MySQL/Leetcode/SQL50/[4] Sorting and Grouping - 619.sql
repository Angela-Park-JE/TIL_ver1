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



/*오답노트*/
-- 241011: NULL이 나와야하는 곳에 나오지 않는다.
SELECT  IFNULL(num, NULL) AS num
  FROM  MYNUMBERS
 GROUP  BY num
HAVING  COUNT(num) = 1
 ORDER  BY 1 DESC
 LIMIT  1;

-- 역시 실패. NULL이 나와야하는 곳에 나오지 않는다. ROW_NUMBER() 자체가 값을 뱉지 않기 때문으로 보인다.
SELECT  CASE WHEN ROW_NUMBER() OVER(ORDER BY num DESC) = 0 THEN NULL ELSE num END AS num
  FROM  MYNUMBERS
 GROUP  BY num
HAVING  COUNT(num) = 1
 ORDER  BY 1 DESC
 LIMIT  1;

-- 반대로 짜보았으나 마찬가지로 NULL이 나와야하는 자리에 나오지 않게 된다.
SELECT  CASE WHEN ROW_NUMBER() OVER(ORDER BY num DESC) = 1 THEN num ELSE NULL END AS num
  FROM  MYNUMBERS
 GROUP  BY num
HAVING  COUNT(num) = 1
 ORDER  BY 1 DESC
 LIMIT  1;

-- 오류나는 쿼리이지만, 이걸 발전시켜서, count(num)이 있는 애들을 모아놓고 이것에 대해 COUNT가 0이면 NULL 아니면 MAX를 반환하도록 하기로 했다.
SELECT  IF( COUNT(COUNT(num) = 1) = 0, num, NULL)
  FROM  MYNUMBERS
 GROUP  BY num
HAVING  COUNT(num) = 1
 ORDER  BY 1
