-- 없어진 기록 찾기 : 천재지변으로 인해 일부 데이터가 유실되었습니다. 
-- 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT a.animal_id, a.name
FROM ANIMAL_OUTS a
LEFT JOIN ANIMAL_INS b
     ON a.animal_id = b.animal_id
WHERE b.animal_id is null         -- 위 결과로 조인은했지만 INS테이블에서는 NULL인 데이터 
ORDER BY 1;



-- 
