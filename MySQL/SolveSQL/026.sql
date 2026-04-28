/*
Rolling retention
https://solvesql.com/problems/monthly-rolling-retention/
*/


/*풀이과정*/
-- 우선 계산해야한 리텐션 기간이 언제까지인지 보려고 한다
SELECT  MIN(last_order_date), MAX(last_order_date)
  FROM  customer_stats
;
