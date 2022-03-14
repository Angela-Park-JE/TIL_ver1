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



