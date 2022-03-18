
-- 루시와 엘라 찾기 : 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 
-- 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요. 

SELECT animal_id, name, sex_upon_intake
FROM ANIMAL_INS
WHERE 1 = 1
  AND name IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
ORDER BY animal_id;



-- 이름에 el이 들어가는 동물 찾기 : 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.

SELECT animal_id, name
FROM ANIMAL_INS
WHERE 1 = 1
  AND INSTR(UPPER(name), 'EL') != 0
  AND animal_type = 'Dog'
ORDER BY name;

-- 더 깔끔한 쿼리(MySQL): https://programmers.co.kr/questions/27187
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE NAME like '%eL%' and ANIMAL_TYPE = 'DoG'
ORDER BY 2;



-- 중성화 여부 파악하기 : 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 
-- 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요. 

SELECT animal_id, name, 
        CASE WHEN sex_upon_intake like '%Neutered%' THEN 'O'
             WHEN sex_upon_intake like '%Spayed%' THEN 'O' 
             ELSE 'X' 
             END AS 중성화
FROM ANIMAL_INS
ORDER BY animal_id;

