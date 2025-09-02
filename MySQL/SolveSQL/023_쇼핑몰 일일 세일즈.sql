/*
연습 문제> 쇼핑몰의 일일 매출액
https://solvesql.com/problems/olist-daily-revenue/
*/


-- 250902: Olist 데이터셋으로 하는 SQL 문제! 반갑다.

/*풀이*/
-- olist_order_payments_dataset 매출의 결제 수단과 금액이 기록된 데이터 셋인데, order_id별로 COUNT(*)가 1보다 큰 경우도 있다.
-- 즉 복합 결제가 가능한 방식이다.
SELECT  order_id, COUNT(*) 
  FROM  olist_order_payments_dataset 
 GROUP  BY order_id
HAVING COUNT(*) > 1
;

-- 일일 매출액은 시간 별로 주문금액을 붙여야 한다.
-- 간단하게 주문서에 payment_value를 붙이면 다음과 같다.
SELECT  *
  FROM  olist_orders_dataset o  
        LEFT JOIN  olist_order_payments_dataset op
        ON o.order_id = op.order_id

  ORDER  BY o.order_id
;

-- 그러나 문제가 있다. payment_sequential이라는 지점인데, 이것이 연속 결제 횟수라는 의미로
-- 할부에 따라 몇 번째 payment인지가 뜨는 것이다.

-- 그렇다면 이 sql 질문에서 원하는 것은 무엇인가?
-- payment_value는 할부 전 금액인가? 그렇다면 이후 결제 금액(payment_sequential이 2 이상인 것)은 매출에 포함되어선 안된다.
-- 아니면 payment_value는 해당 월에 들어오는 금액인가? 그렇다면 payment_sequential이 같이 포함이 되어야 한다.
-- 즉 30만원을 이번달에 5개월 무이자할부로 질렀을 때 30만원이 지른날 매출에 잡히느냐, 6만원이 월간 매출에 잡히느냐의 궁금증이 있다.

-- 그러나 내가 알기로 이 데이터셋에서는 복합 결제가 가능하여 할부 뿐 아니라 바우처 등으로도 함께 결제가 가능하다. 
-- 따라서, payments데이터 셋에는 order_id 건당 결제 방법이 여러가지로 존재할 수 있다. 1:N이므로 RIGTH JOING이 필요한 시점이다.
SELECT  *
  FROM  olist_orders_dataset o  
        RIGHT JOIN  olist_order_payments_dataset op
        ON o.order_id = op.order_id

 ORDER  BY o.order_id
;

-- 전체적인 기본 가정은 이것이다.
-- - order_purchase_timestamp 이 매출 날짜로 정해진다(order_approved_at 가 아니라)
-- - 복합결제가 가능하다.
