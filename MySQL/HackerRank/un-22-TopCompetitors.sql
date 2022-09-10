"""
Prepare> SQL> Basic Join> Top Competitors
https://www.hackerrank.com/challenges/full-score
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
"""

-- TABLE : HACKERS, DIFFICULTY, CHALLENGES, SUBMISSIONS
-- 두 번이상 만점을 받은 챌린지가 있는 해커들의 아이디와 이름을 챌린지 횟수 내림차순, 이름 오름차순으로 정렬한다.

/*- MySQL : with를 아예 못쓰게 하는 것처럼 보인다... 쿼리 자체는 전혀 문제가 없는데 돌아가지 않는다. / step 1, 2;table join and find s.score=d.score -*/
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


/*- MySQL : 맞게 했다고 생각했는데 문제를 잘못이해한건가 싶을 정도이다.-*/
SELECT h.hacker_id, h.name
FROM HACKERS h,
    (
    SELECT hacker_id, COUNT(submission_id) counts
    FROM 
        (
            SELECT s.submission_id, s.challenge_id, c.hacker_id, c.difficulty_level, s.score
            FROM SUBMISSIONS s, CHALLENGES c, DIFFICULTY d
            WHERE 1=1 
                AND s.challenge_id = c.challenge_id 
                AND c.difficulty_level = d.difficulty_level
                AND s.score = d.score
        ) AS TBL1
    GROUP BY hacker_id
    ) AS TBL2
WHERE 1=1
    AND TBL2.hacker_id = h.hacker_id
    AND TBL2.counts > 1
ORDER BY TBL2.counts DESC, h.name ASC;

/*- 결과 
14863 Walter 
97708 Barbara 
48984 Gregory 
5720 Joe 
8285 Paula 
61647 Melissa 
10857 Kevin 
18983 Lori 
87768 Dennis 
46205 Joyce 
270 Angela 
90653 Charles 
59907 Alan 
5275 Pamela 
80659 Denise 
59853 Stephen 
65903 Steven 
39771 Alan 
49307 Brian 
70325 Bobby -*/
