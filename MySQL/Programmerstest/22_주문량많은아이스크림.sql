"""
주문량이 많은 아이스크림들 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/133027

NAME	        TYPE	        NULLABLE
SHIPMENT_ID	    INT(N)	        FALSE
FLAVOR	        VARCHAR(N)	    FALSE
TOTAL_ORDER	    INT(N)      	FALSE

7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
"""


/*- mine : 처음에는 UNION으로 합쳐두고 서브쿼리로 쓴 다음 바깥에서 GROUP BY 된 것에 따라 출력하고 싶었는데 
    잘 안되고 이 방법으로 밖에... CTE를 쓰고 싶지 않았는데 말이다. -*/

-- MySQL
WITH CTE1 AS
    (
    SELECT * FROM FIRST_HALF 
    UNION ALL
    SELECT * FROM JULY
    ),
    CTE2 AS
    (
    SELECT flavor, SUM(total_order) total
    FROM CTE1
    GROUP BY flavor
    ORDER BY 2 DESC
    )

SELECT flavor
FROM CTE2
LIMIT 3;



-- 복습
-- 230820: FULL OUTER JOIN이 듣지 않아 UNION을 쓰기로. 
SELECT flavor
  FROM 
    (
        SELECT * FROM JULY UNION SELECT * FROM FIRST_HALF
    ) tmp
 GROUP BY flavor
 ORDER BY SUM(total_order) DESC
 LIMIT 3;





"""다른 풀이"""
-- MySQL : ORDER BY 에 SUM이 바로 써지는 구나... 했다.
-- https://school.programmers.co.kr/questions/42791
SELECT
    half.flavor as FLAVOR
FROM
    first_half as half, july
WHERE
    half.flavor = july.flavor
GROUP BY
    july.flavor
ORDER BY
    half.total_order + sum(july.total_order) desc
LIMIT
    3
