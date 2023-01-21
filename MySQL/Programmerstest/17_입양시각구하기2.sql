"""
입양 시각 구하기(2)
https://school.programmers.co.kr/learn/courses/30/lessons/59413
ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. 
ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.

NAME	TYPE	NULLABLE
ANIMAL_ID	VARCHAR(N)	FALSE
ANIMAL_TYPE	VARCHAR(N)	FALSE
DATETIME	DATETIME	FALSE
NAME	VARCHAR(N)	TRUE
SEX_UPON_OUTCOME	VARCHAR(N)	FALSE

보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
"""


/*- mine : -*/


-- MySQL 작년의 내가 풀었던것
WITH RECURSIVE TEMP_TABLE AS 
    (SELECT 0 AS hour_number
     UNION ALL
     SELECT hour_number +1 
     FROM TEMP_TABLE
     WHERE hour_number < 23) -- 23시까지이기 때문에 22여야 +1 했을 때 23 까지 적힌다 
     
SELECT t.hour_number AS hour, COUNT(o.datetime) AS count
FROM TEMP_TABLE AS t
LEFT JOIN ANIMAL_OUTS AS o
      ON t.hour_number = HOUR(o.datetime)
GROUP BY hour;
