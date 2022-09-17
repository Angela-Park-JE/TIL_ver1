"""
Prepare> SQL> Basic Join> Contest Leaderboard
https://www.hackerrank.com/challenges/contest-leaderboard/problem
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of '0' from your result.
"""

/*- MySQL, Oracle : 그래도 오랜만에 쉽게 풀 수 있었던 문제. 그나저나 with가 왜 오류나지 -*/
SELECT h.hacker_id, h.name, TB2.total_score
FROM HACKERS h 
    JOIN (
        SELECT TB1.hacker_id, SUM(TB1.max_score) total_score
        FROM 
            (
            SELECT s.hacker_id, s.challenge_id, MAX(s.score) max_score
            FROM SUBMISSIONS s
            GROUP BY s.hacker_id, s.challenge_id
            ) TB1
        GROUP BY TB1.hacker_id
        ) TB2 ON h.hacker_id = TB2.hacker_id
WHERE TB2.total_score != 0
ORDER BY 3 DESC, 1 ASC; 


/*- MySQL by.m_alkhudairy : 조금 더 짧은 풀이가 있다. 내가 쓴 가장 바깥 쿼리를 생략한 -*/
SELECT hacker_id, name, sum(max) as score
FROM (SELECT h.hacker_id as hacker_id, h.name as name, max(s.score) as max
      FROM hackers h JOIN submissions s ON h.hacker_id = s.hacker_id
      GROUP BY h.hacker_id, h.name, s.challenge_id) as temp
GROUP BY hacker_id, name
HAVING sum(max) > 0
ORDER BY sum(max) desc, hacker_id asc;
