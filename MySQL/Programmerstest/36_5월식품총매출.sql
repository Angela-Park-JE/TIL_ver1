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

-- 240520: 이전과 달리 특별히 가독성이 높아진건 아닌 것 같지만 지금 쓰는 방식이 쿼리가 길어졌을 때 더 편할 것 같다. 피어 피드백 받을때도 부분별로 주석 달기 더 편해보이고
-- 재미있는 건 세 번 풀때 전부 다른 형식의 조인을 사용한게 인상적이다.
-- 아무튼 'produce_date' 컬럼명 오타 한 번 났던것 외에는 쓰면서 문제읽고 풀었다. 어려운 문제들 많이 만나고 싶다.
SELECT  fo.product_id
      , fp.product_name
      , SUM(fo.amount * fp.price) AS total_sales
  FROM  FOOD_ORDER fo 
        LEFT JOIN FOOD_PRODUCT fp ON fo.product_id = fp.product_id
 WHERE  EXTRACT(YEAR_MONTH FROM fo.produce_date) = '202205'
 GROUP  BY 1  -- 아물론 fo.product_id 해도되는데 코테문제에서는 괜히 빨리 풀고 싶어서 ㅋㅋㅋ
 ORDER  BY 3 DESC, 1 ASC;
