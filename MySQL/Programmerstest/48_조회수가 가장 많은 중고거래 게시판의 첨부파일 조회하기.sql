"""
조회수가 가장 많은 중고거래 게시판의 첨부파일 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/164671
USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL문을 작성해주세요. 
첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요. 
기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고, 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요. 
조회수가 가장 높은 게시물은 하나만 존재합니다.
"""


/*- mine : 아 마지막문제라 넌 체리야... 하면서 아끼다 아끼다 오늘 풀어버렸다. 이제 나는 무엇을 풀어야 하는가
    읽으면서 쿼리 써도 어렵지 않았을 만한 난이도였다. -*/

-- MySQL
SELECT CONCAT('/home/grep/src/', b.board_id, '/', f.file_id, f.file_name, f.file_ext) file_path
  FROM USED_GOODS_BOARD b INNER JOIN USED_GOODS_FILE f ON b.board_id = f.board_id
 WHERE b.views = (SELECT MAX(views) FROM USED_GOODS_BOARD)
 ORDER BY f.file_id DESC;

-- 230519: 복습 겸 또 풀어봤는데 'AS' file_path 로 as 쓴거 빼고는 토씨 하나 다른게 없어서 스스로 놀랐다...



"""내가 달았던 답변"""

-- https://school.programmers.co.kr/questions/45852
SELECT CONCAT('/home/grep/src/', X.BOARD_ID, '/', X.FILE_ID, X.FILE_NAME, X.FILE_EXT) AS FILE_PATH
FROM (
        SELECT * FROM USED_GOODS_FILE
        WHERE BOARD_ID = (
                            SELECT BOARD_ID FROM USED_GOODS_BOARD
                            ORDER BY VIEWS DESC
                            LIMIT 1
                            ) 
    ) X                         -- here!
ORDER BY X.FILE_ID DESC;        -- here!
