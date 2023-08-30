"""
가장 비싼 상품 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131697
PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 MAX_PRICE로 지정해주세요.
"""

/*- mine : 가끔 이렇게 쉬운 문제를 보면 내가 무엇인가 놓치고 있는게 아닐까 하는 생각이 든다. 그런 생각이 들었음을 적기위해 git 한 것. -*/

-- MySQL
SELECT MAX(price) MAX_PRICE
FROM PRODUCT;



"""
작년에 풀었던 문제이긴 한데 그래도 이런식으로 푼 기억이 있구나 하고 적는 것

최댓값 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/59415
가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
"""

/*- mine: 답을 두가지를 적어놨었다. MAX라서 LIMIT 을 쓸 필요가 없다. -*/

-- MySQL
-- SELECT MAX(datetime) as datetime
-- FROM ANIMAL_INS
-- GROUP BY datetime
-- LIMIT 1;

SELECT MAX(datetime) AS '시간' FROM ANIMAL_INS;
 
