"""
과일로 만든 아이스크림 고르기
https://school.programmers.co.kr/learn/courses/30/lessons/133025
Table: FIRST_HALF
    NAME 	        TYPE	    NULLABLE
    SHIPMENT_ID	    INT(N)	    FALSE
    FLAVOR	        VARCHAR(N)	FALSE
    TOTAL_ORDER	    INT(N)	    FALSE
Table: ICECREAM_INFO
    NAME	        TYPE	    NULLABLE
    FLAVOR	        VARCHAR(N)	FALSE
    INGREDIENT_TYPE	VARCHAR(N)	FALSE

상반기 아이스크림 총주문량이 3,000보다 높으면서 아이스크림의 주 성분이 과일인 아이스크림의 맛을 총주문량이 큰 순서대로 조회하는 SQL 문을 작성해주세요.
"""


/*- mine : 먼저 조인조건과 아이스크림 맛 조건을 걸고, GROUP BY 와 HAVING 을 이용하여 주문량 조건을 건 다음, ORDER BY에 집계함수를 쓰면서 마무리. -*/

-- MySQL
SELECT t1.flavor
FROM FIRST_HALF t1, ICECREAM_INFO t2
WHERE t1.flavor = t2.flavor
  AND t2.ingredient_type = 'fruit_based'
GROUP BY 1
HAVING SUM(t1.total_order) > 3000
ORDER BY SUM(t1.total_order) DESC;



-- 복습
-- 230930:0
