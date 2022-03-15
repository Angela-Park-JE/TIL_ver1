-- 고양이와 개는 몇 마리 있을까 : 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 
-- 이때 고양이를 개보다 먼저 조회해주세요.
SELECT animal_type, COUNT(animal_type) as 'count'
FROM (SELECT animal_type
      FROM ANIMAL_INS
      WHERE 1 = 1 
        AND (animal_type = 'Dog' or animal_type = 'Cat') 
      ) as dt
GROUP BY animal_type
ORDER BY 1;

-- 더 나은 답: https://programmers.co.kr/questions/15825
SELECT animal_type, COUNT(animal_id) AS count FROM animal_ins
WHERE animal_type IN('Cat','Dog')
GROUP BY animal_type
ORDER BY animal_type ASC;



-- 동명 동물 수 찾기 : 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요.
-- 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT *
FROM (SELECT name, COUNT(name) as 'count' -- HAVING이 제대로 기억나지 않아서 인라인뷰를 썼다.
      FROM ANIMAL_INS
      WHERE name is not NULL
      GROUP BY name
      ) as dt
WHERE count >= 2                          -- count 라고 이름을 줬기 때문에 그대로 count써야한다. 따옴표 때문에 오류가 났었다.
ORDER BY 1;

-- 더 나은 답: https://programmers.co.kr/questions/25933
SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY NAME ASC;



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



-- ** 오답 ** --
-- 입양 시각 구하기(2) : 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
-- 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

-- 처음 생각한 것
-- 시퀀스를 생성하는 함수를 찾아서 그것과 조인을 하려고 했으나 DDL은 아예 듣지 않는다. 
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

-- 다시 찾아본 것
