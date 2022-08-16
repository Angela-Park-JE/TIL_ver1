"""
Prepare> SQL > Aggregation > Revising Aggregations - The Count Function
https://www.hackerrank.com/challenges/earnings-of-employees/
We define an employee's total earnings to be their monthly 'salary * months' worked, 
and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
Then print these values as '2' space-separated integers.
"""

--MYSQL 처음 정답
SELECT MAX(e.earnings), COUNT(e.employee_id)
FROM (  
        SELECT employee_id, (months*salary) AS earnings
        FROM EMPLOYEE
        ORDER BY earnings DESC) AS e
GROUP BY earnings
ORDER BY 1 DESC
LIMIT 1;

--MYSQL 다듬기 (그룹바이에는 항상 select 절에서 쓴 그대로 데려와야 한다는 것 잊지말기)
SELECT months*salary AS earnings, COUNT(employee_id)
FROM EMPLOYEE
GROUP BY earnings
ORDER BY 1 DESC
LIMIT 1;

--Oracle (FROM 절에 넣은 서브쿼리에 e 앞에 AS를 써줬었는데 그것 때문에 계속 오류가 남)
SELECT e.*
FROM   
    (SELECT months*salary, COUNT(employee_id)
    FROM EMPLOYEE
    GROUP BY months*salary
    ORDER BY 1 DESC) e
WHERE ROWNUM = 1;
