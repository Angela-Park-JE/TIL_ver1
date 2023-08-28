"""
식품분류별 가장 비싼 식품의 정보 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/131116
FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 
이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.
"""

/*- mine : MAX(price), product_id 이렇게 같이 둬버리면 product_id는 랜덤으로 같이 붙어버린다. 
    그래서 이럴 때는 GROUP BY 보다는 파티션으로 나눠놓고 조건으로 검색하는 것이 훨씬 절차가 줄어든다. 
    물론 카테고리별 price 맥스를 내어놓고 카테고리와 맥스를 일치하는 조건으로 서브쿼리를 이용하는 것도 나쁜 방법은 아니지만, 
    항상 그 방법을 사용할 때 마음에 걸리는 것은 같은 값을 가지는 두 MAX row가 있을 수 있다는 점이 문제이다. 
    파티션을 사용하면 맥스 중 하나만 출력을 원하는 경우에도 WINDOW 절에 ORDER BY 를 이용하면 되기 때문에 문제가 간단해진다.
    
    그리고 카테고리 제한에는 `WHERE category LIKE REGEXP '과자|국|김치|식용유'` 식으로도 해도 되지만, 
    들어가는 로우를 추출하는 느낌보다는 일치하는 로우를 추출하는 것이기 때문에 in 이 더욱 적합하다고 판단했다.
    대충 7분 정도 걸린 것 같다. 빠른 속도는 아니다. -*/

-- MySQL
SELECT category, max_price, product_name
FROM
    (
    SELECT category, product_id, product_name, 
           price, MAX(price) OVER (PARTITION BY category) max_price
    FROM FOOD_PRODUCT
    WHERE category in ('과자', '국', '김치', '식용유')
    ) tmp1
WHERE max_price = price
ORDER BY 2 DESC;



-- 복습
-- 230828: product_id로 조인을 하다가 서브 쿼리에서 올바른 id가 안나왔을 수도 있겠다 생각함. 이전의 나 정말 잘 활용했구나. 과거의 내가 정답이다!
-- 틀린 것
SELECT p1.category, p2.mp max_price, p1.product_name
FROM FOOD_PRODUCT p1,
    (
    SELECT category, MAX(price) mp, product_id
      FROM FOOD_PRODUCT
     WHERE category IN ('과자', '국', '김치', '식용유')
     GROUP BY category
    ) p2
 WHERE p1.product_id = p2.product_id
 GROUP BY p1.category
 ORDER BY 2 DESC;

-- 정답: 카테고리와 가격으로 조인을 시켰음. 
SELECT p1.category, p1.price max_price, p1.product_name
FROM FOOD_PRODUCT p1,
    (
    SELECT category, MAX(price) mp, product_id
      FROM FOOD_PRODUCT
     WHERE category IN ('과자', '국', '김치', '식용유')
     GROUP BY category
    ) p2
 WHERE p1.category = p2.category
   AND p1.price = p2.mp
 GROUP BY p1.category
 ORDER BY 2 DESC;
