"""
코딩테스트 연습> String, Date> 분기별 분화된 대장균의 개체 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/299308
  각 분기(QUARTER)별 분화된 대장균의 개체의 총 수(ECOLI_COUNT)를 출력하는 SQL 문을 작성해주세요. 
  이때 각 분기에는 'Q' 를 붙이고 분기에 대해 오름차순으로 정렬해주세요. 
  대장균 개체가 분화되지 않은 분기는 없습니다.
"""



-- 240501: 부끄럽게도 qua'r'ter의 r을 빼먹어서 안되고 잠시 헤맸다. 분명 맞는데..! 하면서...
-- CONCAT(EXTRACT(QUARTER FROM differentiation_date), 'Q') 도 됨
SELECT  CONCAT(QUARTER(differentiation_date), 'Q') AS quarter 
      , COUNT(id) AS ecoli_count
  FROM  ECOLI_DATA
 GROUP  BY 1
 ORDER  BY 1;
