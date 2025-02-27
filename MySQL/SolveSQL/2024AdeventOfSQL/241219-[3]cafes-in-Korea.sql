/*
주소 정보로 각각 도 시군구로 나누고 카페 개수 출력하기
https://solvesql.com/problems/refine-cafe-address/
*/


-- 250223: SUBSTRING도 음수로 인덱싱 해올 수 있다. 
-- 다만 특정 위치"를" 가져온다기보다 특정 위치"까지" 가져온다의 의미이기에 겹으로 써주어야 하는 경우가 많을듯.
SELECT  SUBSTRING_INDEX(SUBSTRING_INDEX(address, ' ', 2), ' ', 1) AS sido
      , SUBSTRING_INDEX(SUBSTRING_INDEX(address, ' ', 2), ' ', -1) AS sigungu
      , COUNT(*) AS cnt
  FROM  cafes
 GROUP  BY 1, 2
 ORDER  BY 3 DESC
;



/* 풀이과정 */
-- 먼저 시, 도 정보로 나누기에 문제 없는지 데이터 확인
SELECT  DISTINCT SUBSTRING_INDEX(address, ' ', 1 )
  FROM  cafes
;
-- 다음은 SUBSTRING_INDEX로 자르되, 필요한 부분은 앞의 두 부분이므로 그 부분까지 잘라온 상태로 사용한다.
-- 그리고 사용된 두 sido와 sigungu로 GROUP BY하면 끝! 왜 3단계일까...?!
