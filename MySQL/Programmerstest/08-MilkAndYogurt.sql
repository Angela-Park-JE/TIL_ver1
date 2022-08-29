"""
CART_PRODUCTS 테이블은 장바구니에 담긴 상품 정보를 담은 테이블입니다. 
CART_PRODUCTS 테이블의 구조는 다음과 같으며, ID, CART_ID, NAME, PRICE는 각각 테이블의 아이디, 장바구니의 아이디, 상품 종류, 가격을 나타냅니다.
  NAME	TYPE
  ID	INT
  CART_ID	INT
  NAME	VARCHAR
  PRICE	INT
데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 
우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 이때 결과는 장바구니의 아이디 순으로 나와야 합니다.
"""

/*- MySQL : 한 한시간 끌 줄 알았는데 충격적이게도 5분만에 끝나버린문제... 해커랭크는 대체 어떤 곳이었던 것이야... -*/
WITH c1 AS
        (SELECT cart_id
        FROM CART_PRODUCTS
        WHERE 1=1 
            AND name = 'Milk'),
    c2 AS
        (SELECT cart_id
        FROM CART_PRODUCTS
        WHERE 1=1
            AND name = 'Yogurt')

SELECT c1.cart_id
FROM c1, c2
WHERE c1.cart_id = c2.cart_id
ORDER BY 1;

/*- Oracle : 처음 풀이가 너무 길기 때문에 줄여본 것 -*/
SELECT c1.cart_id
FROM CART_PRODUCTS c1, CART_PRODUCTS c2
WHERE c1.cart_id = c2.cart_id 
    AND c1.name = 'Milk'
    AND c2.name = 'Yogurt'
ORDER BY 1;
