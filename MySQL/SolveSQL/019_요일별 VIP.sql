/*
데이터리안 SQL 캠프 실전반> 레스토랑의 요일별 VIP
https://solvesql.com/problems/restaurant-vip/
*/


-- 250718: 살짝 고민을 했었다. 그래서 RIGHT JOIN으로 (비효율적으로 보이나) 풀었다.
SELECT  tips.*
  FROM  tips  
        RIGHT JOIN  (
                      SELECT  day
                            , MAX(total_bill) AS total_bill
                        FROM  tips
                       GROUP  BY day
                    ) AS maxbill
                  ON tips.day = maxbill.day AND tips.total_bill = maxbill.total_bill
;
