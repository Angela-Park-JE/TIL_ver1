/* 
데이터리안 SQL 캠프 입문반> 할부는 몇 개월로 해드릴까요 
https://solvesql.com/problems/installment-month/ 
*/

-- 240409: 되게 쉬운 문제인데, 데이터를 한 번 보지 않아 시간이 걸렸다. payment_type이 신용카드만 걸려야 하고,
-- COUNT에서 order_id를 DISTINCT로 해주어야 한다.
-- 두 칸씩 띄어서 쓰니까 확실히 탭할 때 조금 편한 것 같다! (모원서 강사님 감사해요!)
SELECT  payment_installments, 
        COUNT(DISTINCT order_id) AS order_count, 
        MIN(payment_value) AS min_value, 
        MAX(payment_value) AS max_value,
        AVG(payment_value) AS avg_value
  FROM  olist_order_payments_dataset
 WHERE  payment_type = 'credit_card'
 GROUP  BY payment_installments
 ORDER  BY 1;
