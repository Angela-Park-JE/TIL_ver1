"""
코딩테스트 연습> SELECT> 대장균들의 자식의 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/299305
  대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력하는 SQL 문을 작성해주세요. 
  자식이 없다면 자식의 수는 0으로 출력해주세요. 
  이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.
"""



-- 240419: 어려울 것 없는 문제이긴 하나 테이블이 많아지면 (grandson을 구해야 한다던가..) 헷갈리기 쉬운 문제
SELECT  e1.id
      , COUNT(e2.id) AS child_count
  FROM  ECOLI_DATA e1 
        LEFT JOIN ECOLI_DATA e2 
               ON e1.id = e2.parent_id
 GROUP  BY e1.id
 ORDER  BY 1;
