"""
코딩테스트 연습> String, Date> 조건별로 분류하여 주문상태 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131113
문제
FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 
출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.
"""


  
-- 맨 처음 썼던 것
SELECT order_id, product_id, DATE_FORMAT(out_date, '%Y-%m-%d') out_date,
        CASE WHEN out_date IS NULL THEN '출고미정'
            WHEN out_date >'2022-05-01' THEN '출고대기'
            WHEN out_date <='2022-05-01' THEN '출고완료'
            END '출고여부'
FROM FOOD_ORDER 
ORDER BY 1;



-- 복습
-- 230906: dateformat을 지켜주어야 한다.
-- 이전에 훨씬 직관적으로 잘 풀었었는데, 굳이 이렇게... 아니 부등호가 자꾸 안먹었는걸 어찌해요!
SELECT order_id, product_id, DATE_FORMAT(out_date, '%Y-%m-%d') out_date,
    CASE WHEN out_date IS NULL THEN '출고미정'
         WHEN (EXTRACT(YEAR_MONTH FROM out_date) < 202205) OR 
              (DATE_FORMAT(out_date, '%Y-%m-%d') = '2022-05-01') THEN '출고완료' 
         ELSE '출고대기'
         END '출고여부'
FROM FOOD_ORDER
ORDER BY 1;

-- 231229: 어려울 것 없이 쓰긴 썼다. 다음부터는 문제에서도 연도까지 명확하게 얘기해주면 좋을 것 같다.
SELECT order_id, product_id, DATE_FORMAT(out_date, '%Y-%m-%d'), 
        CASE WHEN out_date <= '2022-05-01' THEN '출고완료' 
             WHEN out_date > '2022-05-01' THEN '출고대기' 
             WHEN out_date is NULL THEN '출고미정' 
             END '출고여부'
  FROM FOOD_ORDER
 ORDER BY order_id;
