/*
초기 형성된 친구 관계 분석
https://solvesql.com/problems/friendship-between-early-users/
*/


-- 우선 users를 보니 feature_ids 컬럼에 친구 아이디가 콤마로 구분되어있음. 몇 명 있는지 다 다르고 계산이 까다로워지는 부분이다.
SELECT  *
  FROM  users

  LIMIT 100 ;
