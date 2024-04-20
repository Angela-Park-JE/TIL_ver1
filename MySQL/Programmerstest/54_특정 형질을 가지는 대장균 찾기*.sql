"""
코딩테스트 연습> SELECT> 특정 형질을 가지는 대장균 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/301646
  2번 형질이 보유하지 않으면서 1번이나 3번 형질을 보유하고 있는 대장균 개체의 수(COUNT)를 출력하는 SQL 문을 작성해주세요. 
  1번과 3번 형질을 모두 보유하고 있는 경우도 1번이나 3번 형질을 보유하고 있는 경우에 포함합니다.
"""

  
-- 240421: 결국 참고를 했었던 것을 토대로 만든 쿼리
SELECT  COUNT(id) AS count
  FROM  ECOLI_DATA
 WHERE  (GENOTYPE & 1 OR GENOTYPE & 4) AND !(GENOTYPE & 2);



"""오답노트"""
-- 240420: 내가 풀던 답 - 오답이다
SELECT  COUNT(*) AS COUNT
  FROM  ECOLI_DATA
 WHERE  genotype &(SELECT SUM(genotype) FROM ECOLI_DATA WHERE genotype IN (1, 3))
        AND genotype &(SELECT SUM(genotype) FROM ECOLI_DATA WHERE genotype IN (2)); -- 이 부분이 해결이 잘 안되었다.

-- 명답: https://school.programmers.co.kr/questions/75338
SELECT COUNT(ID) AS COUNT
FROM ECOLI_DATA
WHERE (GENOTYPE & 5) AND !(GENOTYPE & 2)

-- 이렇게도 가능하다: https://school.programmers.co.kr/questions/75250
-- 작성하신 분은 서브쿼리 사용시 조건에 맞는 Id를 추출한 뒤 해당 행만 스캔하여 결과를 산출하기 때문에 전체 테이블 스캔 대비 향상된다고 한다.
SELECT  COUNT(*) AS "COUNT"
FROM    (
        SELECT  ID
        FROM    ECOLI_DATA 
        WHERE   (((GENOTYPE & 1) > 0 OR (GENOTYPE & 4) > 0) AND (GENOTYPE & 2) = 0)
        ) AS ED
