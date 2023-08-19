"""
저자 별 카테고리 별 매출액 집계하기
https://school.programmers.co.kr/learn/courses/30/lessons/144856
2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 
저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
"""


/*- mine: 다 잘 꾸몄는데 SUM이 아니라 (s.sales*b.price) 만 해놓고 왜 안되지? 하고 있었다. 합계를 구해야 total인데 
    아무튼 기간은 EXTRACT 가 가장 간편한것 같다. -*/

-- MySQL
SELECT a.author_id, a.author_name, b.category, SUM(s.sales*b.price) total_sales
FROM BOOK_SALES s, BOOK b, AUTHOR a
WHERE s.book_id = b.book_id and b.author_id = a.author_id
  AND EXTRACT(YEAR_MONTH FROM s.sales_date) = 202201
GROUP BY a.author_id, b.category
ORDER BY 1 ASC, 3 DESC;



-- 복습
-- 230819: id기준 오름차순인데 이름 기준으로 보고 적어서 뭐가 틀린건지 잠시 헤맴
-- 복습에서 푼 것은 left join을 바로 이어가는 식으로 테이블 조인을 함, 그외에는 같음.
SELECT b.author_id, a.author_name, b.category, SUM(b.price*s.sales) AS TOTAL_SALES
  FROM BOOK_SALES s LEFT JOIN BOOK b ON s.book_id = b.book_id 
                    LEFT JOIN AUTHOR a ON b.author_id = a.author_id
 WHERE EXTRACT(YEAR_MONTH FROM s.sales_date) = 202201
 GROUP BY b.author_id, b.category
 ORDER BY 1 ASC, 3 DESC;
-- Oracle- 오랜만에 오라클 sql 쓰려니 헷갈렸다. 
-- 먼저 group by에는 select 절에 올라가는 것들을 다 명시해주어야 하는 점이 다르고,
-- EXTRACT를 사용하지만 YEAR_MONTH 는 안되기 때문에 따로 뜯어서 해주어야 한다.
SELECT a.author_id, a.author_name, b.category, SUM(s.sales*b.price) AS total_sales
FROM BOOK_SALES s, BOOK b, AUTHOR a
WHERE s.book_id = b.book_id and b.author_id = a.author_id
  -- AND EXTRACT(YEAR_MONTH FROM s.sales_date) = 202201
  AND EXTRACT(YEAR FROM s.sales_date) = 2022  
  AND EXTRACT(MONTH FROM s.sales_date) = 01
GROUP BY a.author_id, a.author_name, b.category
ORDER BY 1 ASC, 3 DESC;




"""
저자 별 카테고리 별 매출액 집계하기 (다른 문제임)
https://school.programmers.co.kr/learn/courses/30/lessons/144855
2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
"""

/*- mine: 이 문제가 먼저였다. 간단하다. 이번엔 JOIN을 FROM절에서 했다. -*/

-- MySQL
SELECT b.category, SUM(s.sales) total_sales
FROM BOOK b RIGHT JOIN BOOK_SALES s ON b.book_id = s.book_id
WHERE EXTRACT(YEAR_MONTH FROM s.sales_date) = 202201
GROUP BY 1 ORDER BY 1 ASC;
