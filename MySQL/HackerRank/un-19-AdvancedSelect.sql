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
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.
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
