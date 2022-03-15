-- 이름이 없는 동물의 아이디 : 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT animal_id
FROM ANIMAL_INS
WHERE 1=1
  AND name is null
ORDER BY 1;



-- 이름이 있는 동물의 아이디 : 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT animal_id
FROM ANIMAL_INS
WHERE 1 = 1
  AND name is not NULL
ORDER BY 1; 



-- NULL 처리하기 : 입양 게시판에 동물 정보를 게시하려 합니다. 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 
-- 이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
SELECT ANIMAL_TYPE, IFNULL(NAME, 'No name'), SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

-- 사실 NVL, ISNULL 다 해서 안되고 생각해보니 MySQL이라 안되는 것이었고 IFNULL을 찾아했다. 
-- ORCLE SQL이었다면
SELECT ANIMAL_TYPE, NVL(NAME, 'No name'), SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;



--
