"""
2021 Dev-Matching: 웹 백엔드 개발자(상반기) 기출
문제 설명
PLACES 테이블은 공간 임대 서비스에 등록된 공간의 정보를 담은 테이블입니다. 
PLACES 테이블의 구조는 다음과 같으며 ID, NAME, HOST_ID는 각각 공간의 아이디, 이름, 공간을 소유한 유저의 아이디를 나타냅니다. ID는 기본키입니다.
===
NAME	TYPE
ID	INT
NAME	VARCHAR
HOST_ID	INT
===
문제
이 서비스에서는 공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부릅니다. 
헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성해주세요.
"""

SELECT p.ID, p.NAME, g.HOST_ID
FROM PLACES as p
INNER JOIN 
    (SELECT HOST_ID, count(ID) as c 
     FROM PLACES GROUP BY HOST_ID 
     HAVING c >= 2) as g 
     ON p.HOST_ID = g.HOST_ID
ORDER BY p.ID

-- 등록한 공간의 정보가 2 이상인 유저만 걸러내도록 집계쿼리를 만들어서 INNER JOIN을 시켜 표시한다. 
