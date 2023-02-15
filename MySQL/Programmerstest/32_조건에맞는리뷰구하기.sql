"""
그룹별 조건에 맞는 식당 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131124
"""


/*- mine : 좀 헤멨다. 조건을 간단하게 이퀄로 잡을 수 있는게 아닌 결과를 낸 것으로 도출을 해내야 하기 때문이다. 
    다른 방법을 찾아봐야 겠다. -*/

-- MySQL
WITH CTE AS
    (
    SELECT member_id, COUNT(DISTINCT review_id) cnt
    FROM REST_REVIEW 
    GROUP BY member_id ORDER BY 2 DESC
    ),
    CTE2 AS
    (
    SELECT m.member_id, m.member_name
    FROM CTE cte, MEMBER_PROFILE m, REST_REVIEW r
    WHERE m.member_id = cte.member_id AND m.member_id = r.member_id
    GROUP BY m.member_id
    HAVING COUNT(r.review_id) = (SELECT MAX(cnt) FROM CTE)
    )
SELECT c.member_name, r.review_text, DATE_FORMAT(r.review_date, '%Y-%m-%d') review_date
FROM cte2 c, REST_REVIEW r
WHERE c.member_id = r.member_id
ORDER BY 3 ASC, 2 ASC;
