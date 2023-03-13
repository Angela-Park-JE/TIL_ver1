"""
조건에 부합하는 중고거래 상태 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/164672
USED_GOODS_BOARD 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의 게시글 ID, 작성자 ID, 게시글 제목, 가격, 거래상태를 조회하는 SQL문을 작성해주세요. 
거래상태가 SALE 이면 판매중, RESERVED이면 예약중, DONE이면 거래완료 분류하여 출력해주시고, 결과는 게시글 ID를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 43번 문제랑 난이도가 바뀐게 아닐까 하는 생각... 들여쓰기를 SELECT 에 맞추는게 좋은 것 같긴 한데 매번 그러기가 조금 귀찮고 고민이다. -*/

-- MySQL
SELECT board_id, writer_id, title, price, 
        CASE status WHEN 'SALE' THEN '판매중'
                    WHEN 'RESERVED' THEN '예약중'
                    WHEN 'DONE' THEN '거래완료' END AS status
FROM USED_GOODS_BOARD 
WHERE created_date = '2022-10-05'
ORDER BY 1 DESC;
