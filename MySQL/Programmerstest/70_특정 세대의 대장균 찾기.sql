/*-
코딩테스트 연습> SELECT> 특정 세대의 대장균 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/301650
  3세대의 대장균의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 이때 결과는 대장균의 ID 에 대해 오름차순 정렬해주세요.
-*/


-- 240705: 11분 정도 걸린 듯. 1세대가 부모인 2세대를 부모로 가진 id를 찾는다
SELECT  e3.id AS id
  FROM  ECOLI_DATA e3
 WHERE  e3.parent_id IN
        (
        SELECT  id
          FROM  ECOLI_DATA e2
         WHERE  e2.parent_id IN (SELECT e1.id FROM ECOLI_DATA e1 WHERE e1.parent_id IS NULL) -- 1세대 목록
        )  -- 2세대 목록
 ORDER  BY 1;
