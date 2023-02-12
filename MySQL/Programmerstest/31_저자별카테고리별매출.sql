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
