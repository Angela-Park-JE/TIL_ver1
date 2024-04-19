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

-- 한 가지 코멘트를 더 하자면, 자식이 없다면 = 즉 parent_id를 기준으로 id의 개수를 셌을 경우 parent_id 가 NULL인 행들이 생긴다.
-- 이 부분이 자연스럽게 해결될 수 있는 left join을 사용하거나 방금 전의 케이스를 서브쿼리로 넣어 사용할 수 있다. 서브쿼리로 넣고 조인을 시킨다.
SELECT  e.id AS id
      , CASE WHEN cnt IS NULL THEN 0 ELSE cnt END AS CHILD_COUNT -- 부모가 없어서 cnt가 0인 e테이블의 모든 id 정보
  FROM  ECOLI_DATA e
        LEFT JOIN 
        (
    SELECT  parent_id, COUNT(id) AS cnt
      FROM  ECOLI_DATA
     GROUP  BY 1
        ) tmp 
               ON e.id = tmp.parent_id -- subquery's NULL will be deleted
  ORDER  BY 1;
