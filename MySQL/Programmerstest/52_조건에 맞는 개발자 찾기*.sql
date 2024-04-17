"""
코딩테스트 연습> SELECT> 조건에 맞는 개발자 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/276034
문제
  DEVELOPERS 테이블에서 Python이나 C# 스킬을 가진 개발자의 정보를 조회하려 합니다. 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
  결과는 ID를 기준으로 오름차순 정렬해 주세요.
테이블
  CODE가 10진법으로 되어있는 2의 n승수이다
"""

-- 240417: 이전에 하고 있던 것은 C#과 Python을 둘다 가진 사람만 찾는 코드였기 때문에 틀렸다.
-- 결국 해당 코드를 따고 검색을 하도록 적었다.
-- CAST를 사용하여 형변환을 하지 않아도 CONCAT이 가능했다.
SELECT  DISTINCT id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS
 WHERE  REPLACE(CONV(skill_code, 10, 2), 0, '.') 
        REGEXP  
            (SELECT CONCAT(REPLACE(CONV(code, 10, 2), 0, '.'), '$') FROM SKILLCODES WHERE name = 'Python' )
    OR  REPLACE(CONV(skill_code, 10, 2), 0, '.') 
        REGEXP  
            (SELECT CONCAT(REPLACE(CONV(code, 10, 2), 0, '.'), '$') FROM SKILLCODES WHERE name = 'C#' )
 ORDER  BY 1;


"""다른 해답"""
-- 비트 연산을 사용한 해당 문제 풀이 (https://velog.io/@sobit/비트-연산자bitwise-operator-프로그래머스-문제로-이해해-보자)
select ID, EMAIL, FIRST_NAME, LAST_NAME
from DEVELOPERS
where SKILL_CODE & (select sum(CODE) 
					from SKILLCODES 
					where NAME in('Python','C#')) -- SUM을 했는데 이게 검색이 된다. 
                                        -- 쉽게 말해 &는 비교한 자리에 1이면 1(TRUE 즐 WHERE검색을 통과함)을 반환, 아니면 0을 반환.
order by ID; 
-- 심지어 이 답의 WHERE절은 이것과 같다. OR 띄어쓰기 붙여쓰기 가능. (https://school.programmers.co.kr/questions/75315)
-- WHERE SKILL_CODE&(SELECT CODE FROM SKILLCODES WHERE NAME LIKE 'Py%') 
--    OR SKILL_CODE &(SELECT CODE FROM SKILLCODES WHERE NAME = 'C#')

-- 마찬가지로 조인조건으로 &를 이용하고 WHERE에서 언어를 제한하도록 하는 방식이다. 똑똑하신분! (https://school.programmers.co.kr/questions/74973)
select distinct id, email, firstname, lastname
from developers
join skillcodes on skillcodes.code & developers.skill_code=skillcodes.code
where skillcodes.name in ('C#','Python')
order by id

-- 이 답은 이해를 못했다. (https://school.programmers.co.kr/questions/74687)
SELECT 
    D.ID, 
    D.EMAIL, 
    D.FIRST_NAME, 
    D.LAST_NAME 
FROM 
    DEVELOPERS D
WHERE EXISTS (
    SELECT 1
    FROM SKILLCODES S
    WHERE (D.SKILL_CODE & S.CODE) != 0 
    AND (S.NAME = 'Python' OR S.NAME = 'C#')
)
ORDER BY D.ID;



"""오답노트"""
-- 240415: CONV(값, 원래진법, 바꿀진법)
-- skillcode를 2진법으로 바꾼것을 더해서 만들어 둔뒤 그것으로 검색
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

-- 240417: CAST 형을 지우고 시도해 본 형태. 근본적인 문제는 그대로였다.
SELECT  id
      , email
      , first_name
      , last_name
  FROM  DEVELOPERS

 WHERE  REPLACE(CONV(skill_code, 10, 2), 0, '.') 
        REGEXP         
        (
            SELECT  CONCAT(REPLACE(SUM(CONV(code, 10, 2)), 0, '.'), '$') AS bin
            --  SELECT  SUM(CONV(code, 10, 2))
              FROM  SKILLCODES s 
             WHERE  name IN ('Python', 'C#')
        ) 
 ORDER  BY 1;

/* --- 메모 ---
 SELECT  REPLACE(CONV(code, 10, 2), 0, '.') AS bin, code, name    -- 각 코드가 변환 및 대체가 잘 되는가?
   FROM  SKILLCODES
 
 SELECT  REPLACE(CONV(skill_code, 10, 2), 0, '.') AS bin, id, first_name    -- 그럼 WHERE절에 문제가 없는가?
   FROM  DEVELOPERS
  WHERE  REPLACE(CONV(skill_code, 10, 2), 0, '.') REGEXP ('1.1........$');    -- 여기서 이전 코드의 문제가 둘 다 가진사람을 찾고있는 것으로 알게됨
--- */
