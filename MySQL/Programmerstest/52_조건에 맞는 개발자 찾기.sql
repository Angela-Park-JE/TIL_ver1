"""
코딩테스트 연습> SELECT> 조건에 맞는 개발자 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/276034
문제
  DEVELOPERS 테이블에서 Python이나 C# 스킬을 가진 개발자의 정보를 조회하려 합니다. 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
  결과는 ID를 기준으로 오름차순 정렬해 주세요.
테이블
  CODE가 10진법으로 되어있는 2의 n승수이다
"""



"""오답노트"""
-- 240415: CONV(값, 원래진법, 바꿀진법)
-- skillcode를 2진법으로 바꾼것을 더해서 만들어 둔뒤 그것으로 검색
-- 이거는 정확히 파이썬과 C만 검색하며 자바 자바스크립트 씨쁠쁠은 검색하지 않게된다.
-- 해당 자리수만 검색하고 싶은데 어렵다
SELECT  id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS, 
        (
            SELECT  SUM(CONV(code, 10, 2)) AS bin
              FROM  SKILLCODES s 
             WHERE  name IN ('Python', 'C#')
        ) tmp
 WHERE  RIGHT(CONV(skill_code, 10, 2), LENGTH(tmp.bin)) = tmp.bin
 ORDER  BY 1;

-- 일단 파이썬 하나로는 검색이되는 상황
-- 만약 LENGTH안에 SELECT 절로 넣게되면 오류가된다
SELECT  id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS, 
        (
            SELECT  CONV(code, 10, 2) AS bin
              FROM  SKILLCODES s 
             WHERE  name IN ('Python') -- , 'C#')
        ) tmp
 WHERE  SUBSTR(RIGHT( CONV(skill_code, 10, 2), LENGTH(tmp.bin) ), 1, 1) = 1
 ORDER  BY 1;

-- 정규표현식 검색을 하기 위해 함수를 막 겹쳐쓴 상황이다. 안돌아간다.
SELECT  id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS, 
        (
            SELECT  CONCAT(REPLACE(SUM(CONV(code, 10, 2)), 0, '.'), '$') AS bin
              FROM  SKILLCODES s 
             WHERE  name IN ('Python', 'C#')
        ) tmp
 WHERE  CAST(CONV(skill_code, 10, 2), STR) LIKE tmp.bin -- 이부분이 문제인듯 하다
 ORDER  BY 1;

-- 안되는 부분을 고치고 CHAR 값을 지정해주니 돌아는 가지만 값을 찾을 수 없는 것으로 나타난다.
SELECT  id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS

 WHERE  CAST( CONV(skill_code, 10, 2) AS CHAR(200) ) 
        REGEXP         
        (
            SELECT  CONCAT(REPLACE(SUM(CONV(code, 10, 2)), 0, '.'), '$') AS bin
              FROM  SKILLCODES s 
             WHERE  name IN ('Python', 'C#')
        ) 
 ORDER  BY 1;
