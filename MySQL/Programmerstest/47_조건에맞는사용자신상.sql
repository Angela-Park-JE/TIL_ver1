"""
조건에 맞는 사용자와 총 거래금액 조회하기 (? 164668 번 문제와 제목이 바뀌었다 심지어 테이블 소개할때 다른 테이블 이름 들어가있음...) 
https://school.programmers.co.kr/learn/courses/30/lessons/164670
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요. 
이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고, 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요. 
결과는 회원 ID를 기준으로 내림차순 정렬해주세요.
"""

-- 230315:
/*- mine : 왜 안돼지 했다가 마지막 번호에서 tlno, 7, 4 를 입력해두었었다. 1부터 세는거라 8번째 라고 써주어야 하는데 순간... ㅎㅎ -*/

-- MySQL
SELECT user_id, nickname, 
        CONCAT(city, ' ', street_address1, ' ', street_address2) 전체주소, 
        CONCAT(SUBSTRING(tlno, 1, 3), '-', SUBSTRING(tlno, 4, 4), '-', SUBSTRING(tlno, 8, 4)) 전화번호
  FROM USED_GOODS_USER
 WHERE 1=1
   AND user_id IN 
    (
        SELECT writer_id
          FROM USED_GOODS_BOARD
         GROUP BY 1
        HAVING COUNT(board_id) >= 3
    )  
 ORDER BY 1 DESC;



-- 230812: SUBSTRING 컨닝함. 여기는 서브쿼리로 만들어서 조인 시 조건을 건 것이고, 저기는 HAVING에 조건을 걸고 가진 쿼리의 결과 리스트에서 user를 가져오는 식으로 다르게 풀었다.
-- INNER 가 아니라 RIGHT은 틀린 답이다.
SELECT u.user_id, u.nickname, 
        CONCAT(u.city, ' ', u.street_address1, ' ', u.street_address2) AS 전체주소,
        CONCAT(SUBSTRING(tlno, 1, 3), '-', SUBSTRING(tlno, 4, 4), '-', SUBSTRING(tlno, 8, 4)) AS 전화번호
  FROM USED_GOODS_USER u INNER JOIN 
        (
        SELECT writer_id, COUNT(board_id) cnt
        FROM USED_GOODS_BOARD
        GROUP BY writer_id
        ) b 
        ON u.user_id = b.writer_id AND b.cnt>=3
ORDER BY 1 DESC;
