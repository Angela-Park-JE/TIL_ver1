"""
오프라인/온라인 판매 데이터 통합하기
https://school.programmers.co.kr/learn/courses/30/lessons/131537
ONLINE_SALE 테이블과 OFFLINE_SALE 테이블에서 2022년 3월의 오프라인/온라인 상품 판매 데이터의 판매 날짜, 상품ID, 유저ID, 판매량을 출력하는 SQL문을 작성해주세요. 
OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 로 표시해주세요. 
결과는 판매일을 기준으로 오름차순 정렬해주시고 판매일이 같다면 상품 ID를 기준으로 오름차순, 상품ID까지 같다면 유저 ID를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 왜 다르지? 계속 생각했다. 그런데 결과를 보면 다른 점이 sales_date가 연월일만 표시됐다는 점이다. 
    원래 데이터는 datetime 형식으로 되어있다. 이것을 굳이 바꾸라는 말이 없이, 판매 날짜라고만 쓰여있고, 심지어 예시 테이블에는 datetime이 아니라 date 처럼 적혀있다. 
    ...? 그리고 OFFLINE_SALE에는 3월건이 없어서 제대로 됐는지 알기도 어렵게 되어있다. 투정같이 되어버렸지만, 다른 정답을 보고서야 알았던 것이다... -*/

-- MySQL : date 포맷만 바꾼 것
SELECT DATE_FORMAT(sales_date, '%Y-%m-%d') AS sales_date, product_id, user_id, sales_amount
FROM ONLINE_SALE
WHERE EXTRACT(YEAR_MONTH FROM sales_date) = '202203'
UNION
SELECT DATE_FORMAT(sales_date, '%Y-%m-%d') AS sales_date, product_id, NULL user_id, sales_amount
FROM OFFLINE_SALE
WHERE EXTRACT(YEAR_MONTH FROM sales_date) = '202203'
ORDER BY 1, 2, 3;


"""오답노트"""
-- MySQL : 안되던 것
SELECT sales_date, product_id, user_id, sales_amount
FROM ONLINE_SALE
WHERE EXTRACT(YEAR_MONTH FROM sales_date) = '202203'
UNION
SELECT sales_date, product_id, NULL user_id, sales_amount
FROM OFFLINE_SALE
WHERE EXTRACT(YEAR_MONTH FROM sales_date) = '202203'
ORDER BY 1, 2, 3;
