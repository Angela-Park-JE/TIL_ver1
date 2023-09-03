"""
조건별로 분류하여 주문상태 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131113

Column name     	Type	    Nullable
ORDER_ID	        VARCHAR(10)	FALSE
PRODUCT_ID	        VARCHAR(5)	FALSE
AMOUNT	            NUMBER	    FALSE
PRODUCE_DATE    	DATE	    TRUE
IN_DATE	            DATE	    TRUE
OUT_DATE        	DATE	    TRUE
FACTORY_ID	        VARCHAR(10)	FALSE
WAREHOUSE_ID    	VARCHAR(10)	FALSE

FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 
출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.
"""

/*- mine : 날짜 포맷 때문에 적어두는 글. 자주 까먹는다. -*/

-- MySQL
SELECT order_id, product_id, DATE_FORMAT(out_date, '%Y-%m-%d') out_date,
        CASE WHEN out_date IS NULL THEN '출고미정'
            WHEN out_date >'2022-05-01' THEN '출고대기'
            WHEN out_date <='2022-05-01' THEN '출고완료'
            END '출고여부'
FROM FOOD_ORDER 
ORDER BY 1;



— 복습
- 
