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


/*- mine : 그래도 이 정도 문제에 구글링을 안해도 되는 것 같아 기쁘다. -*/

-- MySQL
WITH RECURSIVE hour_sqc AS
    (SELECT 0 hours 
     UNION ALL
     SELECT hours + 1
     FROM hour_sqc
     WHERE hours < 23
    )

SELECT h.hours HOUR, COUNT(a.animal_id) COUNT
FROM hour_sqc h LEFT JOIN ANIMAL_OUTS a ON h.hours = HOUR(a.datetime)
GROUP BY h.hours
ORDER BY 1;


-- MySQL 작년의 내가 풀었던것 아마 구글링 열심히 하면서 풀었을 것이다.
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



"""오답노트"""

-- 그냥 WHERE 절에서 조인하게 되면 HOUR가 INNER JOIN 조건이 되면서, 입양이 일어나지 않은 시각은 아예 표시되지 않는다.
WITH RECURSIVE hour_sqc AS
    (SELECT 0 hours 
     UNION ALL
     SELECT hours + 1
     FROM hour_sqc
     WHERE hours < 23
    )

SELECT h.hours HOUR, COUNT(a.animal_id) COUNT
FROM ANIMAL_OUTS a, hour_sqc h
WHERE h.hours = HOUR(a.datetime)
GROUP BY h.hours
ORDER BY 1;
