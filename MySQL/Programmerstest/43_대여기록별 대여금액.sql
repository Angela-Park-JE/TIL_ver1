"""
자동차 대여 기록 별 대여 금액 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151141
CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 
자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
"""

/*- mine : 3차 시도 하면서 메인쿼리의 JOIN이 LEFT를 해줘야 하는데  바꿨는데 잘 되었다. 
    내 코드의 목표는 1. 기존 테이블 조회 자체 최소화 : 각각 한번씩만 등장함
                 2. 서브쿼리 및 조인 사용 자제 : 서브쿼리는 피할 수 없었고, CTE를 서브쿼리로 넣어서 조인을 시킬 수도 있지만,
                    이해하는 구조 상, 어떤 순서로 어떤 식으로 풀이를 하려는지 보는 사람도 이해가 신속히 이루어졌으면 해서 WITH로 뺐던 것이다. -*/

-- MySQL
-- 1. 대여기록 별 기간 및 대여 차량에 따른 일일 대여 요금, 대여기간 별 할인율 적용안
-- 트럭은 맨 나중에 걸러도 되는데 간단하지만 중복이 없도록 CTE에서부터 가져가기로 함.
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
            WHEN cte.dtype!=0 THEN CAST(cte.daily_fee * cte.rentdays * (1-p.discount_rate/100) AS SIGNED INTEGER) 
			    END FEE                                             -- CASE로 CTE의 dtype 걸러주지 않으면 p.duration_type에는 0이 없으므로 NULL 이 떠버림.
  FROM CTE cte LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p 
              ON cte.car_type = p.car_type                          -- join condition 1
                 AND cte.dtype = CAST( REGEXP_REPLACE(p.duration_type, '[가-힣()]', '') AS DOUBLE) -- join condition 2 "by discount rate"
 WHERE cte.car_type = '트럭'                                         -- car type condition
 ORDER BY 2 DESC, 1 DESC;



"""복습"""
-- 231106: 이전에 푼게 더 짧네. 이전은 dtype(여기서의 difftype)이 0인것 혹은 0이 아닌 것을 나누어서 CASE WHEN을 썼고, 
	-- LEFT JOIN을 했기 때문에 메인쿼리에서 조인을 할 때 CAST로 걸러낸 것과 같은 것이 옆으로 붙도록 만드렁ㅆ다.
-- 차종이 다른것을 찾게될 경우를 생각하여 미리부터 필터링하지 않는다.
-- 1. discount plan부터 봐야한다. 숫자로 되어있지 않으므로 바꾼다.
-- https://selfdevelope.tistory.com/616 참조 : REGEXP_REPLACE
WITH CTE1 AS
(
SELECT car_type, 
        REGEXP_REPLACE(duration_type, '[^0-9]', '') duration, 
        (100-discount_rate)*0.01 discounted_rate
  FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN as rdp
 UNION 
SELECT DISTINCT car_type, 
        0, 1
  FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN as tmp
        -- plan_id는 있으나 없으나 하기 때문에 없애고 plan이 없는것을 넣어 조인이 잘 되도록 함
),
-- 2. 대여기록에 대해서 날짜 차이 구하기
-- 1일 대여 2일 반납이면 이틀 대여한 것으로 취급한다. (반납일을 포함함)
CTE2 AS 
(
SELECT history_id, car_id, DATEDIFF(end_date, start_date) + 1 date_diff, 
  CASE WHEN DATEDIFF(end_date, start_date) + 1 <7 THEN 0 
       WHEN DATEDIFF(end_date, start_date) + 1 >=7 AND DATEDIFF(end_date, start_date) + 1 <30 THEN 7
       WHEN DATEDIFF(end_date, start_date) + 1 >=30 AND DATEDIFF(end_date, start_date) + 1 <90 THEN 30
       WHEN DATEDIFF(end_date, start_date) + 1 >=90 THEN 90 
       END AS difftype
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
)

-- 이렇게만 했을 때에는 7일 이하가 걸러지지 않는다. 마지막 쿼리를 짧게 짜는게 제일 보기 깔끔하다고 생각하는 편.. 트럭이 아닌 차를 구하려면 WHERE절만 고치면 된다.
SELECT history_id, ROUND(daily_fee*date_diff*discounted_rate, 0) AS FEE
  FROM CTE2 LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON CTE2.car_id = c.car_id
          LEFT JOIN CTE1 ON c.car_type = CTE1.car_type AND CTE1.duration = CTE2.difftype -- 바로이부분때문에! 0인 플랜을 넣어주어야 한다.
 WHERE CTE1.car_type = '트럭'
 ORDER BY 2 DESC, 1 DESC;



"""풀이하면서 메모했던 것들"""

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
-- 이 방법의 경우 0일때 (7일 미만일 때)를 해결하지 못함.

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
