"""
상품 별 오프라인 매출 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131533
PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요. 
결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 어렵지 않당! 이런건 쉽지! -*/

-- MySQL
SELECT p.product_code, p.price * SUM(os.sales_amount) SALES
FROM PRODUCT p, OFFLINE_SALE os
WHERE p.product_id = os.product_id
GROUP BY p.product_id
ORDER BY 2 DESC, 1 ASC;



-- 복습
-- 231007: off.sales_amount*SUM(p.price) 가 아니라 SUM(off.sales_amount)*p.price를 해야한다
-- 맞지. 그룹별 가격을 더하는게 아니라 수량을 더해놓고 price를 곱해야지...
SELECT p.product_code, SUM(off.sales_amount)*p.price sales
  FROM PRODUCT p RIGHT JOIN OFFLINE_SALE off ON p.product_id = off.product_id
 GROUP BY p.product_code
 ORDER BY sales DESC, product_code ASC;
