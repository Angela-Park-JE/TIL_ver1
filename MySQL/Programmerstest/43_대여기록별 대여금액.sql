"""
자동차 대여 기록 별 대여 금액 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151141
"""


"""메모"""

-- 코드를 입력하세요
-- CAR_RENTAL_COMPANY_CAR c CAR_RENTAL_COMPANY_RENTAL_HISTORY h CAR_RENTAL_COMPANY_DISCOUNT_PLAN p

-- 1. history 별 트럭의 해당 차량의 대여요금과 대여기간과 해당 차량의 대여요금
SELECT h.history_id, c.car_id, c.daily_fee, DATEDIFF(h.end_date, h.start_date) + 1 AS dates
  FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON h.car_id = c.car_id
 WHERE c.car_type = '트럭';

-- 2. 할인 기간 구간 별 할인율
SELECT CAST( REGEXP_REPLACE(duration_type, '[가-힣()]', '') AS DOUBLE) AS dtype, (1-discount_rate/100) discounted
  FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN 
 WHERE car_type = '트럭';

-- combine
WITH CTE AS (
SELECT car_type, CAST( REGEXP_REPLACE(duration_type, '[가-힣()]', '') AS DOUBLE) AS dtype, (1-discount_rate/100) discounted
  FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN 
    )

SELECT DISTINCT h.history_id, 
       CASE WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= cte.dtype 
            THEN cte.discounted * daily_fee * DATEDIFF(h.end_date, h.start_date) + 1 
            WHEN 
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON h.car_id = c.car_id, CTE 
WHERE c.car_type = '트럭' AND c.car_type = cte.car_type;
