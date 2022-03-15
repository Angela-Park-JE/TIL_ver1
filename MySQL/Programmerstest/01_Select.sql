-- 테이블 전체 데이터 조회하기
SELECT *
FROM ANIMAL_INS;



-- 역순 정렬하기
SELECT name, datetime
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID DESC;



-- 아픈 동물 찾기 : 아이디와 이름
SELECT animal_id, name
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = 'Sick';



-- 젊은 동물 찾기 : 아이디와 이름, 아이디 순으로 정렬
SELECT animal_id, name
FROM ANIMAL_INS
WHERE intake_condition != 'Aged'
ORDER BY 1;



-- 모든 동물 아이디와 이름, 아이디 순으로 정렬
SELECT animal_id, name
FROM ANIMAL_INS
ORDER BY 1;



-- 여러 기준으로 정렬하기
SELECT animal_id, name, datetime
FROM ANIMAL_INS
ORDER BY name, datetime desc;



-- ** 오답 ** --
-- 상위 n개 레코드 : 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요
SELECT name 
FROM ANIMAL_INS
ORDER BY datetime
LIMIT 1;



-- 최댓값 구하기 : 
SELECT MAX(datetime) as datetime
FROM ANIMAL_INS
GROUP BY datetime
LIMIT 1;
-- 더 나은 답
SELECT max(datetime) as '시간' from animal_ins;



--  

