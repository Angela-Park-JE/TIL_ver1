"""
Prepare> SQL> Advanced Join> 15 Days of Learning SQL
https://www.hackerrank.com/challenges/15-days-of-learning-sql/
Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.
"""



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
