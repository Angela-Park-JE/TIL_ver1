"""
코딩테스트 연습> GROUP BY> 조건에 맞는 사원 정보 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/284527
  HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블에서 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회하려 합니다. 
  2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회하는 SQL문을 작성해주세요.
  2022년도의 평가 점수는 상,하반기 점수의 합을 의미하고, 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.
"""


-- 240426: 방법1. 서브쿼리에서 단 한 명만 조회하는 방식
SELECT  tmp.totalscore AS score
      , e.emp_no
      , e.emp_name
      , e.position
      , e.email
  FROM  
    (
        SELECT  emp_no
              , SUM(score) totalscore
          FROM  HR_GRADE
         GROUP  BY emp_no
         ORDER  BY 2 DESC
         LIMIT  1    -- 한 명이 아니라 순서대로 여러명을 뽑고 싶다면 이 부분을 고치면 된다.
    ) tmp
        LEFT JOIN HR_EMPLOYEES e ON tmp.emp_no = e.emp_no;

-- 방법2. GROUP BY 대신 윈도우함수를 써도 괜찮다.
SELECT  tmp.totalscore AS score
      , e.emp_no
      , e.emp_name
      , e.position
      , e.email
  FROM  
    (

        SELECT  DISTINCT emp_no
              , SUM(score) OVER (PARTITION BY emp_no) AS totalscore
          FROM  HR_GRADE
         ORDER  BY 2 DESC
         LIMIT  1
    ) tmp
        LEFT JOIN HR_EMPLOYEES e ON tmp.emp_no = e.emp_no;

-- 방법3. 윈도우함수를 쓰되 LIMIT 없이 RANK를 매겨 써보기
SELECT  totalscore AS score
      , e.emp_no
      , e.emp_name
      , e.position
      , e.email
  FROM  
    (
    SELECT  emp_no
          , totalscore
          , RANK() OVER (ORDER BY totalscore DESC) rnk -- 원하는 방식으로 등수를 매겨서 등수로 추후 활용 가능
      FROM  
        (
            SELECT  emp_no
                  , SUM(score) totalscore 
              FROM  HR_GRADE  
             GROUP  BY 1        -- 평가점수 테이블에서 중복되던 emp_no 해결됨
        ) tmp1
    ) tmp2
        LEFT JOIN HR_EMPLOYEES e
            ON tmp2.emp_no = e.emp_no
 WHERE  rnk = 1;                 -- 원하는 등수 자르기
