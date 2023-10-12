"""
상품을 구매한 회원 비율 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131534
USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중, 상품을 구매한 회원수와 상품을 구매한 회원의 비율
(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 년, 월 별로 출력하는 SQL문을 작성해주세요. 
상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 온라인 세일 테이블이 조금 불친절하게 설명되어있었는데, 2021년 가입한 사람들 따로고 그 사람들이 가입후 바로 주문했을지도 모르는 2021년도의 모든 정보가 있는 것이 아니었다. 
    그래서 월별로 추가되는 가입자들을 구해서... 비율을 구할 필요가 없었다. 굉장히 러프한 지표를 원했던 것이고, 
    구매 기록을 2021에서 찾다가 왜 안되지 하고 잠시 멍타가 뚱땅뚱땅 다시 이해해서 금방 풀었다. level5 프로그래머스 sql에서는 가장 높은(?) 난이도였는데 의외로 바람이 빠진다.
    다른 더 좋은 풀이를 생각해봐야겠다. -*/
    
-- MySQL
-- 구매한 때가 2022가 아니라 2021년에 가입한 사람들 모두와, 그들의 구매내역을 보자 이거야
-- (SELECT COUNT(DISTINCT user_id) FROM USER_INFO u WHERE YEAR(u.joined) = 2021)로 구매자 목록 전체 수를 꾸려놔야함

SELECT YEAR(os.sales_date) year, MONTH(os.sales_date), 
        COUNT(DISTINCT u.user_id) puchased_users,
        ROUND( COUNT(DISTINCT u.user_id) / (SELECT COUNT(DISTINCT user_id) FROM USER_INFO u WHERE YEAR(u.joined) = 2021), 1) puchased_ratio
FROM ONLINE_SALE os LEFT JOIN USER_INFO u ON os.user_id = u.user_id AND YEAR(u.joined) = 2021
GROUP BY 1, 2; 



-- 복습
-- 231012:
-- 일단, 2021가입자목록과 ons를 WHERE절 조인을 했을 때랑, ons만 FROM절에 두고 WHERE에서 user_id IN 가입자목록으로 검색한 결과가 같다.
-- -- 같은것1: 전자
-- SELECT YEAR(sales_date), MONTH(sales_date), COUNT(*)
-- FROM ONLINE_SALE ons,
--     (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021) user2021
-- WHERE -- ons.user_id IN (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021)
--      ons.user_id = user2021.user_id
-- GROUP BY YEAR(sales_date), MONTH(sales_date)
-- -- 같은것2: 후자
-- SELECT YEAR(sales_date), MONTH(sales_date), COUNT(*)
-- FROM ONLINE_SALE ons
--     -- (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021) user2021
-- WHERE ons.user_id IN (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021)
--     -- ons.user_id = user2021.user_id
-- GROUP BY YEAR(sales_date), MONTH(sales_date)

-- 틀린 점을 정리하자면
-- DISTINCT 를 안했던 점 (COUNT() 사용하는 곳 모두 DISTINCT를 사용해야 한다.)
-- 그리고 두번째 자리에서 반올림이었던 점
SELECT YEAR(sales_date), MONTH(sales_date), 
       COUNT(DISTINCT ons.user_id), 
       ROUND(COUNT(DISTINCT ons.user_id)/((SELECT COUNT(user_id) FROM USER_INFO WHERE YEAR(joined) = 2021)), 1)
  FROM ONLINE_SALE ons,
       (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021) AS user2021
 WHERE ons.user_id = user2021.user_id
 GROUP BY YEAR(sales_date), MONTH(sales_date)
 ORDER BY 1, 2;

-- 이전에 짰던 쿼리가 훨씬 아름답다. 이전 쿼리에 맞춰 쓴다면 이렇게 된다. (사실 거기서 거기임)
SELECT YEAR(os.sales_date) year, MONTH(os.sales_date) month, 
       COUNT(DISTINCT u.user_id) puchased_users,
       ROUND( COUNT(DISTINCT u.user_id) / (SELECT COUNT(DISTINCT user_id) FROM USER_INFO u WHERE YEAR(u.joined) = 2021), 1) puchased_ratio
FROM ONLINE_SALE os, 
     (SELECT user_id FROM USER_INFO WHERE YEAR(joined) = 2021) u
WHERE os.user_id = u.user_id
GROUP BY 1, 2 
ORDER BY 1, 2;
