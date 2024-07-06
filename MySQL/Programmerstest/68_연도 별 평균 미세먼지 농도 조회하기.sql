/*- 
코딩테스트 연습> String, Date> 연도 별 평균 미세먼지 농도 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/284530
  AIR_POLLUTION 테이블에서 수원 지역의 연도 별 평균 미세먼지 오염도와 평균 초미세먼지 오염도를 조회하는 SQL문을 작성해주세요. 
  이때, 평균 미세먼지 오염도와 평균 초미세먼지 오염도의 컬럼명은 각각 PM10, PM2.5로 해 주시고, 값은 소수 셋째 자리에서 반올림해주세요.
  결과는 연도를 기준으로 오름차순 정렬해주세요.
-*/


-- 240701: 반성하는 척하며 2단계 풀기 ㅋㅋㅋㅋ 실무에 가까운 문제 여러개 풀고싶다.
SELECT  YEAR(ym) AS 'YEAR'
      , ROUND(AVG(pm_val1), 2) AS 'PM10'
      , ROUND(AVG(pm_val2), 2) AS 'PM2.5'
  FROM  AIR_POLLUTION
 WHERE  1=1
   AND  location2 = '수원'
 GROUP  BY YEAR(ym)
 ORDER  BY 1;
