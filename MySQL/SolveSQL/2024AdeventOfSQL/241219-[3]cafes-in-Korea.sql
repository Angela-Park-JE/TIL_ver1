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
