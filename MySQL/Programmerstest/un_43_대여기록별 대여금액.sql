"""
자동차 대여 기록 별 대여 금액 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151141
"""


""" 메모 """

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
-- CTE1 : 차종, 할인타입, 할인시 곱해야할 것
WITH CTE AS (
    SELECT c.car_id, c.daily_fee, 
            CAST( REGEXP_REPLACE(duration_type, '[가-힣()]', '') AS DOUBLE) AS dtype, 
            (1-discount_rate/100) AS discounted
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
    WHERE c.car_type = p.car_type 
      AND c.car_type = '트럭'
    ),
-- 히스토리, 할인타입
    CTE2 AS (
    SELECT DISTINCT h.history_id, 
           (DATEDIFF(h.end_date, h.start_date) + 1) AS restdays,
           CASE WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= 90 THEN 90
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 30 AND 89 THEN 30
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 7 AND 29 THEN 7
                ELSE 0 END dtype
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h 
         LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON h.car_id = c.car_id 
    WHERE c.car_type = '트럭'
    )

SELECT cte2.history_id, 
       cte.daily_fee * cte.discounted * cte2.restdays FEE
FROM CTE2 LEFT JOIN CTE ON cte.dtype = cte2.dtype,
    CAR_RENTAL_COMPANY_CAR c
WHERE cte.car_id = c.car_id
  AND c.car_type = '트럭'
ORDER BY 2 DESC, 1 DESC;



# combine2
# -- 차종, 차 일일대여료, 차량 별 할인타입, 할인시 곱해야할 것
# WITH CTE AS (
    SELECT c.car_id, c.daily_fee, 
            (DATEDIFF(h.end_date, h.start_date) + 1) AS restdays,
            CASE WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= 90 THEN 90
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 30 AND 89 THEN 30
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 7 AND 29 THEN 7
                ELSE 0 END dtype
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
    WHERE c.car_type = p.car_type AND c.car_id = h.car_id
      AND c.car_type = '트럭'
    # ),
