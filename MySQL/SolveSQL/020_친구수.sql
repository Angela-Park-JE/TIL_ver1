/*
전체 유저의 친구 수 집계하기
https://solvesql.com/problems/number-of-friends/
*/



/*오답노트*/
-- 250719: edges 만으로, 여기에 있는 모든 id들에 대해 추려야 한다. 그래서 UNION ALL을 했었던 것이고, 정답은 구할 수 없었다.
WITH unioned_table AS
    (
    SELECT  user_a_id
          , user_b_id
      FROM  edges

    UNION ALL

    SELECT  user_b_id
          , user_a_id
      FROM  edges

    ORDER  BY 1
    )

SELECT  user_a_id AS user_id
      , COUNT(DISTINCT user_b_id) AS num_friends
  FROM  unioned_table
 GROUP  BY  user_a_id
 ORDER  BY 2 DESC
;
-- users라는 테이블에 user가 전부 있을 거라는 생각을 했으나, 그런건 아니었다. 그도 그럴게 문제에서 edges 테이블만 설명하긴 했다. 
-- 이전 시도에서 id가 1 늘었다. users 테이블에 user가 전부 있었다면 레코드수가 맞지 않진 않았을 테고.
-- 이전에 UNION ALL 로 포함된 user를 전부 모아왔다고 생각했는데, 
WITH unioned_table AS
    (
    SELECT  user_a_id
          , user_b_id
      FROM  edges

    UNION ALL

    SELECT  user_b_id
          , user_a_id
      FROM  edges

    ORDER  BY 1
    )

SELECT  user_a_id AS user_id
      , COUNT(DISTINCT user_b_id) AS num_friends
  FROM  users uid 
        LEFT JOIN unioned_table ut 
        ON uid.user_id = ut.user_a_id
 GROUP  BY  user_a_id
 ORDER  BY 2 DESC
;
-- 바보!!! SELECT 절에 user_a_id를 적었으니 전체 user가 안나오지...
-- 일단 이것으로 전체 user는 출력하게 되었으나, 출력값이 다른 데이터포인트가 있다.
WITH unioned_table AS
    (
    SELECT  user_a_id
          , user_b_id
      FROM  edges

    UNION ALL

    SELECT  user_b_id
          , user_a_id
      FROM  edges

    ORDER  BY 1
    )

SELECT  user_id 
      , COUNT(DISTINCT user_b_id) AS num_friends
  FROM  users uid 
        LEFT JOIN unioned_table ut 
        ON uid.user_id = ut.user_a_id
 GROUP  BY 1
 ORDER  BY 2 DESC, 1
;
-- 
