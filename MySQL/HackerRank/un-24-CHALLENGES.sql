"""
Prepare> SQL> Basic Join> Challenges
https://www.hackerrank.com/challenges/challenges/
Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
"""

/*- MySQL : 손코딩 해가면서... WITH 사용하지 않고(MSSQLServer를 제외한 MySQL, Oracle 모두 WITH를 사용하면 오류가 났음) 서브쿼리를 여러개 써가면서 진행했다. -*/
SELECT tb1.hacker_id, h1.name, tb1.counts
FROM
    (
    SELECT MAIN_h.hacker_id, COUNT(MAIN_c.challenge_id) counts
    FROM HACKERS MAIN_h JOIN CHALLENGES MAIN_c ON MAIN_h.hacker_id = MAIN_c.hacker_id
    GROUP BY MAIN_h.hacker_id
    ) TB1 JOIN HACKERS h1 ON tb1.hacker_id = h1.hacker_id
WHERE TB1.counts = 
            (
             SELECT MAX(TB2.counts) 
             FROM (SELECT COUNT(c1.challenge_id) counts FROM CHALLENGES c1 GROUP BY c1.hacker_id) TB2
            )
    OR TB1.counts IN
            (
             SELECT TB3.counts 
             FROM   (SELECT h2.hacker_id, COUNT(c2.challenge_id) counts
                    FROM HACKERS h2 JOIN CHALLENGES c2 ON h2.hacker_id = c2.hacker_id
                    GROUP BY h2.hacker_id) TB3
             GROUP BY TB3.counts 
             HAVING COUNT(TB3.counts) = 1
            )
ORDER BY 3 DESC, 1 ASC;


"""오답노트"""
/*- DISTINCT앞에 그에 맞는 다른 로우를 가져오려고 하면 오류가 난다. 
    MAX안에 COUNT를 쓰는 방법은 먹지 않아서 서브쿼리를 한 번 더 써줄 수 밖에 없었다.
    또한 IN을 사용하여 로우 한가지만 가져오도록 하는 것이 가능했고, 숫자 하나만 가져오도록 한 후 그것에 맞는 hacker_id를 가져와도 되는 것이었다. 
    내가 알기로 ORDER BY는 가장 나중에 되는데, 그렇다면 해당 숫자로 그룹바이 하고 hacker_id 정보는 사라지게 되는데,
        아무나 가져오게 되는게 아닌가? 어째서 나중에 정렬을 해도 정답인건지 아직 잘 이해가 가지 않는다. -*/

/*- MySQL: 카운트를 구한 후 맥스 카운트인 경우만 전부 출력하도록 CASE WHEN을 쓰려고 했으나 맥스카운트가 아닌 경우는 어떻게 한 명만 출력하지...?-*/
-- 카운트까지 구함
SELECT h1.hacker_id, COUNT(c1.challenge_id) counts
FROM HACKERS h1 JOIN CHALLENGES c1 ON h1.hacker_id = c1.hacker_id
GROUP BY h1.hacker_id
ORDER BY 2 desc
-- 일단 각각 카운트 나오도록 구함
SELECT *
FROM HACKERS h2 
JOIN CHALLENGES c2 ON h2.hacker_id = c2.hacker_id
JOIN
    (
    SELECT h1.hacker_id, COUNT(c1.challenge_id) counts
    FROM HACKERS h1 JOIN CHALLENGES c1 ON h1.hacker_id = c1.hacker_id
    GROUP BY h1.hacker_id
    ) tb1 ON h2.hacker_id = tb1.hacker_id;

/*- MySQL : group function이 잘못되었다고  -*/
SELECT h3.hacker_id, h3.name, TB1.counts 
FROM HACKERS h3 
    JOIN (
        SELECT h1.hacker_id, COUNT(c1.challenge_id) counts
        FROM HACKERS h1 JOIN CHALLENGES c1 ON h1.hacker_id = c1.hacker_id
        GROUP BY h1.hacker_id
         ) TB1 ON h3.hacker_id = TB1.hacker_id
WHERE TB1.counts = (SELECT MAX(COUNT(challenge_id)) FROM CHALLENGES GROUP BY hacker_id)
   OR TB1.counts = 
                    (SELECT COUNT(c2.challenge_id) counts
                     FROM HACKERS h2 JOIN CHALLENGES c2 ON h2.hacker_id = c2.hacker_id
                     GROUP BY h2.hacker_id
                     HAVING COUNT(COUNT(c2.challenge_id)) = 1);


/*- MySQL by.simple_guitar99 : 내가 하려던 방법과 가장 같아서 읽고 공부중, 이를 참고하여 완성할 수 있었다. -*/
/* count total submissions of challenges of each user */
WITH data
AS
(
SELECT c.hacker_id as id, h.name as name, count(c.hacker_id) as counter
FROM Hackers h
JOIN Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
)
/* select records from above */
SELECT id,name,counter
FROM data
WHERE
counter=(SELECT max(counter) FROM data) /*select user that has max count submission*/
OR
counter in (SELECT counter FROM data
GROUP BY counter
HAVING count(counter)=1 ) /*filter out the submission count which is unique*/
ORDER BY counter desc, id
