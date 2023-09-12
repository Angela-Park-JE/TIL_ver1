"""
특정 옵션이 포함된 자동차 리스트 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/157343
Column name	  Type  	    Nullable
CAR_ID	      INTEGER	    FALSE
CAR_TYPE	  VARCHAR(255)	FALSE
DAILY_FEE     INTEGER	    FALSE
OPTIONS	      VARCHAR(255)  FALSE
CAR_RENTAL_COMPANY_CAR 테이블에서 '네비게이션' 옵션이 포함된 자동차 리스트를 출력하는 SQL문을 작성해주세요. 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 네비게이션을 option에 포함에 되어있는지 문자열 검색하여 있기만 하면 다 가져오도록 INSTR을 사용하였다. -*/

-- MySQL
SELECT car_id, car_type, daily_fee, options
FROM CAR_RENTAL_COMPANY_CAR
WHERE INSTR(options, '네비게이션') > 0
ORDER BY 1 DESC;



-- 복습
