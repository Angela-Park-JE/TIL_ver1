"""
코딩테스트 연습> GROUP BY> 특정 조건을 만족하는 물고기별 수와 최대 길이 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/298519
문제
  FISH_INFO에서 평균 길이가 33cm 이상인 물고기들을 종류별로 분류하여 잡은 수, 최대 길이, 물고기의 종류를 출력하는 SQL문을 작성해주세요. 
  결과는 물고기 종류에 대해 오름차순으로 정렬해주시고, 10cm이하의 물고기들은 10cm로 취급하여 평균 길이를 구해주세요.
  컬럼명은 물고기의 종류 'FISH_TYPE', 잡은 수 'FISH_COUNT', 최대 길이 'MAX_LENGTH'로 해주세요.
"""



-- 오답노트 --


-- 240528: 테스트 케이스는 통과를 하는데... 안되는데 문제가 무엇인지 해결하지 못했다.
SELECT  COUNT(*) AS FISH_COUNT
      , MAX(length) AS MAX_LENGTH
      , fish_type
  FROM  FISH_INFO
 GROUP  BY fish_type
HAVING  AVG(IFNULL(length, 10))>=33
 ORDER  BY 1;
