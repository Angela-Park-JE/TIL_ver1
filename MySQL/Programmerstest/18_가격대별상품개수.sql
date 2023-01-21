"""
가격대 별 상품 개수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131530
PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 
이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 
가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 
결과는 가격대를 기준으로 오름차순 정렬해주세요.
"""

/*- mine : 처음에는 RECURSIVE 에서 MAX(price)를 바로 썼었는데, 원래 있는 가격대에서 초과해서 나오게 되었다. 그래서 수정한게 -10000 을 준것.
    그리고 LEFT JOIN 을 했는데, 테스트 케이스는 0이 0개이고, 아예 개수가 없는 사항에 대해서는 뜨면 안됐었다. 
    그래서 LEFT -> RIGHT 으로 바꾸니 정답으로 인식되었다. 그런 조건에 대해서는 상세하게 적어주면 정말 좋겠다. (예시에서는 0이 1개로 있었음) -*/

-- MySQL

WITH RECURSIVE AMT AS
    (SELECT 0 AS prc
     UNION ALL
     SELECT prc + 10000
     FROM AMT
     WHERE prc < (SELECT (MAX(price) - 10000) FROM PRODUCT)
    )

SELECT a.prc PRICE_GROUP, COUNT(p.product_id) PRODUCTS
FROM AMT a RIGHT JOIN PRODUCT p ON a.prc = TRUNCATE(p.price, -4)
GROUP BY a.prc
ORDER BY 1;
