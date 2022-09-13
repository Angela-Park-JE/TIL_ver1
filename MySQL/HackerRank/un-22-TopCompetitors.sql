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
70325 Bobby 
-*/


/*- MySQL : 다시 처음부터 작성했다. 되는 듯 하다가 또 다른데... -*/
SELECT h.hacker_id, h.name
FROM HACKERS h
    JOIN 
    (
    SELECT s.hacker_id, COUNT(s.submission_id) counts
    FROM DIFFICULTY d 
        JOIN CHALLENGES c ON d.difficulty_level = c.difficulty_level
        JOIN SUBMISSIONS s ON c.challenge_id = s.challenge_id
    WHERE d.score = s.score
    GROUP BY s.hacker_id
    ) tb1 ON h.hacker_id = tb1.hacker_id
WHERE counts > 1
ORDER BY tb1.counts DESC, h.name ASC

/*- 결과
27232 Phillip 
28614 Willie 
15719 Christina 
43892 Roy 
30128 Brandon 
14246 David 
26133 Jacqueline 
26253 John 
18330 Lawrence 
14372 Michelle 
35583 Norma 
45386 Christina 
49652 Christine 
17295 Elizabeth 
26895 Evelyn 
45785 Jesse 
32172 Jonathan 
19076 Matthew 
41293 Robin 
13944 Victor 
40226 Anna 
16259 Brandon 
49307 Brian 
28275 Debra 
14366 Donna 
14777 Gerald 
17762 Joseph 
37704 Keith 
36228 Nancy 
13391 Robin 
30721 Ann 
22196 Anthony 
28299 David 
32254 Dorothy 
19448 Jesse 
20504 John 
14363 Joyce 
46205 Joyce 
23678 Kimberly 
20534 Martha 
47641 Patricia 
12539 Paul 
14658 Stephanie 
42052 Andrew 
25732 Antonio 
38852 Benjamin 
44188 Diana 
30755 Emily 
28250 Evelyn 
13762 Gloria 
48984 Gregory 
13122 James 
18983 Lori 
18690 Marilyn 
21212 Timothy 
14863 Walter 
39277 Charles 
21463 Christine 
26243 Diana 
26289 Dorothy 
13380 Kelly 
24663 Louise 
13523 Ralph 
36322 Andrew 
32121 Dorothy 
40257 James 
41319 Jean 
25184 Martin 
23278 Paula 
39782 Tammy 
39771 Alan 
10857 Kevin 
34242 Marilyn 
25238 Paul 
49789 Lillian 
74413 Harry 
57947 Justin 
-*/
