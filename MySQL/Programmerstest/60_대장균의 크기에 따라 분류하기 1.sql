/*-
코딩테스트 연습> SELECT> 대장균의 크기에 따라 분류하기 1
https://school.programmers.co.kr/learn/courses/30/lessons/299307
  대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류합니다. 
  대장균 개체의 ID(ID) 와 분류(SIZE)를 출력하는 SQL 문을 작성해주세요.
  이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.
-*/


-- 240502: BETWEEN 은 문제를 푸는데 정답처리가 되기는 했지만 '이상'과 '이하'이기 때문에 엄밀히는 적합하지 않다.
SELECT  id
      , CASE WHEN size_of_colony <= 100 THEN 'LOW'
             WHEN size_of_colony > 100 AND size_of_colony <= 1000 THEN 'MEDIUM'
             ELSE 'HIGH'
                END AS size
  FROM  ECOLI_DATA
 ORDER  BY 1;
