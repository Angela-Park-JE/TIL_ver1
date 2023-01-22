"""
고양이와 개는 몇 마리 있을까
https://school.programmers.co.kr/learn/courses/30/lessons/59040

NAME	            TYPE	    NULLABLE
ANIMAL_ID	        VARCHAR(N)	FALSE
ANIMAL_TYPE	        VARCHAR(N)	FALSE
DATETIME	        DATETIME	FALSE
INTAKE_CONDITION	VARCHAR(N)	FALSE
NAME	            VARCHAR(N)	TRUE
SEX_UPON_INTAKE	    VARCHAR(N)	FALSE
동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
"""

/*- mine : 마이 컸다 REGEXP 도 쓸 줄 알고~ -*/

-- MySQL 
SELECT animal_type, COUNT(*)
FROM ANIMAL_INS
WHERE animal_type REGEXP 'Cat|Dog'
GROUP BY 1
ORDER BY 1;

-- 이것도 될 거고, = 대신 LIKE 를 써도 된다.
SELECT animal_type, COUNT(*)
FROM ANIMAL_INS
WHERE animal_type = 'Dog' OR animal_type = 'Cat'
GROUP BY 1
ORDER BY 1;



-- 이전에 풀었던 방식. 서브쿼리로 개와 고양이 row 만 뽑아두고 그 로우수로 바깥 쿼리에서 요약하는 방식이다.
-- 지금와서보니 신박해보인다.
SELECT animal_type, COUNT(animal_type) as 'count'
FROM (SELECT animal_type
      FROM ANIMAL_INS
      WHERE 1 = 1 
        AND (animal_type = 'Dog' or animal_type = 'Cat') ) as dt
GROUP BY animal_type
ORDER BY 1;
