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



-- 복습
-- 230824: "u.gender IS NOT NULL" 을 "u.gender != NULL" 해서 안됐다. NULL에 대해서는 IS NOT NULL을 쓰는 것 잊지 말기.
-- 또한 count에서 DISTINCT를 사용해야 한다. 구매건수가 아니라 회원수니까.
SELECT YEAR(os.sales_date), MONTH(os.sales_date), u.gender, COUNT(DISTINCT os.user_id)
  FROM USER_INFO u, ONLINE_SALE os
 WHERE u.user_id = os.user_id AND u.gender IS NOT NULL
 GROUP BY YEAR(os.sales_date), MONTH(os.sales_date), gender
 ORDER BY 1, 2, 3;

-- 231226: 똑같은 실수를 했다. user_id에 DISTINCT를 써야하는 점이다.
SELECT YEAR(ons.sales_date), MONTH(ons.sales_date), u.gender, count(DISTINCT u.user_id)
  FROM USER_INFO u RIGHT JOIN ONLINE_SALE ons ON u.user_id = ons.user_id
 WHERE u.gender IS NOT NULL
 GROUP BY YEAR(ons.sales_date), MONTH(ons.sales_date), u.gender
 ORDER BY 1, 2, 3;
