/*-
코딩테스트 연습> String, Date> 한 해에 잡은 물고기 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/298516
문제
  FISH_INFO 테이블에서 2021년도에 잡은 물고기 수를 출력하는 SQL 문을 작성해주세요.
  이 때 컬럼명은 'FISH_COUNT' 로 지정해주세요.
-*/

-- 240619: WHERE는 너무 쉬우니까 굳이굳이 다른 방법으로 풀기: YEAR로 GROUP BY 해서 HAVING 상용하기
SELECT  cnt AS FISH_COUNT
  FROM (
        SELECT  YEAR(time) AS years
              , COUNT(id) AS cnt  -- id는 NOT NULL
          FROM  FISH_INFO
         GROUP  BY YEAR(time)
       ) tmp
 WHERE  years = 2021
 ;


