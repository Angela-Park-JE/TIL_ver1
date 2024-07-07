/*- Binary with SQL 
코딩테스트 연습> SELECT> 부모의 형질을 모두 가지는 대장균 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/301647
  부모의 형질을 모두 보유한 대장균의 ID(ID), 대장균의 형질(GENOTYPE), 부모 대장균의 형질(PARENT_GENOTYPE)을 출력하는 SQL 문을 작성해주세요. 
  이때 결과는 ID에 대해 오름차순 정렬해주세요.
-*/


-- 240707: 해당 자리에 1로 일치만 하면 되도록 문자열 비교방식
SELECT  e1.id AS id
      , e1.genotype AS genotype
      , e2.genotype AS parent_genotype
  FROM  ECOLI_DATA e1, ECOLI_DATA e2 -- e2가 부모 정보를 데려온다고 가정
 WHERE  1=1
   AND  e1.parent_id = e2.id
   AND  CAST(CONV(e1.genotype, 10, 2) AS CHAR) 
        LIKE CONCAT('%', REPLACE(CAST(CONV(e2.genotype, 10, 2) AS CHAR), '0', '_')) -- 0을 _로 바꾸어 대조
 ORDER  BY 1;



/*- 다른 풀이 -*/
-- 대부분의 풀이에서 이 연산을 사용했다. (child.parent_id = parent.id 로 조인한 뒤)
  WHERE child.GENOTYPE & parent.GENOTYPE = parent.GENOTYPE
-- 부모의 형질을 모두 가져야하기 때문에 비트연산했을 때 부모의 형질과 값이 동일해야합니다.(https://school.programmers.co.kr/questions/77179)
-- &은 비트 연산자로, 대응되는 비트가 모두 1인 경우 1인 것인데 그것과 = 은 어떻게 이어져서 나올 수 있는건지 잘 모르겠는 것이다. 


  
/*- 오답노트 -*/
-- 240624: 처음에는 이진수라는 문제를 제대로 읽지 않고 썼다. 그럼 그렇지! 예시 데이터만 봤을 때도 아님을 느꼈는데!
SELECT  e1.id 
  FROM  ECOLI_DATA e1, ECOLI_DATA e2 
 WHERE  1=1
   AND  e1.parent_id = e2.id 
   AND  e1.genotype & e2.genotype 
 ORDER  BY 1;


-- 240707: (위와 순서를 바꾸었다. 순서에 영향이 있지 않을까 한 부분이다. 왜냐하면 자릿수와 상관없이 오른쪽 부분이 있기만 하면 떴기 때문이다)
-- 부모의 genotype만을 가지고 자식에 & 으로 대조하면 자식이 자릿수를 더 가진것과는 별개로 비교할 수 있지 않을까? 했다.
-- 그러나 실패
SELECT  e1.id
  FROM  ECOLI_DATA e1, ECOLI_DATA e2
 WHERE  1=1
   AND  e1.parent_id = e2.id
   AND  e2.genotype & e1.genotype
 ORDER  BY 1;


-- 240707: 0을 채워 자릿수를 맞추고 비교를 했으나 
-- 이것도 완전히 일치하는지 아닌지가 아니라 부모 형질이 자식 형질에 포함되느냐의 문제를 묻고있거니와,
-- 완전히 일치하지 않음에도 한가지 자리만 일치해도 일치하는 것으로 끌고오고 있다(2,3,6,7,8).
SELECT  e1.id
      , CONV(e1.genotype, 10, 2)
      , e2.id
      , CONV(e2.genotype, 10, 2)
      , LPAD(CONV(e2.genotype, 10, 2), LENGTH(CONV(e1.genotype, 10, 2)), 0)
  FROM  ECOLI_DATA e1, ECOLI_DATA e2
 WHERE  1=1
   AND  e1.parent_id = e2.id
   AND  e1.genotype & e2.genotype
 ORDER  BY 1;


-- 240707: 이젠 이 (문자열로 바꾸는) 방법 뿐이야! 라고 했지만 치명적인 문제가 있다. 
-- 무조건 1, 2, 3식으로 형질을 스택으로 가져가는게 아니기 때문에 1, 3을 가진 부모에게 1, 2, 3을 가진 자녀도 결과에 떠야하나 뜨지 않는 문제가 발생한다. (2만뜸)
-- 그리고!!!! 중요한 점은 CHAR(CONV(e2.genotype, 10, 2) 이게 아무것도 반환하지 않게되어 결과적으로 '%'만 덩그러니 있거나 했음
-- 다음 오답노트에서 보듯, CAST를 활용하여 AS CHAR 해주어야함 : CAST(CONV(e2.genotype, 10, 2) AS CHAR)
SELECT  e1.id
      , CONV(e1.genotype, 10, 2)
      , e2.id
      , CONV(e2.genotype, 10, 2)
  FROM  ECOLI_DATA e1, ECOLI_DATA e2
 WHERE  1=1
   AND  e1.parent_id = e2.id
   AND  CHAR(CONV(e1.genotype, 10, 2)) LIKE CONCAT('%', CHAR(CONV(e2.genotype, 10, 2)))
 ORDER  BY 1;


-- 240707: 부모형질에서 0인 부분에는 _을 넣어서 비교하면 어떨까 했다. 결과는 성공이다. 
-- 그렇지만 텍스트로 변환하고 비교를 하기 때문에 성능상 좋은 풀이는 아니라는 생각이 든다.
SELECT  e1.id AS id
      , e1.genotype AS genotype
      -- , CONV(e1.genotype, 10, 2)
      -- , e2.id
      , e2.genotype AS parent_genotype
      -- , CONV(e2.genotype, 10, 2)
      -- , CAST(CONV(e2.genotype, 10, 2) AS CHAR)
  FROM  ECOLI_DATA e1, ECOLI_DATA e2
 WHERE  1=1
   AND  e1.parent_id = e2.id
   AND  CAST(CONV(e1.genotype, 10, 2) AS CHAR) LIKE CONCAT('%', REPLACE(CAST(CONV(e2.genotype, 10, 2) AS CHAR), '0', '_'))
 ORDER  BY 1;
-- 부모 형질을 list화시켜서 비교할 수는 없을까?계속 질문했던 부분인데 이건 실력부족으로 못하겠다.

