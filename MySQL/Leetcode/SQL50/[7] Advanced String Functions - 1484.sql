/*
1484. Group Sold Products By The Date
https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find for each date the number of different products sold and their names.
  The sold products names for each date should be sorted lexicographically.
  Return the result table ordered by sell_date.
  Table Activities:
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | sell_date   | date    |
  | product     | varchar |
  +-------------+---------+
  There is no primary key (column with unique values) for this table. It may contain duplicates.
*/


-- 241115: 두번째 제출 눌렀을 때 78%로 오름. 크게 문제는 없겠지만 distinct를 사용할 수도 있지만... WITH + GROUP BY로 중복 데이터 걸러냄
WITH ACTIVITIES AS 
(
    SELECT  sell_date, product
      FROM  ACTIVITIES
     GROUP  BY sell_date, product
)   -- delete duplicates 

SELECT  a1.sell_date AS sell_date
      , COUNT(a1.product) AS num_sold
      , (SELECT GROUP_CONCAT(product ORDER BY product SEPARATOR ',') FROM ACTIVITIES a2 WHERE a1.sell_date = a2.sell_date) AS products
  FROM  ACTIVITIES a1
 GROUP  BY 1
 ORDER  BY 1
;



/*오답노트*/
-- 241115: 처음 형태는 이것. "Subquery returns more than 1 row" 오류가 났다.
-- 문제를 생각해보니 GROUP_CONCAT을 아예 SELECT 안에 넣어서 해야하는건가 싶었다.
-- 근데 고치면서 보니 ㅋㅋ GROUP BY도 안했었다;;
SELECT  a1.sell_date AS sell_date
      , COUNT(a1.product) AS num_sold
      , GROUP_CONCAT(
                (SELECT product FROM ACTIVITIES a2 WHERE a1.sell_date = a2.sell_date)
                SEPARATOR ','
                ) AS products
  FROM  ACTIVITIES a1
;

-- 그룹바이를 넣었지만 같은 오류 반환.
SELECT  a1.sell_date AS sell_date
      , COUNT(a1.product) AS num_sold
      , GROUP_CONCAT(
                (SELECT product FROM ACTIVITIES a2 WHERE a1.sell_date = a2.sell_date)
                SEPARATOR ','
                ) AS products
  FROM  ACTIVITIES a1
 GROUP  BY a1.sell_date
 ORDER  BY 1
;

-- GROUP_CONCAT에 ORDER BY도 넣으면서 맞는 형태가 되었다. 그러나 문제는 원래 ACTIVITIES 테이블에 DUPLICATES가 있다는 문제가 있었다.
-- 먼저 ACTIVITIES 테이블을 정제한 테이블을 이용하도록 해야할까?. 그래서 WITH 문을 이용하여 해답을 만들었다.
SELECT  a1.sell_date AS sell_date
      , COUNT(a1.product) AS num_sold
      , (SELECT GROUP_CONCAT(product ORDER BY product SEPARATOR ',') FROM ACTIVITIES a2 WHERE a1.sell_date = a2.sell_date) AS products
  FROM  ACTIVITIES a1
 GROUP  BY 1
 ORDER  BY 1
;
