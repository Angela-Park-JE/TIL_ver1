-- 고양이와 개는 몇 마리 있을까 : 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 
-- https://school.programmers.co.kr/learn/courses/30/lessons/59040
-- 이때 고양이를 개보다 먼저 조회해주세요.
SELECT animal_type, COUNT(animal_type) as 'count'
FROM (SELECT animal_type
      FROM ANIMAL_INS
      WHERE 1 = 1 
        AND (animal_type = 'Dog' or animal_type = 'Cat') 
      ) as dt
GROUP BY animal_type
ORDER BY 1;

-- 231226: 다음 문제로 넘기면서 나왔길래 풀었던건데, 이전의 방식을 봐버려서, 적혀있지 않던 IN을 사용했다. 
-- 지금은 IN을 훨씬 더 많이 사용하는 것 같다. cat, dog인 데이터만 조회하는 방식을 세 가지로 적으면 다음과 같다.
SELECT animal_type, COUNT(*)
FROM ANIMAL_INS
WHERE animal_type REGEXP 'Cat|Dog'
GROUP BY 1 ORDER BY 1;

SELECT animal_type, COUNT(*)
FROM ANIMAL_INS
WHERE animal_type LIKE 'Dog' OR animal_type LIKE 'Cat'
GROUP BY 1 ORDER BY 1;

SELECT animal_type, COUNT(*)
FROM ANIMAL_INS
WHERE animal_type IN ('Dog', 'Cat') --today! : 해당 문자가 포함된 로우를 검색
GROUP BY 1 ORDER BY 1;



-- 동명 동물 수 찾기 : 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요.
-- https://school.programmers.co.kr/learn/courses/30/lessons/59041
-- 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT *
FROM (SELECT name, COUNT(name) as 'count' -- HAVING이 제대로 기억나지 않아서 인라인뷰를 썼다.
      FROM ANIMAL_INS
      WHERE name is not NULL
      GROUP BY name
      ) as dt
WHERE count >= 2                          -- count 라고 이름을 줬기 때문에 그대로 count써야한다. 따옴표 때문에 오류가 났었다.
ORDER BY 1;

-- SQL 아가였을 떄에는 서브쿼리로 구하고 바깥 테이블에서 셀 생각을 했지만, HAVING을 배운 시퀄으른은 이렇게 쓸 줄 알아야 하는 것이다.
SELECT name, COUNT(*) 
  FROM ANIMAL_INS
 WHERE name IS NOT NULL
 GROUP BY name
HAVING COUNT(*)>=2
 ORDER BY name;



-- 입양 시각 구하기(1) : 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
-- 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT hours as 'HOUR', count(hours)
FROM (SELECT HOUR(datetime) as hours
      FROM ANIMAL_OUTS
      WHERE 1 = 1
        AND HOUR(datetime) < 20
        AND HOUR(datetime) >= 9) as dt
GROUP BY HOUR
ORDER BY 1;

-- 더 나은 답: https://programmers.co.kr/questions/25934
SELECT HOUR(DATETIME) AS HOUR, COUNT(HOUR(DATETIME)) AS COUNT -- 함수를 바로 안에 넣어서 일을 줄인다
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) >= 9
AND HOUR(DATETIME) < 20 
GROUP BY HOUR(DATETIME) 
ORDER BY 1;



-- ** 오답 ** -- 주목!!!
-- 입양 시각 구하기(2) : 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
-- 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

-- 처음 생각한 것
-- 시퀀스를 생성하는 함수를 찾아서 그것과 조인을 하려고 했으나 아예 듣지를 않는다. 
CREATE SEQUENCE EX_SEQ -- 시퀀스이름 EX_SEQ
INCREMENT BY 1 -- 증감숫자 1
START WITH 0 -- 시작숫자 1
MINVALUE 0 -- 최소값 1
MAXVALUE 23 -- 최대값 1000
NOCYCLE -- 순한하지않음
CACHE -- 메모리에 시퀀스값 미리할당

SELECT *
FROM EX_SEQ;

SELECT HOUR(datetime) as 'HOUR', COUNT(HOUR(datetime)) as 'COUNT'
FROM ANIMAL_OUTS
GROUP BY HOUR
ORDER BY HOUR;

-- 다시 하다가 도저히 안돼서 찾아본 것 1: https://loy124.tistory.com/274
-- 프머스에서는 이렇게 짜지 말라고 자신의 답을 올려둔 분도 있다: https://programmers.co.kr/questions/27148
set @hour_count:=-1;
SELECT @hour_count:=@hour_count+1 as hour, IFNULL(
      (select count(DATETIME) 
      from ANIMAL_OUTS
      where @hour_count = HOUR(DATETIME)
      GROUP BY HOUR(DATETIME)), 0) as count
FROM ANIMAL_OUTS
where @hour_count < 23

-- 새로운 형식의 답을 보았다. 이분도 변수를 활용하셨다고 한다.: https://school.programmers.co.kr/questions/40987
SELECT HOUR, IFNULL(COUNT, 0) AS COUNT 
FROM
    (SELECT @K := @K + 1 AS HOUR FROM ANIMAL_OUTS, 
    (SELECT @K := -1 FROM ANIMAL_OUTS) DUM LIMIT 24) TT1
LEFT OUTER JOIN
    (SELECT HR, SUM(COUNT) AS COUNT
    FROM
    (SELECT HOUR(DATETIME) AS HR, 1 AS COUNT FROM ANIMAL_OUTS) T1
    GROUP BY HR
    ORDER BY HR ASC) TT2
ON TT1.HOUR = TT2.HR

-- 더 나은 답이 있는지 찾아본 것 2, 재귀쿼리를 사용하는 것이 적당하다는 생각이 든다. (이 해답을 많이 사용함): https://programmers.co.kr/questions/27290
WITH RECURSIVE TEMP AS (
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR+1 FROM TEMP
    WHERE HOUR<23
    )

SELECT HOUR, COUNT(ANIMAL_OUTS.DATETIME) AS COUNT 
FROM TEMP 
LEFT JOIN ANIMAL_OUTS
            ON TEMP.HOUR = HOUR(ANIMAL_OUTS.DATETIME)
GROUP BY HOUR;

-- 2번과 비슷하게 다른 답(재귀 테이블 사용): https://programmers.co.kr/questions/26199
WITH RECURSIVE ALL_HR AS(
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR + 1 FROM ALL_HR WHERE HOUR < 23
    )

SELECT HOUR, IFNULL(AO.COUNT, 0) AS COUNT
FROM ALL_HR
LEFT OUTER JOIN (
    SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT 
    FROM ANIMAL_OUTS
    GROUP BY HOUR
) AO
USING (HOUR);

-- 2번과 비슷한 답 간단한 쿼리: https://programmers.co.kr/questions/25328
with recursive time as
(select 0 as hour union all select hour + 1 from time where hour < 23)

select hour, count(animal_id) count
from time
left join animal_outs on (hour = date_format(datetime, '%H'))
group by hour;

-- 사람마다 쓰는 방식이 너무 달라서 보기가 어렵다

-- 내가 해보기
WITH RECURSIVE TEMP_TABLE AS 
    (SELECT 0 AS hour_number
     UNION ALL
     SELECT hour_number +1 
     FROM TEMP_TABLE
     WHERE hour_number < 23) -- 23시까지이기 때문에 22여야 +1 했을 때 23 까지 적힌다 
     
SELECT t.hour_number AS hour, COUNT(o.datetime) AS count
FROM TEMP_TABLE AS t
LEFT JOIN ANIMAL_OUTS AS o
      ON t.hour_number = HOUR(o.datetime)
GROUP BY hour;
