/*
Advent of SQL 2024> 전체 유저의 친구 수 집계하기
https://solvesql.com/problems/number-of-friends/
*/


-- 250729: 풀이 포함 적어둠
WITH 
  all_friends AS
  (
    SELECT  user_a_id, user_b_id
      FROM  edges
    UNION ALL
    SELECT  user_b_id, user_a_id
      FROM  edges
  )

-- 1. 바로 여기서 WHERE로 사람을 검색하면, 해당 사람에 연결된 모든 친구를 불러올 수 있다.
-- SELECT  * 
--   FROM  edges e
--         JOIN all_friends af ON e.user_a_id = af.user_a_id;

-- 2. 그럼 GROUP BY로 사람별 친구 COUNT를 해본다. 
-- SELECT  user_a_id AS user_id
--       , COUNT(DISTINCT user_b_id) AS num_friends
--   FROM  edges e
--  GROUP  BY user_a_id
--  ORDER  BY  2 DESC, 1;
-- 그러나 레코드 개수가 다르다. 두 id 컬럼에 다 있는게 아니라는 말 즉,
-- "데이터베이스에 포함된 모든 사용자에 대해" 라는 문제의 말이 다른 테이블도 참조하라는 말.

-- 3. users 테이블을 포함시킨다. FULL OUTER JOIN 을 해야하는 상황
-- CTE를 확장한다. user_id만을 갖고있는 users 테이블을 만든 후 
-- 메인쿼리에서는 해당 id 목록을 기준으로 데이터를 붙이도록 한다.
  , all_users AS 
  (
    SELECT  user_a_id
      FROM  all_friends a1 
            LEFT JOIN users u1 
            ON a1.user_a_id = u1.user_id
    UNION                                           -- 중복 제거
    SELECT  user_id 
      FROM  users u2
            LEFT JOIN all_friends a2 
            ON a2.user_a_id = u2.user_id
  )

-- 메인쿼리에서 친구 정보만 가져옴. 없는건 NULL이 될 것.
SELECT  u.user_a_id AS user_id
      , COUNT(DISTINCT user_b_id) AS num_friends
  FROM  all_users u 
        LEFT JOIN all_friends a 
        ON u.user_a_id = a.user_a_id
 GROUP  BY u.user_a_id
 ORDER  BY  2 DESC, 1
;



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
