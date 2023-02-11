"""
대여 기록이 존재하는 자동차 리스트 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/157341
Table: CAR_RENTAL_COMPANY_CAR
Column name 	Type	        Nullable
CAR_ID	        INTEGER	        FALSE
CAR_TYPE	    VARCHAR(255)	FALSE
DAILY_FEE	    INTEGER	        FALSE
OPTIONS 	VARCHAR(255)	    FALSE
Table: CAR_RENTAL_COMPANY_RENTAL_HISTORY
Column name	    Type	    Nullable
HISTORY_ID  	INTEGER	    FALSE
CAR_ID	        INTEGER	    FALSE
START_DATE  	DATE	    FALSE
END_DATE	    DATE	    FALSE

CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 자동차 종류가 '세단'인 자동차들 중 
10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL문을 작성해주세요. 
자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.
"""

/*- mine : 기록에 자동차정보를 LEFT JOIN 시킨 방법이 가장 정석 같다. 물론 WHERE 절을 활용해서 간접적인 조인도 가능할 것으로 보인다. -*/

-- MySQL
SELECT DISTINCT t1.car_id
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY t1 
    LEFT JOIN CAR_RENTAL_COMPANY_CAR t2 ON t1.car_id = t2.car_id
WHERE MONTH(t1.start_date) = 10
  AND t2.car_type = '세단'
ORDER BY 1 DESC;

-- MySQL
SELECT DISTINCT t1.car_id
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY t1, CAR_RENTAL_COMPANY_CAR t2
WHERE t1.car_id = t2.car_id
  AND MONTH(t1.start_date) = 10
  AND t2.car_type = '세단'
ORDER BY 1 DESC;
