"""
년, 월, 성별 별 상품 구매 회원 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131532
USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 
결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.
"""

/*- mine : 다 맞았는데,  DISTINCT 를 빼먹었다. 회원수를 구하는 것은 맞으나 그룹이 sale 테이블 기준이기 때문에 한 사람이 달에 여러번 구매한 경우 중복은 제외해야 한다. 
  중복을 제외하지 않는다면 회원 수가 아니라 판매건수가 되겠지. -*/

-- MySQL
SELECT YEAR(o.sales_date) YEAR, MONTH(o.sales_date) MONTH, u.gender GENDER, COUNT(DISTINCT o.user_id) USERS
FROM ONLINE_SALE o, USER_INFO u 
WHERE o.user_id = u.user_id
  AND u.gender IS NOT NULL
GROUP BY YEAR(o.sales_date), MONTH(o.sales_date), u.gender
ORDER BY 1, 2, 3;
