"""
조건에 맞는 사용자와 총 거래금액 조회하기 (?)
https://school.programmers.co.kr/learn/courses/30/lessons/164670
문제
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요. 
이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고, 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요. 
결과는 회원 ID를 기준으로 내림차순 정렬해주세요.
"""



/*- mine : 왜 안될까요?-*/

-- MySQL
SELECT user_id, nickname, 
        CONCAT(city, ' ', street_address1, street_address2) 전체주소, 
        CONCAT(SUBSTRING(tlno, 1, 3), '-', SUBSTRING(tlno, 4, 4), '-', SUBSTRING(tlno, 7, 4)) 전화번호
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
    
