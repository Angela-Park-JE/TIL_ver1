"""
가장 비싼 상품 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131697
PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 MAX_PRICE로 지정해주세요.
"""

/*- mine : 가끔 이렇게 쉬운 문제를 보면 내가 무엇인가 놓치고 있는게 아닐까 하는 생각이 든다. 그런 생각이 들었음을 적기위해 git 한 것. -*/

-- MySQL
SELECT MAX(price) MAX_PRICE
FROM PRODUCT;
