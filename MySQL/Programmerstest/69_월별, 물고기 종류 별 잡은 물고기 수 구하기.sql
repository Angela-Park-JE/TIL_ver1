/*-
코딩테스트 연습> GROUP BY> 월별 잡은 물고기 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/293260
  월별 잡은 물고기의 수와 월을 출력하는 SQL문을 작성해주세요.
  잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로 해주세요.
  결과는 월을 기준으로 오름차순 정렬해주세요.
  단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 잡은 물고기가 없는 월은 출력하지 않습니다.
-*/


-- 240704: GROUP BY 계층에 위배되지 않는다면 컬럼의 위치는 바뀌어도 괜찮다.
SELECT  COUNT(id) AS fish_count
      , MONTH(time) AS month
  FROM  FISH_INFO
 GROUP  BY MONTH(time)
HAVING  COUNT(id) != 0
 ORDER  BY 2;



/*-
코딩테스트 연습> GROUP BY> 물고기 종류 별 잡은 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/293257
  FISH_NAME_INFO에서 물고기의 종류 별 물고기의 이름과 잡은 수를 출력하는 SQL문을 작성해주세요.
  물고기의 이름 컬럼명은 FISH_NAME, 잡은 수 컬럼명은 FISH_COUNT로 해주세요.
  결과는 잡은 수 기준으로 내림차순 정렬해주세요.
-*/


-- 240704: FROM절에서든 WHERE 절에서든 조인을 시키는 방식이 있고, 아예 집계 후 붙이는 방식이 있고, SELECT절에 서브쿼리를 넣어서 조회시키는 방식이 있고 등등..
-- 저는 SELECT 절에 넣어 풀었습니다.
SELECT  COUNT(id) AS fish_count
      , (SELECT fish_name FROM FISH_NAME_INFO i2 WHERE i1.fish_type = i2.fish_type) AS fish_name
  FROM  FISH_INFO i1
 GROUP  BY fish_type
 ORDER  BY 1 DESC;
