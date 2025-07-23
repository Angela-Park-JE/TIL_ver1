/*
특정 페이지 본 세션과 아닌 세션 개수
https://solvesql.com/problems/session-pv/
*/


-- 250508: 그냥 무식하게 서브쿼리 만들어서 집계하고 묶어 계산한게 다이다.
-- 사용자-세션id묶어서 하나의 세션으로 보기 때문에 group by를 사용해서 내놓은 것을 COUNT로 각각의 총 세션 수를 집계한다.
-- 본거 아닌거 1, 0 나눠가면서 할 필요가 없었다. total이 아니라 안본뷰가 509가 나옴.
WITH  
total_table AS -- 전체 세션 수
  (
    SELECT  COUNT(*) AS total 
      FROM  
            (
              SELECT  user_pseudo_id, ga_session_id
                FROM  ga  
               GROUP  BY  1, 2
            ) total_views
  ),
beginner_table AS -- 입문반 페이지뷰 O
(
    SELECT  COUNT(*) AS pv_yes 
      FROM  
          (
            SELECT  user_pseudo_id, ga_session_id
              FROM  ga
             WHERE  1=1
               AND  page_title = '백문이불여일타 SQL 캠프 입문반'
               AND  event_name = 'page_view'
             GROUP  BY  1, 2
          ) beginer_views
  )
-- 계산
SELECT  total
      , total-pv_yes AS pv_no
      , pv_yes
  FROM  total_table, beginner_table
;



-- 250723: 또 다르게 푼 오늘. 저번보다 더 복잡하게 풀었다.
-- 미리 전체에서 원하는 조건 '해당페이지를 view했는지' 확인하여 1과 0을 매겨놓고
-- 본 데이터에 대해서 SUM을 매겨서 따로 저장해둔뒤 이게 0이 아니면 본 것으로 간주.
WITH  
  cond_table AS -- 우선적인 조건을 포함한 테이블. 특정 페이지에 대해 조회하고 싶으면 page title만 고치면 됨.
  (
    SELECT  user_pseudo_id
          , ga_session_id
          , CASE WHEN (event_name = 'page_view' AND page_title = '백문이불여일타 SQL 캠프 입문반') 
                THEN 1
                ELSE 0 
            END AS view_the_page
      FROM  ga
  ),
  viewed_table AS
  (
    SELECT  user_pseudo_id
          , ga_session_id
          , SUM(view_the_page) AS viewed_or_not 
      FROM  cond_table
     GROUP  BY user_pseudo_id, ga_session_id
  )

SELECT  COUNT(*) AS total
      , (SELECT  COUNT(*) FROM viewed_table WHERE viewed_or_not = 0) AS pv_no 
      , COUNT(*) - (SELECT  COUNT(*) FROM viewed_table WHERE viewed_or_not = 0) AS pv_yes 
  FROM  viewed_table
;



/*오답노트;풀이과*/
-- 250421: 먼저 page_title 고유값은 어떤 것들이 있는지 찍어보고 
SELECT  DISTINCT page_title
  FROM  ga
;

-- 입문반이라는 이름이 들어간 것들을 찾아본다
SELECT  DISTINCT page_title
  FROM  ga
 WHERE  page_title LIKE '%입문반%'
 ;

-- 입문반이 들어간 것은 한 가지였다. 따라서 다른 처리 없이 입문반으로만 검색해도 될 것이다.
-- 사용자별로 세는 것이 아닌 사용자-세션id 별로 개수를 센다. 따라서 user_pseudo_id와 ga_session_id를 묶어서 grouping하는 것이 좋아보인다.
SELECT  user_pseudo_id, ga_session_id
      , CASE WHEN page_title LIKE '%입문반%' THEN 1 ELSE 0 END AS beginnerpage_view
      , page_title
  FROM  ga
--  GROUP  BY user_pseudo_id, ga_session_id
LIMIT 200;

-- 그래서 만든 쿼리인데 
SELECT  user_pseudo_id, ga_session_id
      , COUNT(DISTINCT page_title LIKE '%입문반%') AS begin_views
      , COUNT(DISTINCT page_title NOT LIKE '%입문반%') AS not_begin_views
  FROM  ga
 GROUP  BY user_pseudo_id, ga_session_id

ORDER  BY 4, 3
LIMIT 300
;

-- 위와 아래 쿼리 뭔가 이상하다 했더니 전부 1837로 나옴. 그리고 total은 509라는 힌트를 보았다.
SELECT  SUM(begin_views+not_begin_views) AS total
      , SUM(not_begin_views) AS pv_no
      , SUM(begin_views) AS pv_yes
  FROM  (
      SELECT  user_pseudo_id, ga_session_id
            , COUNT(DISTINCT page_title LIKE '%입문반%') AS begin_views
            , COUNT(DISTINCT page_title NOT LIKE '%입문반%') AS not_begin_views
        FROM  ga
      GROUP  BY user_pseudo_id, ga_session_id
       ) session_cnt_table
;

-- 유저-세션-타이틀 카운트인데, 여러번 본 경우 즉 타이틀까지 같으나 여러개인 경우 전부 카운트한다. '유저-세션-타이틀' 별로 하나로 묶어야한다. 우리는 요약이 필요하다.
SELECT  user_pseudo_id, ga_session_id
      , page_title
      , COUNT(CASE WHEN page_title LIKE '%입문반%' THEN 1 END) OVER (PARTITION BY user_pseudo_id, ga_session_id)
  FROM  ga
 ORDER  BY 1, 2
LIMIT 100
;

-- > 서브쿼리 테이
-- 유저-세션-타이틀 별로 나눠서 cnt를 해야한다. group by를 쓰려고는 했으나 그게 어려웠던게 COUNT를 어떻게 하지,,, 였다.
-- 잠깐 헷갈렸던건 COUNT안에 조건문 쓰는 방법과, 
-- PARTITION BY [user_pseudo_id, ga_session_id] 까지만 하면 cnt에 "입문반을 본 유저-세션은 1"이 된다. 즉 입문반을 본 세션은 다른 페이지에 대해서도 1로 뜬다. 
SELECT  user_pseudo_id, ga_session_id
      , page_title
      , COUNT(CASE WHEN page_title LIKE '%입문반%' THEN 1 END) OVER (PARTITION BY user_pseudo_id, ga_session_id, page_title) AS cnt
  FROM  ga
 GROUP  BY 1, 2, 3 
 ORDER  BY 1, 2
;

-- 아니 근데 이게 아니다. total이 2193이 나온다...
SELECT  COUNT(*) AS total
      , COUNT(*)-SUM(cnt) AS pv_no
      , SUM(cnt) pv_yes
  FROM
          (
          SELECT  user_pseudo_id, ga_session_id
                , page_title
                , COUNT(CASE WHEN page_title LIKE '%입문반%' THEN 1 END) OVER (PARTITION BY user_pseudo_id, ga_session_id, page_title) AS cnt
            FROM  ga
           GROUP  BY 1, 2, 3 
          ) pv_table
;
