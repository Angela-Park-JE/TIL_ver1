"""
Prepare> SQL> Advanced Join> 15 Days of Learning SQL
https://www.hackerrank.com/challenges/15-days-of-learning-sql/
Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.
"""



"""오답노트"""

/*- 다시시도: 231230 -*/
SELECT tmp1.submission_date, tmp1.cnt, sum_amt
FROM    
        (
        SELECT s.submission_date, COUNT(DISTINCT hacker_id) cnt
        FROM Submissions s
        GROUP BY submission_date
        ) tmp1,
        (
        SELECT s.submission_date, hacker_id, -- COUNT(submission_id) subs,
            COUNT(submission_id) OVER (PARTITION BY hacker_id) sums
        FROM Submissions s
        GROUP BY submission_date, hacker_id
        ORDER BY 3 DESC, 2 ASC
        ) tmp2
WHERE 1=1
  AND tmp1.submission_date = tmp2.submission_date;



/*- 다시시도: 220921 -*/
SELECT TB1.day, TB1.idnumbers, 
    CASE WHEN (TB2.day = TB3.day AND TB2.maxsubs = TB3.subs)
        THEN (SELECT hacker_id FROM TB2, TB3 WHERE (TB2.day = TB3.day AND TB2.maxsubs = TB3.subs) ORDER BY hacker_id LIMIT 1) 
FROM 
    (
    SELECT tmptb1.day, COUNT(tmptb1.id) idnumbers
    FROM    
        (
            SELECT s1.submission_date day, s1.hacker_id id, COUNT(s1.submission_id) subs
            FROM SUBMISSIONS s1
            GROUP BY day, id
        ) tmptb1 
    GROUP BY day
    ) TB1, /* COUNT hackers */
    (
    SELECT tmptb2.day, MAX(tmptb2.subs) maxsubs
    FROM
        (
            SELECT s2.submission_date day, s2.hacker_id id, COUNT(s2.submission_id) subs
            FROM SUBMISSIONS s2
            GROUP BY day, id
        ) tmptb2
    GROUP BY day
    ) TB2, /* COUNT MAX */
    (
    SELECT s3.submission_date day, s3.hacker_id id, COUNT(s3.submission_id) subs
    FROM SUBMISSIONS s3
    GROUP BY day, id
    ) TB3, /* main table ; same as tmptb1, tmptb2 */
    HACKERS h
WHERE 1=1
    AND TB1.day = TB2.day
    AND TB2.maxsubs = TB3.subs
    AND TB3.id = h.hacker_id
;


/*- 처음에 -*/
--최대 점수나 해당 날짜 제출 인원은 가능한데, 해당 최당 점수의 사람을 데려오는게 문제였다. 
--시도(이 쿼리는 돌아가지만 날짜별로 모든 점수와 사람을 가져오게 된다)
SELECT a.submission_date, b.counts, a.hacker_id
FROM SUBMISSIONS a
INNER JOIN (
    SELECT submission_date, MAX(score) score, COUNT(submission_id) counts
    FROM SUBMISSIONS
    GROUP BY submission_date 
    ) b ON a.submission_date = b.submission_date AND a.score = b.score
ORDER BY 1;
