"""
조건에 부합하는 중고거래 상태 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/164672
USED_GOODS_BOARD 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의 게시글 ID, 작성자 ID, 게시글 제목, 가격, 거래상태를 조회하는 SQL문을 작성해주세요. 
거래상태가 SALE 이면 판매중, RESERVED이면 예약중, DONE이면 거래완료 분류하여 출력해주시고, 결과는 게시글 ID를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 44번 문제랑 난이도가 바뀐게 아닐까 하는 생각... 들여쓰기를 SELECT 에 맞추는게 좋은 것 같긴 한데 매번 그러기가 조금 귀찮고 고민이다. -*/

-- MySQL
SELECT board_id, writer_id, title, price, 
        CASE status WHEN 'SALE' THEN '판매중'
                    WHEN 'RESERVED' THEN '예약중'
                    WHEN 'DONE' THEN '거래완료' END AS status  -- END 뒤를 줄바꿔서 쓰는게 나을까 고민이다
  FROM USED_GOODS_BOARD 
 WHERE created_date = '2022-10-05'
 ORDER BY 1 DESC;



"""복습"""

-- 230824: 어려울 것 없다
SELECT board_id, writer_id, title, price, 
       CASE status 
           WHEN 'SALE' THEN '판매중' 
           WHEN 'RESERVED' THEN '예약중' 
           WHEN 'DONE' THEN '거래완료' 
       END AS '거래상태'
FROM USED_GOODS_BOARD
WHERE created_date = '2022-10-05'
ORDER BY 1 DESC;

-- 231021: 오라클 오랜만에 해보기
-- 1. TO_DATE로만 하고 있었는데 date 포맷으로 바꾸면 시분초 때문에 안된다는 걸 잊음
-- 2. 날짜 포맷은 기본적으로 'YYYY-MM-DD' 이렇게 표기하는 걸 잊음
SELECT board_id, writer_id, title, price, 
        CASE status WHEN 'SALE' THEN '판매중' 
                    WHEN 'RESERVED' THEN '예약중' 
                    WHEN 'DONE' THEN '거래완료' 
                    END AS 거래상태
  FROM USED_GOODS_BOARD
 WHERE TO_CHAR(created_date, 'YYYY-MM-DD') = '2022-10-05'
 ORDER BY 1 DESC;
