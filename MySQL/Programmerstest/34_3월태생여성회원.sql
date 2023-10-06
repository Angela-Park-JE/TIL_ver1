"""
3월에 태어난 여성 회원 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131120
MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요. 
이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.
"""

/*- mine : tlno IS NOT NULL 로 해야지, tlno != NULL 로는 검색이 되지 않았다. -*/

-- MySQL 
SELECT member_id, member_name, gender, DATE_FORMAT(date_of_birth, '%Y-%m-%d') date_of_birth
FROM MEMBER_PROFILE
WHERE MONTH(date_of_birth) = 3
  AND tlno IS NOT NULL 
  AND gender = 'W'
ORDER BY 1 ASC;



-- 복습
-- 231006:
SELECT member_id, member_name, gender, DATE_FORMAT(date_of_birth, '%Y-%m-%d') date_of_birth
  FROM MEMBER_PROFILE
 WHERE MONTH(date_of_birth) = 3 
   AND gender = 'W'
   AND tlno IS NOT NULL
 ORDER BY 1 ASC;
