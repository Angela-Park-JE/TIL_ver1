/* category 필터가 있을 때, 제품 페이지를 들어간 사람 중 카테고리 필터를 사용했던 사람들의 비율이 얼마나 되는지 보자 */

-- 이건 내가 한 방식으로, WITH문 없이 서브쿼리로만 만든 같은 결과물이다. 보다시피 JOIN도 없다. 다만 서브쿼리안에 서브쿼리가 또 있다.
-- (1) tmp1라는 서브쿼리에는 각 session_id별로 CASE WHEN으로 필터를 사용했던 카테고리뷰는 1을, 아니면 0을 매긴다. (ratio계산이니 편하게 true에 1을 주었다.)
-- (2) 다음은 위에 조건에 맞는 session_id 중, product_view인 session_id에 1을, 아니면 0을 매긴다.
-- (위 부분이 아래 제시된 WITH 사용 쿼리의 LEFT JOIN과 같은 방식이 된다.)
-- (3) 그리고 COUNTIF(필터를 사용했던 session_id수), COUNTIF(-필터사용해서-제품 본 session_id수)를 조건 '=1' 로 걸러낸다. 
-- 물론 1로 적어뒀기 때문에 값이 1이냐는 조건으로 COUNTIF()를 해도 같은 결과를 얻을 수 있다.
/*f
SELECT
  COUNTIF(filteruse = 1),
  COUNTIF(filter_prodview = 1),
  ROUND(COUNTIF(filter_prodview = 1)/COUNTIF(filteruse = 1), 3)
*/
SELECT
  SUM(filteruse),
  SUM(filter_prodview),
  ROUND(SUM(filter_prodview)/SUM(filteruse), 3)    -- (3)
FROM 
  (
    SELECT session_id,
      CASE WHEN 
          (event_name = 'catelist_view'
          AND JSON_EXTRACT_SCALAR(event_property, '$.use_filter') = 'used')
          THEN 1 ELSE 0 END AS filteruse,    -- (1)
      CASE WHEN 
           (event_name = 'product_view'
           AND session_id IN 
                          (SELECT session_id 
                           FROM DB.LOG_DATA
                           WHERE (event_name = 'catelist_view'
          AND JSON_EXTRACT_SCALAR(event_property, '$.use_filter') = 'used')))
          THEN 1 ELSE 0 END AS filter_prodview    -- (2)
    FROM DB.LOG_DATA
  ) tmp
;



-- 이건 강사님이 제시했던 방식으로 WITH문을 사용하는 방식이다.
WITH
  category_usefilter AS 
  (
  SELECT session_id
    FROM DB.LOG_DATA
   WHERE 1=1
     AND event_name='catelist_view'
     AND JSON_EXTRACT_SCALAR(event_property,'$.use_filter')='used' 
  ),
  product_view AS 
  (
  SELECT session_id
    FROM DB.LOG_DATA
   WHERE event_name='product_view'
  )
    
SELECT
  COUNT(category_usefilter.session_id) AS catefilter_session_id,
  COUNTIF(product_view.session_id IS NOT NULL) AS product_view_session_id,
  ROUND(COUNTIF(product_view.session_id IS NOT NULL)/COUNT(category_usefilter.session_id), 3) AS filtered_view_ratio
  FROM category_usefilter LEFT JOIN product_view 
       ON category_usefilter.session_id = product_view.session_id;  -- 조건에 맞는 사람 중 product를 본 사람
