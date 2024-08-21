/*-
1251. Average Selling Price
https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
  Return the result table in any order.
  Table: Prices
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | product_id    | int     |
  | start_date    | date    |
  | end_date      | date    |
  | price         | int     |
  +---------------+---------+
  Table: UnitsSold
  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | product_id    | int     |
  | purchase_date | date    |
  | units         | int     |
  +---------------+---------+
-*/


-- 240821: (2) 오답노트를 기반으로 해결 및 IFNULL로 NULL 처리!
-- sales든 unit이든 unit에 null이 있을 때 문제가 생기는 것일 거다.
-- 미리 tmp 서브쿼리에서 처리를 해놓으면 0으로 div하는 문제가 생기기 때문에
-- 다 계산이 끝난 바깥 쿼리에서 처리해주도록 썼다.
SELECT  product_id
      , IFNULL(ROUND(SUM(sales)/SUM(units), 2), 0) AS average_price
  FROM  (
        SELECT  p.product_id
              , s.purchase_date
              , s.units
              , p.price
              , s.units*p.price AS sales
          FROM  UNITSSOLD s LEFT JOIN PRICES p
                ON s.product_id = p.product_id
                AND s.purchase_date BETWEEN p.start_date AND p.end_date
        UNION 
        SELECT  p.product_id
              , s.purchase_date
              , s.units
              , p.price
              , s.units*p.price AS sales
          FROM  UNITSSOLD s RIGHT JOIN PRICES p
                ON s.product_id = p.product_id
                AND s.purchase_date BETWEEN p.start_date AND p.end_date
         ) tmp
 GROUP  BY product_id;

-- 추가로 MySQL이 아니라 MSSQL일 때의 쿼리도 짜보았다.


/*- 오답노트 -*/
-- 240817: 생각보다 복잡했다 머리로 이해가 안가는게 아닌데 ㅠㅠ피곤해서인가
-- 기간은 BETWEEN을 써도 된다. end와 start간에 overlapping이 없다.
SELECT  product_id
      , sales/SUM(units) 
  FROM  (
        SELECT  s.product_id
              , p.price*s.units AS sales
              , s.units
        FROM  UNITSSOLD s LEFT JOIN PRICES p
              ON s.product_id = p.product_id
              AND s.purchase_date BETWEEN p.start_date AND p.end_date
        ) tmp
 GROUP  BY 1;

-- (1)
-- 240821: sales의 합계를 unit의 합계로 나누어야한다. 헷갈렸었나보다다.
-- 다만 이 답이 틀린 이유는 LEFT JOIN을 썼기 때문인데, 모든 product에 대해 나와야한다는 점이 실제 케이스에서의 문제였다.
-- 이 쿼리는 UnitsSold에 없는(판매량이 없는) 품목에 대해서 출력하지 않는다.
SELECT  product_id
      , ROUND(SUM(sales)/SUM(units), 2) AS average_price
  FROM  (
        SELECT  s.product_id
              , s.units
              , p.price
              , s.units*p.price AS sales
          FROM  UNITSSOLD s LEFT JOIN PRICES p
                ON s.product_id = p.product_id
                AND s.purchase_date BETWEEN p.start_date AND p.end_date
         ) tmp
 GROUP  BY product_id;

-- (2)
-- 240821: 두 번째 오답에 대해서는 FULL OUTER JOIN이 필요하다.
-- MySQL은 FULL OUTER JOIN을 지원하지 않기에 UNION을 써야 했다.
-- 그러나 id=2인 물건에서만 계산이 다르게 나왔다.
-- 아마도 같은 가격과 units를 공유하는 다른 purchase_date의 문제일 것으로 예상했다. (2월 4일과 9일은 같은 수량에 같은 가격이다)
SELECT  product_id
      , ROUND(SUM(sales)/SUM(units), 2) AS average_price
  FROM  (
        SELECT  p.product_id
              , s.units
              , p.price
              , s.units*p.price AS sales
          FROM  UNITSSOLD s LEFT JOIN PRICES p
                ON s.product_id = p.product_id
                AND s.purchase_date BETWEEN p.start_date AND p.end_date
        UNION 
        SELECT  p.product_id
              , s.units
              , p.price
              , s.units*p.price AS sales
          FROM  UNITSSOLD s RIGHT JOIN PRICES p
                ON s.product_id = p.product_id
                AND s.purchase_date BETWEEN p.start_date AND p.end_date
         ) tmp
 GROUP  BY product_id;
