"""
그룹별 조건에 맞는 식당 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131124
MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 
회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 좀 헤멨다. 조건을 간단하게 이퀄로 잡을 수 있는게 아닌 결과를 낸 것으로 도출을 해내야 하기 때문이다. 
    다른 방법으로 서브쿼리를 3번 사용한 형태로도 만들어 보았다. -*/

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



""" 복습 """
-- 230825: 크게 어려울 것은 없었고, HAVING을 사용할 까 하다가 LIMIT으로 잘라낸듯한 쿼리.
SELECT m.member_name, r.review_text, DATE_FORMAT(r.review_date, '%Y-%m-%d')
  FROM REST_REVIEW r LEFT JOIN MEMBER_PROFILE m ON r.member_id = m.member_id
 WHERE r.member_id = 
                    (SELECT member_id
                       FROM REST_REVIEW
                      GROUP BY member_id
                      ORDER BY COUNT(review_id) DESC
                      LIMIT 1)
 ORDER BY 3 ASC, 2 ASC;

-- 231024: review 갯수를 찾는 데에서는 JOIN이 필요가 없다. 잠시 헤맸었음.
SELECT m.member_name, r.review_text, DATE_FORMAT(r.review_date, '%Y-%m-%d')
FROM REST_REVIEW r LEFT JOIN MEMBER_PROFILE m ON r.member_id = m.member_id 
WHERE m.member_id = 
        (
        SELECT m.member_id
        FROM REST_REVIEW r LEFT JOIN MEMBER_PROFILE m ON r.member_id = m.member_id
        GROUP BY m.member_id
        ORDER BY COUNT(review_id) DESC
        LIMIT 1
        )
ORDER BY r.review_date ASC, r.review_text ASC


"""다른 풀이"""

-- MySQL
-- https://school.programmers.co.kr/questions/43900
-- PARTITION을 쓰면 멋져보이는 경향이 있다. 아직 난 뉴비이다.
-- 첫번째 CTE에서는 member_name 별 리뷰 개수를 가져오고 두번째 CTE에서는 기존 CTE에다가 카운트의 맥스가 적힌 컬럼을 넣는다. 
-- 첫번째 CTE: 아이디|이름|리뷰|날짜|해당윈도우시작~끝개수카운트(count(1)의 1은 이름이나 리뷰아이디 등 무엇을 넣어도 같음) 
-- 두번째 CTE: 아이디|이름|리뷰|날짜|해당윈도우시작~끝개수카운트|MAX(해당윈도우시작~끝카운트)
-- 그리고 본 쿼리에서는 이름-리뷰-날짜 를 해당윈도우내카운트=해당윈도우내카운트맥스값으로 거른다.

with
temp_01 as
(select m.member_id, m.member_name, r.review_text,r.review_date
    , count(1) over (partition by member_name rows between unbounded preceding and unbounded following) as count
    from MEMBER_PROFILE m
    join REST_REVIEW r on m.member_id = r.member_id
    order by 2) 
, temp_02 as
(select *,
    max(count) over () as max
    from temp_01)
select MEMBER_NAME,REVIEW_TEXT, date_format(REVIEW_DATE,'%Y-%m-%d') as REVIEW_DATE
from temp_02 a
where a.count = a.max
order by 3,2;


"""
**헷갈렸던 부분**: 
dense_rank()로 1 순위를 가져오거나, LIMIT 1을 사용한 코드들이다.
어떻게 저렇게 해서 1등인 사람들을 모두 가져올 수 있는거지? 하는 생각을 했었는데, 문제가 잘못된 것이었다. 리뷰 개수 1위인 사람(3명임)들 중 한 명만 가져와도 되는 것이었다.
답변 공유하면서 LIMIT 1을 써서 모두 가져올 수 있었던 걸까요 하면서 질문을 했었는데, 문제(정확히는 채점이)잘못된 것이었음.
프로그래머스는 나쁜게... date format도 맞춰야하고 컬럼 이름도 맞춰야 하면서 왜 답이 다른데 이걸 맞다고 해줘요...?
나만 바보인 줄 알았어 LIMIT 사용법 한참 찾았네
아래 방법들이 그 방법들이다. 한 명만 출력하는데, 정답으로 인정된다. 
"""

-- MySQL
-- https://school.programmers.co.kr/questions/41442
-- 위 처럼 WINDOW 함수를 이용하였다. 그러나 스마트했던 부분이 카운트를 기준으로 DENSE_RANK(누적 랭크)로 카운트가 큰것 순으로 매겼다. 
-- 그러면 큰 순이니 rank = 1인 것만 골라 가져오면 되는 것이다! 개인적으로 가장 마음에 드는 풀이였다.
select member_name, review_text, date_format(review_date,"%Y-%m-%d") as review_date
from(
    SELECT MEMBER_ID, count(member_id), dense_rank() over(ORDER BY COUNT(MEMBER_ID) DESC) as ran
    FROM REST_REVIEW
    GROUP BY MEMBER_ID
    ORDER BY COUNT(MEMBER_ID) DESC
    ) A natural join member_profile join rest_review using (member_id)
where A.ran =1
order by review_date,review_text;



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
