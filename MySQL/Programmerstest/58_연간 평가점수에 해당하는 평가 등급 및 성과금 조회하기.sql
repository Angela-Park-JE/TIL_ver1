"""
코딩테스트 연습> GROUP BY> 연간 평가점수에 해당하는 평가 등급 및 성과금 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/284528
  HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블을 이용해 사원별 성과금 정보를 조회하려합니다. 
  평가 점수별 등급과 등급에 따른 성과금 정보가 아래와 같을 때, 사번, 성명, 평가 등급, 성과금을 조회하는 SQL문을 작성해주세요.
  평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS로 해주세요.
  결과는 사번 기준으로 오름차순 정렬해주세요.
"""



-- 240430: 어려운 문제는 아니지만 길어진다. CASE WHEN을 더 간단하게 사용할 순 없을까 고민해봐도 결국 이 방법밖에 없는 것 같았다.
SELECT  e.emp_no
      , e.emp_name
      , CASE WHEN total_score >= 96 THEN 'S' 
             WHEN total_score >= 90 THEN 'A'
             WHEN total_score >= 80 THEN 'B'
             ELSE 'C' 
         END AS grade
      , CASE WHEN total_score >= 96 THEN e.sal * 0.2
             WHEN total_score >= 90 THEN e.sal * 0.15
             WHEN total_score >= 80 THEN e.sal * 0.1
             ELSE 0 
         END AS bonus
  FROM  HR_EMPLOYEES e
        LEFT JOIN  
                (
                    SELECT  emp_no
                          , SUM(score)/2 AS total_score
                      FROM  HR_GRADE
                     GROUP  BY 1
                ) tmp
                ON e.emp_no = tmp.emp_no
 ORDER  BY 1;
  
