"""
Prepare> SQL> Basic Join> Top Competitors
https://www.hackerrank.com/challenges/full-score
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
"""

-- TABLE : HACKERS, DIFFICULTY, CHALLENGES, SUBMISSIONS

/*- MySQL : with가 왜 안될까.... step 1, 2;table join and find s.score=d.score -*/
WITH T1 AS 
(
    SELECT s.submission_id, s.challenge_id, c.hacker_id, c.difficulty_level, s.score, d.score 
    FROM SUBMISSIONS s, CHALLENGES c, DIFFICULTY d
    WHERE 1=1 
        AND s.challenge_id = c.challenge_id 
        AND c.difficulty_level = d.difficulty_level
        AND s.score = d.score
)

SELECT submission_id, hacker_id
FROM T1;
