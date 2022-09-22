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

/*- 시도4 MySQL : 내가 아는 지식 선에서 해결하려다 안되서, 각 테이블로 고유 번호를 부여하고 붙이는 방법을 생각했는데, pivoting관련해서 찾아보다 나와 똑같은 풀이를 생각한 사람이 있었다. -*/
-- reference : https://walkingfox.tistory.com/103
select  name
        , case when @grp = occupation then @rownum:=@rownum + 1 
               else @rownum :=1 end as rownum
        , (@grp := occupation) as dum
from OCCUPATIONS, (select @rownum:=0, @grp:='') r 
order by dum, name asc 


"""참고"""
/*- MySQL by.nobuh : 굳이 각 순서를 매긴 다음 순서 변수로 그룹화하여 불러오는 건 하고싶지 않아서 찾아보던 중 rank를 사용하는 좋은답.
    This query creates the ranking value, smaller values are in alphabetical order.
    Doctor and other occupations columns contain only a single value for each ranks, 
    so you can reduce null value by MAX or MIN aggregate function with group by rank value.-*/
-- MySQL
SELECT 
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
