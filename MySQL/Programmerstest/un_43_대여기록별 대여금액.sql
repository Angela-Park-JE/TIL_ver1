"""
자동차 대여 기록 별 대여 금액 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151141
"""


""" 메모 """

"""시도 1"""

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


"""시도2"""
-- combine2
-- 차종, 차 일일대여료, 차량 별 할인타입, 할인시 곱해야할 것
-- WITH CTE AS (
    SELECT c.car_id, c.daily_fee, 
            (DATEDIFF(h.end_date, h.start_date) + 1) AS restdays,
            CASE WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= 90 THEN 90
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 30 AND 89 THEN 30
                WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 7 AND 29 THEN 7
                ELSE 0 END dtype
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
    WHERE c.car_type = p.car_type AND c.car_id = h.car_id
      AND c.car_type = '트럭'
--     ),



"""시도3"""
-- AGAIN! 가장 가깝게 나왔다. 그러나 어디문제인지 안된다. 일단 중요한건 WITH를 쓰고싶지 않았는데 썼다는 점이다. --
-- 트럭은 맨 나중에 걸러도 되는데, 
-- 1. 대여기록 별 기간 및 대여 차량에 따른 일일 대여 요금, 대여기간 별 할인율 적용안
WITH CTE AS
      (
          SELECT h.history_id, h.car_id, c.car_type, c.daily_fee, 
                  (DATEDIFF(h.end_date, h.start_date) + 1) AS rentdays, 
                  CASE WHEN DATEDIFF(h.end_date, h.start_date) + 1 >= 90 THEN 90
                      WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 30 AND 89 THEN 30
                      WHEN DATEDIFF(h.end_date, h.start_date) + 1 BETWEEN 7 AND 29 THEN 7
                      ELSE 0 END dtype
          FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON h.car_id = c.car_id
      )

-- 2. 대여기간에 따른 할인율을 적용할 수 있도록 하는 할인 기준 적용을 위에서 
-- CTE에서 만들었던 dtype과 PLAN 테이블의 duration_type컬럼을 기준으로 서로 조인시킴. 
SELECT cte.history_id, 
    CASE WHEN cte.dtype =0 THEN cte.daily_fee * cte.rentdays
         WHEN cte.dtype!=0 THEN 
        CAST(cte.daily_fee * cte.rentdays * (1-p.discount_rate/100) AS SIGNED INTEGER) 
        END FEE
  FROM CTE cte, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
 WHERE cte.car_type = '트럭'      -- car type condition
   AND cte.car_type = p.car_type -- join condition 1
   AND cte.dtype = CAST( REGEXP_REPLACE(p.duration_type, '[가-힣()]', '') AS DOUBLE)   -- join condition 2 "by discount rate"
 ORDER BY 2 DESC, 1 DESC;
