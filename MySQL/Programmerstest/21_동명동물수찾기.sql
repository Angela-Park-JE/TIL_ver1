"""
동명 동물 수 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/59041
동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 
이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
"""



/*- mine : 예전엔 카운트 된 것을 서브쿼리로 써서 카운트가 2회 이상인 것을 골랐다면 지금은 HAIVNG을 사용하는 것이다. -*/

-- MySQL
SELECT NAME, COUNT(*) 'COUNT'
FROM ANIMAL_INS
WHERE name IS NOT NULL
GROUP BY name HAVING COUNT(*) >= 2
ORDER BY 1;



-- 이전에 내었던 답
SELECT *
FROM (SELECT name, COUNT(name) as 'count'
      FROM ANIMAL_INS
      WHERE name is not NULL
      GROUP BY name) as dt
WHERE count >= 2
ORDER BY 1;
