"""
조건에 맞는 회원수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/131535
USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
"""

/*- mine : year가 2021이고 age가 between 20 and 29, 회원은 unique하니까 row를 바로 COUNT(*) 하여 구함. -*/

-- MySQL
SELECT COUNT(*) USERS 
FROM USER_INFO
WHERE 1=1
  AND YEAR(joined) = 2021
  AND age BETWEEN 20 AND 29;
