"""
코딩테스트 연습> SELECT> 대장균의 크기에 따라 분류하기 2
https://school.programmers.co.kr/learn/courses/30/lessons/301649
문제
  대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다. 
  대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 
  (단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.)
"""

/* 방법1 : WINDOW 함수 중 RATIO_TO_REPORT 사용하여 직접적인 % 값 반환하여 넣기 */
-- 240616: 이 문제는 MySQL밖에 지원하지 않습니다^^
-- 정답인지 알길이 없지만 정답인 걸로 하자.
SELECT  id
      , CASE WHEN RATIO_TO_REPORT(size_of_colony) OVER (ORDER BY size_of_colony DESC) <=0.25 THEN 'CRITICAL'
             WHEN RATIO_TO_REPORT(size_of_colony) OVER (ORDER BY size_of_colony DESC) BETWEEN 0.26 AND 0.5 THEN 'HIGH'
             WHEN RATIO_TO_REPORT(size_of_colony) OVER (ORDER BY size_of_colony DESC) BETWEEN 0.51 AND 0.75 THEN 'MEDIUM'
             ELSE 'LOW' 
         END AS 'COLONY_NAME'
  FROM  ECOLI_DATA
 ORDER  BY 1;


/* 방법2 : 조회용도의 서브쿼리를 작성 */
-- 240616: 조회용도의 서브쿼리를 작성. WITH문을 써서 정리하기 좋아하시는 분들꼐 적합
WITH size_standard AS 
    (
    SELECT 0 AS minimum, 0.25 AS maximum, 'CRITICAL' AS name FROM DUAL
    UNION
    SELECT 0.25 AS minimum, 0.5 AS maximum, 'HIGH' AS name FROM DUAL
    UNION
    SELECT 0.5 AS minimum, 0.75 AS maximum, 'MEDIUM' AS name FROM DUAL
    UNION
    SELECT 0.75 AS minimum, 1 AS maximum, 'LOW' AS name FROM DUAL
    ),
     size_no AS
    (
    SELECT  id
          , ROW_NUMBER() OVER (ORDER BY size_of_colony DESC)
                        / (SELECT COUNT(id) FROM ECOLI_DATA) AS size_ratio
      FROM ECOLI_DATA
    )

SELECT id
      , (SELECT  ss.name
           FROM  size_standard ss
          WHERE  1=1
            AND  sn.size_ratio > ss.minimum
            AND  sn.size_ratio <= ss.maximum
        ) AS 'COLONY_NAME'
  FROM  size_no sn
 ORDER  BY 1;


/* 방법3 : CASE WHEN을 이용 - 가장 쉽게 만들 수 있음 */
-- 240616: ROW_NUMBER() 사용하기!
-- 서브쿼리를 만들지 않아도 되긴 하지만 반복적으로 쓰는 것이 싫어서 말이당...

SELECT id
      , CASE WHEN size_ratio <= 1/4 THEN 'CRITICAL'
             WHEN size_ratio > 1/4 AND size_ratio <= 1/2 THEN 'HIGH'
             WHEN size_ratio > 1/2 AND size_ratio <= 3/4 THEN 'MEDIUM'
             ELSE 'LOW'
         END AS 'COLONY_NAME'
   FROM (
         SELECT  id
      , ROW_NUMBER() OVER (ORDER BY size_of_colony DESC)
                        / (SELECT COUNT(id) FROM ECOLI_DATA) AS size_ratio
  FROM  ECOLI_DATA
         ) tmp
 ORDER  BY id;


/* 오답노트 */
-- 방법3에서 만약 CASE WHEN을 이렇게 쓴다면 문제가 생긴다. test case는 통과를 하는데, COUNT(id)가 100을 넘어가는 경우 소수점 세 번째 자리 수를 담아내지 못하게 된다.
-- 따라서 BETWEEN을 사용하여 0.25와 0.26 사이의 엄청난(?) 차이를 만들어내면 안되고 AND를 사용해야 한다. 나는 분수를 적었다.
      , CASE WHEN size_ratio <= 0.25 THEN 'CRITICAL'
             WHEN size_ratio BETWEEN 0.26 AND 0.50 THEN 'HIGH'
             WHEN size_ratio BETWEEN 0.51 AND 0.75 THEN 'MEDIUM'
             ELSE 'LOW'
         END AS 'COLONY_NAME'
