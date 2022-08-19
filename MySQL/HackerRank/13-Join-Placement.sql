"""
Prepare> SQL> Advanced Join> 15 Days of Learning SQL
https://www.hackerrank.com/challenges/15-days-of-learning-sql/
You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.
"""

/*- MySQL, Oracle : 나와 친구와 내 급여를 연결한 후, 친구 급여를 친구로 찾아서 연결, 조건을 얹어서 내 이름을 캐낸다. -*/
SELECT t1.name
FROM (
    SELECT s.name name, s.id my_id, f.friend_id, p.salary my_salary 
    FROM STUDENTS s, FRIENDS f, PACKAGES p
    WHERE s.id = p.id AND f.id = p.id 
    ) t1
LEFT JOIN (SELECT * FROM PACKAGES) t2 ON t1.friend_id = t2.id 
WHERE t2.salary > t1.my_salary
ORDER BY t2.salary;

/*- Oracle (by santanunandi01) : 매우깔끔... 배울만 하다.-*/
select s.name from students s
join friends f on s.id=f.id
join packages p1 on s.id=p1.id
join packages p2 on p2.id=f.friend_id
where p1.salary<p2.salary
order by p2.salary;
