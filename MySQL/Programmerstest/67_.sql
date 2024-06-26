/*- Binary with SQL -*/


/*- 오답노트 -*/
-- 240624: 처음에는 이진수라는 문제를 제대로 읽지 않고 썼다. 그럼 그렇지! 예시 데이터만 봤을 때도 아님을 느꼈는데!
SELECT e1.id 
  FROM ECOLI_DATA e1, ECOLI_DATA e2 
 WHERE 1=1
   AND e1.parent_id = e2.id 
   AND e1.genotype = e2.genotype;
