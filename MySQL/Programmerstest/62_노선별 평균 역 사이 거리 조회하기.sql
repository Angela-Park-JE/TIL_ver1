/*-
코딩테스트 연습> GROUP BY> 노선별 평균 역 사이 거리 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/284531
-*/


-- 240511: || 이걸로 안되던데 MySQL에서 ||는 불리언 부호라고한다. 그래서 1이 떴나보다. 
-- ORACEL은 || 가능, 그리고 CONCAT은 인자를 둘만 받기에 여러개 이을 경우 CONCAT을 다시 감싸주어야 하게 된다.
-- *** 테케는 되나 통과안되는 이유: 'km'붙이면서 문자열로 변했기 때문!
SELECT  route
      , CONCAT(ROUND(SUM(d_between_dist), 1), 'km') AS TOTAL_DISTANCE
      , CONCAT(ROUND(AVG(d_between_dist), 2), 'km') AS AVERAGE_DISTANCE
  FROM  SUBWAY_DISTANCE
 GROUP  BY route
 ORDER  BY ROUND(SUM(d_between_dist), 1) DESC;
-- MySQL과 ORACLE을 제외한 DB에서는 CONCAT과 ||의 수행결과가 같다.
 SELECT  route
      , TO_CHAR(ROUND(SUM(d_between_dist), 1)) || 'km' AS TOTAL_DISTANCE
      , TO_CHAR(ROUND(AVG(d_between_dist), 2)) || 'km' AS AVERAGE_DISTANCE
  FROM  SUBWAY_DISTANCE
 GROUP  BY route
 ORDER  BY ROUND(SUM(d_between_dist), 1) DESC;
