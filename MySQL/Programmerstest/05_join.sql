-- 없어진 기록 찾기 : 천재지변으로 인해 일부 데이터가 유실되었습니다. 
-- 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT a.animal_id, a.name
FROM ANIMAL_OUTS a
LEFT JOIN ANIMAL_INS b
     ON a.animal_id = b.animal_id
WHERE b.animal_id is null         -- 위 결과로 조인은했지만 INS테이블에서는 NULL인 데이터 
ORDER BY 1;



-- 있었는데요 없었습니다 : 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 
-- 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
--> 사실 LEFT 안하고 FULL OUTER JOIN 이라고 썼다가 에러떠서 LEFT로 바꿔줬다.
SELECT o.animal_id, o.name
FROM ANIMAL_OUTS as o
LEFT OUTER JOIN ANIMAL_INS as i
           ON (o.animal_id = i.animal_id)
WHERE o.datetime < i.datetime             -- 입양일이 입소일보다 작은 경우 = 입양일이 더 빠른 경우
ORDER BY i.datetime;



-- 오랜 기간 보호한 동물(1) : 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 보호 시작일 순으로 조회해야 합니다.
SELECT i.name, i.datetime
FROM ANIMAL_INS AS i
LEFT OUTER JOIN ANIMAL_OUTS AS o
             ON i.animal_id = o.animal_id
WHERE 1 = 1
  AND o.datetime IS NULL
ORDER BY i.datetime
LIMIT 3; 

--> 다른 분들 질문에 답변 드리는 재미도 생긴 것 같다.
--> 찾아보다가 오라클로 굉장히 깔끔하게 쓰신 코드도 보았다. : https://programmers.co.kr/questions/26820
SELECT NAME,
       DATETIME
FROM ANIMAL_INS
WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_OUTS)
ORDER BY DATETIME
FETCH FIRST 3 ROWS ONLY;



-- 보호소에서 중성화한 동물 : 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 
-- 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
SELECT i.animal_id, i.animal_type, i.name
FROM ANIMAL_INS AS i
LEFT OUTER JOIN ANIMAL_OUTS AS o
             ON (i.animal_id = o.animal_id)
WHERE 1 = 1
  AND i.SEX_UPON_INTAKE not in ('Spayed Female', 'Spayed Female')
  AND i.SEX_UPON_INTAKE != o.SEX_UPON_OUTCOME
ORDER BY i.animal_id;



