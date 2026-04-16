/*
초기 형성된 친구 관계 분석
https://solvesql.com/problems/friendship-between-early-users/
*/


-- 우선 users를 보니 feature_ids 컬럼에 친구 아이디가 콤마로 구분되어있음. 몇 명 있는지 다 다르고 계산이 까다로워지는 부분이다.
SELECT  *
  FROM  users

  LIMIT 100 ;
-- "친구 관계인 두 사용자 ID의 합이 상위 0.1%에 들어오는 모든 친구 관계"
-- 어차피 초기 관계를 찾는 것이니까 feature_ids에다가 user_id 를 각각 더한 다음, 
-- 더한 수들의 DISTINCT 값을 친 다음 상위 10%에 해당하는 수를 출력해둠.
-- 그 다음 해당 수 보다 작은 feature_id+user_id 만 추려서 user_a_id, user_b_id 를 가져옴
-- 라고 하는 순간 edges 라는 엄청나게 고마운 테이블이 있네요^^ 문제가 확 쉬워짐~ (풀은 다음 users 테이블로 결과를 내보기도 하고 싶음)
