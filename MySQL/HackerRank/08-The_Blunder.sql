"""
https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=true
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's  key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.
"""

--처음 접근
SELECT ROUND(AVG(e.real_salary), 0), ROUND(AVG(e.salary), 0)
FROM (
    SELECT salary, 
        CASE
            WHEN salary < 10 THEN salary * 1000
            WHEN salary < 100 THEN salary * 100
            WHEN salary < 1000 THEN salary * 10
            WHEN salary > 100000 THEN salary / 10
            ELSE salary
        END as real_salary
    FROM EMPLOYEES
    WHERE 1000 < salary < 10^5
    ) as e

--다시 생각: 제약조건을 걸고 0으로 끝나지 않는 것들을 상대로 다시 계산해보자, 아니, 0을 전부 없애야했다.
--주어진 데이터는 broken data 가 아니라 Origin data인 것이었다.
SELECT ROUND(AVG(CONVERT(e.broken_salary, UNSIGNED)), 0), ROUND(AVG(e.salary), 0)
FROM (
    SELECT salary, REPLACE((CONVERT(salary, CHAR(6)), '0', '') AS broken_salary
    FROM EMPLOYEES
    WHERE 1000 < salary < 10^5
    ) as e;
--다시
SELECT CEIL( AVG(salary) - AVG(CAST(REPLACE(CAST(salary AS CHAR), '0', '')) AS UNSIGNED) )
FROM EMPLOYEES
WHERE 1000 < salary 
  AND salary < 100000;
--이게 된다
--숫자형을 문자형으로 바꿀 필요가 없었던 것이다.
SELECT CEIL( AVG(salary) - AVG(REPLACE(salary, '0', '')) )
FROM EMPLOYEES
WHERE 1000 < salary 
  AND salary < 100000;

--안돌아가서 답답해서 Oracle 로 시도
--올림을 맨 나중에 CEIL 함수를 이용함.
SELECT CEIL(AVG(salary) - AVG(TO_NUMBER(REPLACE(TO_CHAR(salary), '0', ''))))
FROM EMPLOYEES
WHERE 1000 < salary 
  AND salary < 100000;
