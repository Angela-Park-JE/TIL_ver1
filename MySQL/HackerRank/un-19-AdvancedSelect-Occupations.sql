"""
Prepare> SQL> Advanced Select> Occupations
https://www.hackerrank.com/challenges/occupations/
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.
Explanation: 
The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation 
(in this case, the Professor and Actor columns) are filled with NULL values.
"""


/*- 시도1 Oracle: 컬럼별로 사람들을 데려오지만 NULL이 그대로, 각 사람들의 이름들이 각 컬럼별로 차례로 나온다. -*/
SELECT 
    CASE WHEN o1.occupation = 'Doctor'
         THEN o1.name
         END AS Doctor,
    CASE WHEN o1.occupation = 'Professor'
         THEN o1.name
         END AS Professor,
    CASE WHEN o1.occupation = 'Singer'
         THEN o1.name
         END AS Singer,
    CASE WHEN o1.occupation = 'Actor'
         THEN o1.name
         END AS Actor
FROM OCCUPATIONS o1
ORDER BY 1,2,3,4;

/*- 시도2 MySQL : 컬럼별로 조건을 WHERE에 넣었더니, 각 사람들의 이름이 합집합으로 모든 조합의 로우가 출력...된다. -*/
SELECT od.name, op.name, os.name, oa.name 
FROM OCCUPATIONS od, OCCUPATIONS op, OCCUPATIONS os, OCCUPATIONS oa
WHERE 1=1
    AND od.occupation = 'Doctor'
    AND op.occupation = 'Professor'
    AND os.occupation = 'Singer'
    AND oa.occupation = 'Actor';

/*- 시도3 MySQL : 이런식으로 주는 것도 듣지 않는다. -*/
SELECT 
    CASE WHEN occupation = 'Doctor'
         THEN name ELSE NULL END a,
    CASE WHEN occupation = 'Professor'
         THEN name ELSE NULL END b,
    CASE WHEN occupation = 'Singer'
         THEN name ELSE NULL END c,
    CASE WHEN occupation = 'Actor'
         THEN name ELSE NULL END d
FROM OCCUPATIONS
ORDER BY name ASC;

/*- 시도4 MySQL : 내가 아는 지식 선에서 해결하려다 안되서, 각 테이블로 고유 번호를 부여하고 붙이는 방법을 생각했는데, 
    pivoting관련해서 찾아보다 나와 똑같은 풀이를 생각한 사람이 있었다. 실제로 name, rownum, occupation 순으로 나온다.
    그 이후 조리방법을 못해서 더 진행을 하지 못했다.-*/
-- reference : https://walkingfox.tistory.com/103
select  name
        , case when @grp = occupation then @rownum:=@rownum + 1 
               else @rownum :=1 end as rownum
        , (@grp := occupation) as dum
from OCCUPATIONS, (select @rownum:=0, @grp:='') r 
order by dum, name asc 


"""참고"""

/*- Oracle by.GosiaB : 상당히 깔끔한 답. -*/
SELECT doctor, professor, singer, actor 
FROM 
    (SELECT * 
    FROM 
        (SELECT Name, 
                occupation, 
                (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) AS row_num 
         FROM occupations ORDER BY name asc) 
    pivot (min(name) for occupation IN ('Doctor' AS doctor,'Professor' AS professor,'Singer' AS singer,'Actor' AS actor)
    ) 
 ORDER BY row_num); 


/*- MySQL by.lionheart2007_eg : rownum 함수를 사용하는 답. Oracle에서는 돌아가지 않는다. -*/
SELECT 
    MIN(CASE WHEN OCCUPATION = 'DOCTOR'      THEN NAME ELSE NULL END) ,
    MIN(CASE WHEN OCCUPATION = 'PROFESSOR'   THEN NAME ELSE NULL END) ,
    MIN(CASE WHEN OCCUPATION = 'SINGER'      THEN NAME ELSE NULL END) ,
    MIN(CASE WHEN OCCUPATION = 'ACTOR'       THEN NAME ELSE NULL END)
FROM
    (SELECT OCCUPATION, NAME, ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) AS OCCUS
    FROM OCCUPATIONS) AS T
GROUP BY OCCUS;


/*- Oracle by.rashnil2 : rank 함수를 사용하는 답. MySQL에서는 돌아가지 않는다. -*/
SELECT min(Doctor), min(Professor), min(Singer), min(Actor)
FROM
(SELECT  RANK() OVER(PARTITION BY occupation ORDER BY name) rank,
    case OCCUPATION when 'Doctor' then NAME end AS Doctor,
    case OCCUPATION when 'Professor' then NAME end AS Professor,
    case OCCUPATION when 'Singer' then NAME end AS Singer,
    case OCCUPATION when 'Actor' then NAME end AS Actor
FROM occupations)
GROUP BY rank
ORDER BY rank;


/*- MySQL by.nobuh : 돌아가지 않는 답이다. 굳이 각 순서를 매긴 다음 순서 변수로 그룹화하여 불러오는 건 하고싶지 않아서 찾아보던 중 rank를 사용하는 답.
    This query creates the ranking value, smaller values are in alphabetical order.
    Doctor and other occupations columns contain only a single value for each ranks, 
    so you can reduce null value by MAX or MIN aggregate function with group by rank value.-*/
SELECT 
    rank,
    MIN(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
    MIN(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
    MIN(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
    MIN(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM (
  SELECT a.Occupation,
         a.Name,
         (SELECT COUNT(*) 
            FROM Occupations AS b
            WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
  FROM Occupations AS a
    ) AS c
GROUP BY c.rank;
