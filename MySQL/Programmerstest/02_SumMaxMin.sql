-- 최댓값 구하기 : 
SELECT MAX(datetime) as datetime
FROM ANIMAL_INS
GROUP BY datetime
LIMIT 1;

-- 더 나은 답: https://programmers.co.kr/questions/15593
SELECT max(datetime) as '시간' FROM animal_ins;



-- 최솟값 구하기 : 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT MIN(datetime) as '시간'
FROM ANIMAL_INS;



-- 동물 수 구하기 : 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT COUNT(animal_id) as 'count'
FROM ANIMAL_INS



-- 중복 제거하기 : 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 
-- 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
SELECT COUNT(name)
FROM (SELECT DISTINCT name as name
      FROM ANIMAL_INS
      WHERE 1 = 1
        AND name is not NULL) as df;

-- 서브쿼리를 하지 않은 다른 분의 답: https://programmers.co.kr/questions/24115
SELECT count(distinct(name)) as count
FROM animal_ins
WHERE name is not null

