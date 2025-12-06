/*
12월엔 누가누가 많이 샀나
https://solvesql.com/problems/whales-of-december/
*/


-- 251204: HAVING을 물어보는 문제
SELECT  customer_id
  FROM  records
 WHERE  MONTH(order_date) = 12
 GROUP  BY customer_id
HAVING  SUM(sales)>=1000
;
