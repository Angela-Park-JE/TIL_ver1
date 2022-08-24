"""
Prepare> SQL> Advanced Select> The PADS
https://www.hackerrank.com/challenges/the-pads/
Generate the following two result sets:
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
  There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. 
If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation.
"""

/*- MySQL : 예시 결과가 한번에 출력되어있길래 UNION ALL 썼다가 당했다. 두 결과를 따로 내놓아야 했다. -*/
SELECT CONCAT(o1.name, "(", LEFT(o1.occupation, 1), ")")
FROM OCCUPATIONS o1
ORDER BY 1;

SELECT CONCAT("There are a total of ", n, " ", LOWER(a), "s.")
FROM (
    SELECT occupation a, COUNT(occupation) n
    FROM OCCUPATIONS o3
    GROUP BY occupation
    ORDER BY 2, 1
    ) o2;

/*- Oracle : 둘 이상의 string을 `||`로 구분지어 붙여야 했고, 임의의 문자열은 큰 따옴표가 아닌 작은 따옴표로 써야 알아들었다.-*/
SELECT o1.name||'('||SUBSTR(o1.occupation, 0, 1)||')'
FROM OCCUPATIONS o1
ORDER BY 1;

SELECT 'There are a total of '||n||' '||LOWER(a)||'s.' AS result
FROM (
    SELECT occupation a, COUNT(occupation) n
    FROM OCCUPATIONS o3
    GROUP BY occupation
    ORDER BY 2, 1
    ) o2;
