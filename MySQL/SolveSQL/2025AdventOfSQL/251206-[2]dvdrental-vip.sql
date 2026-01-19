/*
우수 고객 찾기
https://solvesql.com/problems/dvdrental-vip/
*/


-- 251206: "유효 고객 중" 이 키워드!
SELECT  customer_id
  FROM  rental
 WHERE  customer_id IN (SELECT DISTINCT customer_id FROM customer WHERE active = 1)
 GROUP  BY 1
HAVING  COUNT(rental_id) >= 35
;
