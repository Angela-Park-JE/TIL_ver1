"""
코딩테스트 연습> SELECT> 대장균의 크기에 따라 분류하기 2
https://school.programmers.co.kr/learn/courses/30/lessons/301649
문제
  대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다. 
  대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 
  (단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.)
"""

/* 방법1 : WINDOW 함수 중 RATIO_TO_REPORT 사용하여 직접적인 % 값 반환하여 넣기 */
SELECT  
  FROM  
 WHERE  
 GROUP  BY
 ORDER  BY;


/* 방법2 : 조회용도의 서브쿼리를 작성 */


/* 방법3 : CASE WHEN을 이용 - 가장 쉽게 만들 수 있음 */
