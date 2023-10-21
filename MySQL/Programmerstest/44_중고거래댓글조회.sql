"""
조건에 부합하는 중고거래 댓글 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/164673
USED_GOODS_BOARD와 USED_GOODS_REPLY 테이블에서 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 
결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 날짜는 중고거래 게시글 기준으로 2022년 10월이 맞고, DATE_FORMAT을 빼먹으면 안되며, 
    로우 출력은 게시글 기준이 아니라 댓글이 기준이더라. 댓글이 없는 게시글들을 출력하는게 아니라 조회를 원하는 건 댓글인 것이다. 그래서 REPLY 테이블에 조인시키는 형태여야 했다. 
    기존 문제들을 비추어 봤을 때 레벨 1이 아니라 2정도 아닐까 조심스럽게 생각해본다. -*/

-- MySQL
SELECT b.title, b.board_id, r.reply_id, r.writer_id, r.contents, 
        DATE_FORMAT(r.created_date, '%Y-%m-%d') create_date
  FROM USED_GOODS_BOARD b RIGHT JOIN USED_GOODS_REPLY r ON b.board_id = r.board_id
 WHERE EXTRACT(YEAR_MONTH FROM b.created_date) = 202210 
 ORDER BY 6 ASC, 1 ASC;



"""복습"""
    
-- 230609: DATE FORMAT 까먹었고, ON에서 =로 잇는 걸 잊어버렸음 ㅋㅋㅋ
SELECT b.TITLE, b.BOARD_ID, r.REPLY_ID, r.WRITER_ID, r.CONTENTS, DATE_FORMAT(r.created_date, '%Y-%m-%d') create_date
FROM USED_GOODS_BOARD b JOIN USED_GOODS_REPLY r ON b.BOARD_ID = r.BOARD_ID
WHERE 1=1
  AND EXTRACT(YEAR_MONTH FROM b.CREATED_DATE) = 202210
ORDER BY 6 ASC, 1 ASC;

-- 231021: 아주 오래 걸리진 않았으나 일단 어려울 문제가 아니어서. RIGHT JOIN을 명시해서 썼다.
SELECT b.title, b.board_id, r.reply_id, r.writer_id, r.contents, 
    DATE_FORMAT(r.created_date, '%Y-%m-%d') created_date
  FROM USED_GOODS_BOARD b RIGHT JOIN USED_GOODS_REPLY r ON b.board_id = r.board_id
 WHERE EXTRACT(YEAR_MONTH FROM b.created_date) = 202210
 ORDER BY created_date ASC, title ASC;
