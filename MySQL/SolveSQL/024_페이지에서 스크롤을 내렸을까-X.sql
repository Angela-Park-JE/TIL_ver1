/*
https://solvesql.com/problems/session-scroll/
*/

-- 250911: 먼저 입문반 페이지를 봤는가?
-- user_pseudo_id+ga_session_id 를 합쳐서 보아야 한다
WITH viewornot_table
  AS
      (
        SELECT  user_pseudo_id
              , ga_session_id
              , CASE page_title WHEN "백문이불여일타 SQL 캠프 입문반" THEN 1 ELSE 0 END AS beginner_pv
              , CASE event_name WHEN "page_view" THEN 1 ELSE 0 END AS pv_yn
              , CASE event_name WHEN "scroll" THEN 1 ELSE 0 END AS scr_yn
          FROM  ga
      )
-- 이때 세션 별로, 페이지뷰를 본 상황의 경우 beginner_pv가 1 이상이고 pv_yn도 1 이상일 때 페이지뷰를 한 것으로 볼 수 있다.
-- 카운트 식으로 한다음, ( 토탈|토탈-입문반본|입문반본|입문반본-입문반스크롤 ) 이렇게 구성하면 될 듯 하다.
-- pv_no : 입문반 페이지를 안본 세션
SELECT  user_pseudo_id
      , ga_session_id
  FROM  viewornot_table
 GROUP  BY  1, 2 
HAVING  SUM(beginner_pv) < 1 
;


-- 입문반 페이지를 본 사람 중 스크롤을 안한 사람
