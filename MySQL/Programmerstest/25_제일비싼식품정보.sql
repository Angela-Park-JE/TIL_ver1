"""
가격이 제일 비싼 식품의 정보 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131115
Column name 	Type	    Nullable
PRODUCT_ID	    VARCHAR(10)	FALSE
PRODUCT_NAME	VARCHAR(50)	FALSE
PRODUCT_CD	    VARCHAR(10)	TRUE
CATEGORY	    VARCHAR(10)	TRUE
PRICE       	NUMBER  	TRUE
FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
"""


/*- mine : where 절에서 max 가격을 찾는 것으로 가장 간단한 방법 사용. 
    만약 다른 것 순으로 한 가지만 출력해야 한다면 `ORDER BY 기준 LIMIT 1` 을 쓰면 될 것이다.
    그룹 별로 해야 한다면 그룹 별로 맥스를 구한 뒤 그것으로 그룹=그룹, 가격=가격으로 검색하면 될 듯. -*/

-- MySQL 
SELECT product_id, product_name, product_cd, category, price
FROM FOOD_PRODUCT 
WHERE price = (SELECT MAX(price) FROM FOOD_PRODUCT);
