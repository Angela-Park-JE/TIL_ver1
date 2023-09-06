"""
조건에 맞는 도서와 저자 리스트 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/144854

BOOK 테이블은 각 도서의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	        Type	    Nullable	Description
BOOK_ID	            INTEGER	    FALSE	    도서 ID
CATEGORY	        VARCHAR(N)	FALSE	    카테고리 (경제, 인문, 소설, 생활, 기술)
AUTHOR_ID	        INTEGER	    FALSE	    저자 ID
PRICE	            INTEGER	    FALSE	    판매가 (원)
PUBLISHED_DATE	    DATE	    FALSE	    출판일

AUTHOR 테이블은 도서의 저자의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name     	Type	    Nullable	Description
AUTHOR_ID	        INTEGER	    FALSE	    저자 ID
AUTHOR_NAME     	VARCHAR(N)	FALSE	    저자명

'경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 출판일을 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 간단. date_format 도 잊지 않았다. -*/

-- MySQL
SELECT b.book_id, a.author_name, DATE_FORMAT(b.published_date, '%Y-%m-%d') published_date
FROM BOOK b, AUTHOR a
WHERE b.author_id = a.author_id
  AND b.category = '경제'
ORDER BY 3;



-- 복습
-- 230906: 데이터가 작아서 어떤 조인을 써도 문제가 없는 것으로 보였음... ㄷㄷ
SELECT book_id, author_name, DATE_FORMAT(published_date, '%Y-%m-%d')
FROM BOOK b JOIN AUTHOR a ON b.author_id = a.author_id
WHERE category = '경제'
ORDER BY published_date ASC;
