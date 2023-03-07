"""
특정 기간동안 대여 가능한 자동차들의 대여비용 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/157339
CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 
- 자동차 종류가 '세단' 또는 'SUV' 인 자동차 중 
- 2022년 11월 1일부터 2022년 11월 30일까지 대여 가능하고 
- 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차에 대해서 
자동차 ID, 자동차 종류, 대여 금액(컬럼명: FEE) 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 자동차 종류를 기준으로 오름차순 정렬, 자동차 종류까지 같은 경우 자동차 ID를 기준으로 내림차순 정렬해주세요.
"""



"""오답노트"""

-- 시도1: 처음에는 가격 계산이 잘못된건가도 했는데 방법이 잘못되진 않았다. 
-- 가격 테이블만 CTE로 구해두고, 대여가능한 차를 조회하는 HISTORY 테이블과 CTE를 연결하는 형태이다
-- 날짜 구하는 것을 잘못했었다.
WITH CTE AS
        (
        SELECT c.car_id, c.car_type, TRUNCATE(c.daily_fee * 30 * (1-p.discount_rate/100), 0) monthfee
        FROM CAR_RENTAL_COMPANY_CAR c LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
             ON c.car_type = p.car_type
        WHERE c.car_type IN ('세단', 'SUV')
          AND p.duration_type REGEXP '30'
        )

SELECT DISTINCT h.car_id, t.car_type, t.monthfee AS fee
FROM CTE t, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
WHERE h.car_id = t.car_id
  AND EXTRACT(YEAR_MONTH FROM h.start_date) != 202211    -- available for rent
  AND EXTRACT(YEAR_MONTH FROM h.end_date) != 202211
  AND t.monthfee>= 500000 AND t.monthfee<2000000
ORDER BY 3 DESC, 2 ASC, 1 DESC;



-- 시도2: 이번에는 가격 테이블과 대여가능 테이블을 따로 CTE로 구하고 메인 쿼리에서 조회하는 식으로 가져왔다.
-- 테스트 결과는 같았다.
WITH CTE1 AS -- 30 days fee by car_id in saloon and SUV
    (
    SELECT c.car_id, c.car_type, c.daily_fee, c.daily_fee * 30 * (1-p.discount_rate/100) monthfee
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
    WHERE c.car_type = p.car_type
      AND p.duration_type REGEXP '30'
    HAVING monthfee >= 500000 AND monthfee < 2000000
    ),
    CTE2 AS
    (
    SELECT DISTINCT c.car_id
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
    WHERE h.car_id = c.car_id
      AND EXTRACT(YEAR_MONTH FROM h.start_date) != 202211    -- available for rent
      AND EXTRACT(YEAR_MONTH FROM h.end_date) != 202211
      # AND !(start_date <= '2022-11-01' AND '2022-11-01' <= end_date)
      AND !('2022-11-01' BETWEEN start_date AND end_date)
      AND c.car_type IN ('세단', 'SUV')
      ORDER BY 1
    )

SELECT DISTINCT t1.car_id, t1.car_type, CAST(t1.monthfee AS signed integer) AS fee
FROM CTE1 t1
WHERE t1.car_id IN (SELECT * FROM cte2)
ORDER BY 3 DESC, 2 ASC, 1 DESC;



-- 시도3: 뭐가 잘못된건가 싶어서, 가격 출력 형식이 잘못된건가 싶어서 CAST로 바꾸고(물론 바꾸고 시도2에도 해보았다.)
-- 이번엔 조인 형식으로 넣어보았다. 그러나 결과는 같았고, 제대로 된것 같으면서도 날짜 때문인지 날짜조건을 ! 유무로 바꾸어보아도 겹치는 차량들이 자꾸 나왔다.  
SELECT DISTINCT c.car_id, c.car_type,  CAST(tb1.monthfee AS signed integer) AS fee
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h 
    LEFT JOIN CAR_RENTAL_COMPANY_CAR c ON c.car_id = h.car_id 
    LEFT JOIN 
    (
    SELECT c.car_id, c.car_type, c.daily_fee * 30 * (1-p.discount_rate/100) monthfee
    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
    WHERE c.car_type = p.car_type
      AND p.duration_type LIKE '30%'
    HAVING monthfee >= 500000 AND monthfee < 2000000
    ) tb1 ON c.car_id = tb1.car_id -- AND (tb1.monthfee >= 500000 AND tb1.monthfee < 2000000)
WHERE c.car_id = tb1.car_id 
  AND c.car_type IN ('세단', 'SUV')
  AND (EXTRACT(YEAR_MONTH FROM h.start_date) != 202211 AND EXTRACT(YEAR_MONTH FROM h.end_date) != 202211)
ORDER BY 3 DESC, 2 ASC, 1 DESC;
