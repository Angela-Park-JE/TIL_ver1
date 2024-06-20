/*-
코딩테스트 연습> GROUP BY> 부서별 평균 연봉 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/284529
문제
  HR_DEPARTMENT와 HR_EMPLOYEES 테이블을 이용해 부서별 평균 연봉을 조회하려 합니다. 부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회하는 SQL문을 작성해주세요.
  평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL로 해주세요.
  결과는 부서별 평균 연봉을 기준으로 내림차순 정렬해주세요.
-*/

-- 240620: 평범하게 WHERE 조건으로 조회해서 조인하기. 집계를 서브쿼리로 만든다음 조인해도 되고 조인 붙인 것에서 집계해도 된다.
SELECT  e.dept_id
      , d.dept_name_en
      , ROUND(AVG(e.sal), 0) AS AVG_SAL
  FROM  HR_EMPLOYEES e, HR_DEPARTMENT d
 WHERE e.dept_id = d.dept_id
 GROUP  BY dept_id
 ORDER  BY 3 DESC;
