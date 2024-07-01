/*- Binary with SQL 
코딩테스트 연습> SELECT> 부모의 형질을 모두 가지는 대장균 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/301647
문제
  부모의 형질을 모두 보유한 대장균의 ID(ID), 대장균의 형질(GENOTYPE), 부모 대장균의 형질(PARENT_GENOTYPE)을 출력하는 SQL 문을 작성해주세요. 
  이때 결과는 ID에 대해 오름차순 정렬해주세요.
-*/




/*- 오답노트 -*/
-- 240624: 처음에는 이진수라는 문제를 제대로 읽지 않고 썼다. 그럼 그렇지! 예시 데이터만 봤을 때도 아님을 느꼈는데!
SELECT e1.id 
  FROM ECOLI_DATA e1, ECOLI_DATA e2 
 WHERE 1=1
   AND e1.parent_id = e2.id 
   AND e1.genotype = e2.genotype;
