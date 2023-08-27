"""
5월 식품들의 총매출 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/131117
FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 
이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 크게 어렵지 않다. 집계 기준을 잘 잡아주는 것, 그리고 조건을 검색할 방식만. EXTRACT 가 진짜 편한 방식이다. ㅎㅎ -*/

-- MySQL
SELECT p.product_id, p.product_name, SUM(o.AMOUNT)*p.price AS total_sales
FROM FOOD_PRODUCT p, FOOD_ORDER o
WHERE o.product_id = p.product_id
  AND EXTRACT(YEAR_MONTH FROM o.produce_date) = 202205
GROUP BY p.product_id
ORDER BY 3 DESC, 1 ASC;



-- 복습
-- 230827: 비슷한듯 하면서 다르다. SUM을 가격과 주문량 곱한 상태로 더한 것과, right join으로 명시한 점.
SELECT p.product_id, p.product_name, SUM(p.price*o.amount)
  FROM FOOD_PRODUCT p RIGHT JOIN FOOD_ORDER o ON p.product_id = o.product_id
 WHERE EXTRACT(YEAR_MONTH FROM o.produce_date) = '202205'
 GROUP BY p.product_id
 ORDER BY 3 DESC, 1 ASC;
