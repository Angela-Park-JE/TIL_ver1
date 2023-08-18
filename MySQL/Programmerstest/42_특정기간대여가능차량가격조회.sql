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

/*- mine : '해당 기간동안 빌릴 수 없는 차'를 리스트로 만들어서 NOT IN 을 하는게 논리적이었다.
    해결하는데 밤새 하다가 안됙, 다음날 25분정도 차분히 기간의 문제가 컸다. 기간을 구하는 논리를 잘 생각해야 하는 것이었다. 
    먼저 unavailable for rent 리스트를 만들고 거기에 살을 붙여나갔다. -*/

-- MySQL
SELECT c.car_id, c.car_type, CAST(c.daily_fee * 30 * (1-p.discount_rate/100) AS signed integer) fee
FROM CAR_RENTAL_COMPANY_CAR c JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p 
    ON c.car_type = p.car_type AND p.duration_type LIKE '30%'       -- 차종으로 결합하고 기간은 30일로 연결
WHERE c.car_id NOT IN
            (
            SELECT DISTINCT car_id    -- (조건2) 대여 불가능한 car_id 목록
            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
            WHERE (EXTRACT(YEAR_MONTH FROM start_date) = 202211)    -- 대여 날이 22년11월이거나
               OR (EXTRACT(YEAR_MONTH FROM end_date) = 202211)      -- 반납 날이 22년11월이거나
               OR (start_date <= '2022-11-01' AND '2022-11-01' <= end_date) -- 대여 날과 반납 날 사이에 2022년 11월이 있거나(하루만으로 검색해도 됨 다른 날들은 위에서 걸러줌)
            )
  AND c.car_type IN ('세단', 'SUV')    -- (조건1) 세단과 SUV만
HAVING fee BETWEEN 500000 AND 2000000 -- (조건3) 엄밀히 하자면 BETWEEN이 아니라 >=, < 을 사용해야 한다. 아니면 200만 대신 1999900을 쓰거나.
ORDER BY 3 DESC, 2 ASC, 1 DESC;

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



-- 230818 시도: 쌓아가는 식으로 풀자, 하고 복습했는데 잘 안됨. diff 연결에서 문제를 못풀었음. 게다가 다시 복습겸 보니 해당 기간에 빌릴 수 있는 차를 구하는 논리에서도 틀렸음.
-- (1)세단과 SUV의 30일간의 대여금액, 이들의 조건은 메타 테이블에서 걸어도됨
--  SELECT c.car_id, (c.daily_fee * 30 * (100-p.discount_rate)/100) AS fee_1
--    FROM CAR_RENTAL_COMPANY_CAR c 
--         LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p ON c.car_type = p.car_type
--   WHERE c.car_type IN ('세단', 'SUV')
--     AND LEFT(p.duration_type, 2) = '30';
-- (2)50~200 인 자동차들에 대하여, 기간동안 대여가능한 자동차들의 기록별 대여료 (여기까진 됨)
--  SELECT h.history_id, c.car_id, c.daily_fee, DATEDIFF(h.end_date, h.start_date) AS diff
--    FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_RENTAL_HISTORY h,
--      (
--      SELECT c.car_id, (c.daily_fee * 30 * (100-p.discount_rate)/100) AS fee_1
--        FROM CAR_RENTAL_COMPANY_CAR c 
--             LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p ON c.car_type = p.car_type
--       WHERE c.car_type IN ('세단', 'SUV')
--         AND LEFT(p.duration_type, 2) = '30'
--      ) tmp1
--   WHERE c.car_id = h.car_id AND tmp1.car_id = c.car_id
--     AND (EXTRACT(YEAR_MONTH FROM h.start_date) != 202211 OR EXTRACT(YEAR_MONTH FROM h.end_date) != 202211) -- 기간 조건
--     AND (tmp1.fee_1)/10000 BETWEEN 50 AND 200 -- tmp1에서 거른 차종조건, 금액조건
-- (3) history별 대여금액 산출 -- 멋지게 망해버림 역시 손으로 써가면서 하는게 좋은 것 같다. 
-- SELECT DISTINCT tmp2.car_id, p.car_type, tmp2.daily_fee*p, 
--     CASE WHEN tmp2.diffs/90>=1 THEN  -- 하 하 diff

--   FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN p RIGHT JOIN -- 히스토리 별 금액 산출을 위해 join
--        (
--         SELECT h.history_id, c.car_id, c.car_type, c.daily_fee, 
--                DATEDIFF(h.end_date, h.start_date) AS diffs,
--                DATEDIFF(h.end_date, h.start_date)*c.daily_fee AS post_fee
--           FROM CAR_RENTAL_COMPANY_CAR c, CAR_RENTAL_COMPANY_RENTAL_HISTORY h,
--                 (
--                 SELECT c.car_id, (c.daily_fee * 30 * (100-p.discount_rate)/100) AS fee_1
--                   FROM CAR_RENTAL_COMPANY_CAR c 
--                        LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN p ON c.car_type = p.car_type
--                  WHERE c.car_type IN ('세단', 'SUV')
--                    AND LEFT(p.duration_type, 2) = '30'
--                 ) tmp1
--          WHERE c.car_id = h.car_id AND tmp1.car_id = c.car_id
--            AND (EXTRACT(YEAR_MONTH FROM h.start_date) != 202211 
--                 OR EXTRACT(YEAR_MONTH FROM h.end_date) != 202211) -- 기간 조건
--            AND (tmp1.fee_1)/10000 BETWEEN 50 AND 200 -- tmp1에서 거른 차종조건, 금액조건
--        ) tmp2 ON p.car_type = tmp2.car_type
