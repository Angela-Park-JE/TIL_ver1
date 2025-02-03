/*
주소 정보로 각각 도 시군구로 나누고 카페 개수 출력하기
https://solvesql.com/problems/refine-cafe-address/
*/



/* 풀이과정 */
-- 먼저 시, 도 정보로 나누기에 문제 없는지 데이터 확인
SELECT  DISTINCT SUBSTRING_INDEX(address, ' ', 1 )
  FROM  cafes
;
