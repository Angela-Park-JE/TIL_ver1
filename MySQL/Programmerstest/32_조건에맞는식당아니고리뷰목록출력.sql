"""
그룹별 조건에 맞는 식당 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131124
MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 
회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 좀 헤멨다. 조건을 간단하게 이퀄로 잡을 수 있는게 아닌 결과를 낸 것으로 도출을 해내야 하기 때문이다. 
    다른 방법으로 서브쿼리를 3번 사용한 형태로도 만들어 보았다.-*/

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


-- MySQL
SELECT m.member_name, r.review_text, DATE_FORMAT(r.review_date, '%Y-%m-%d') review_date
FROM REST_REVIEW r LEFT JOIN MEMBER_PROFILE m ON r.member_id = m.member_id,
    (
    SELECT member_id
    FROM REST_REVIEW r 
    GROUP BY member_id
    HAVING COUNT(review_id) = 
        (SELECT MAX(cnt) 
         FROM (SELECT COUNT(*) cnt FROM REST_REVIEW GROUP BY member_id) tb1)
    ) tb2
WHERE tb2.member_id = m.member_id
ORDER BY 3 ASC, 2 ASC;



"""다른 풀이"""

-- MySQL
-- https://school.programmers.co.kr/questions/44144
SELECT 
    A.MEMBER_NAME, 
    B.REVIEW_TEXT, 
    DATE_FORMAT(B.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM 
    MEMBER_PROFILE A,
    REST_REVIEW B,
    (
    SELECT
        DISTINCT X.MEMBER_ID 
        ,COUNT(X.REVIEW_ID)
        OVER(PARTITION BY X.MEMBER_ID) AS CNT_RV    -- 이부분에서 GROUP BY 없이 멤버아이디별 리뷰 카운트를 했는데, 
    FROM 
        REST_REVIEW X
    ORDER BY CNT_RV DESC
    limit 1                                         -- LIMIT 으로 어떻게 여러 아이디를 출력한걸까 따로 떼서 실행해봐도 이해가 안됨
        ) C
WHERE 
    A.MEMBER_ID = B.MEMBER_ID
    AND
    B.MEMBER_ID = C.MEMBER_ID
ORDER BY 
    REVIEW_DATE ASC,
    REVIEW_TEXT ASC


-- MySQL
-- https://school.programmers.co.kr/questions/43590
-- 최다 리뷰어를 추출한 후 해당 리뷰어의 id를 기반으로 원래 테이블에 조인을 하는 방식 -> 이라고 쓰셨음. 위와 방식으로보임 근데 LIMIT 은 한 줄만 뽑게 되어있을 텐데... 왜지
SELECT toprev.MEMBER_NAME, c.REVIEW_TEXT, DATE_FORMAT(c.REVIEW_DATE,'%Y-%m-%d')
FROM (SELECT a.MEMBER_NAME, a.MEMBER_ID, COUNT(REVIEW_ID) as count
FROM MEMBER_PROFILE as a RIGHT JOIN REST_REVIEW as b
    on a.MEMBER_ID = b.MEMBER_ID
GROUP BY 2
ORDER BY 3 DESC
LIMIT 1) as toprev INNER JOIN REST_REVIEW as c on toprev.MEMBER_ID = c.MEMBER_ID
ORDER BY 3 ASC, 2 ASC


-- 
