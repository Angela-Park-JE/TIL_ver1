/*
https://solvesql.com/problems/daily-revenue/
우리는 요일을 빼고 싶을 때 날이 아니라 요일이라고 말하기로 했어요...ㅜ 아무튼 조건은 HAVING에.
*/

-- 250614
SELECT  day
      , SUM(total_bill) AS revenue_daily
  FROM  tips
 GROUP  BY day
HAVING  SUM(total_bill)>=1000
 ORDER  BY 2 DESC
 ;
