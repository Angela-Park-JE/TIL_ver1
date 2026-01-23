/*
거래량
https://solvesql.com/problems/yearly-net-sales/
*/


-- 251225: 반품되지 않은-이라는 암묵적 형태에 대해 알려주려고 넣은 문제같다.
SELECT  YEAR(purchased_at) AS year
      , SUM(total_price-discount_amount) AS net_sales
  FROM  transactions
 WHERE  is_returned = 0
 GROUP  BY YEAR(purchased_at)
 ORDER  BY 1
 ;
