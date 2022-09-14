"""
Prepare> SQL> Basic Join> Challenges
https://www.hackerrank.com/challenges/challenges/
Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
"""



"""오답노트"""
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
