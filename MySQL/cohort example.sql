/*- 프리온보딩1월챌린지-2강에서 (240104)
with로 각 퍼널별 id개수를 세 놓은 다음, 메인 쿼리에서 COUNTIF로 NULL이 아닌 것을 세는 방식으로 할 수 있다. 
월요일을 시작으로 주 별 퍼널분석을 한다고 생각해보자. -*/

 WITH prepage AS
      (
      SELECT DATE(DATE_TRUNC(time, WEEK(MONDAY))) AS week, ses_id
      FROM db2024.LOG_DATA
      WHERE event_name in ('recommend_v', 'cate_v', 'search_v', 'liked_v')
      ),
      productpage AS 
      (
      SELECT DATE(DATE_TRUNC(timestamp, WEEK(MONDAY))) AS week, ses_id
      FROM db2024.LOG_DATA
      WHERE event_name = 'product_view'
      ),
      cartpage AS
      (
      SELECT DATE(DATE_TRUNC(timestamp, WEEK(MONDAY))) AS week, ses_id
      FROM db2024.LOG_DATA
      WHERE event_name = 'into_cart'
      )

SELECT prepage.week,
      COUNT(*) AS prepage_cnt,
      COUNTIF(productpage.session_id IS NOT NULL) AS product_view_cnt,
      COUNTIF(cartpage.session_id IS NOT NULL) AS cart_cnt,
      ROUND(COUNTIF(listpage.session_id IS NOT NULL)/COUNT(*), 3) AS first_funnel, -- 각 이전 페이지에서 상품을 클릭해서 보기까지의 퍼널
      ROUND(COUNTIF(cartpage.session_id IS NOT NULL)/COUNTIF(listpage.session_id IS NOT NULL), 3) AS second_funnel, -- 상품에서 장바구니에 담기까지의 퍼널
      ROUND(COUNTIF(cartpage.session_id IS NOT NULL)/COUNT(*), 3) AS total_funnel -- 처음 각각의 페이지들에서 상품을 장바구니에 담기까지의 퍼널
  FROM prepage LEFT JOIN 
       productpage ON prepage.week = productpage.week AND prepage.ses_id = productpage.ses_id LEFT JOIN 
       cartpage ON productpage.week = cartpage.week AND productpage.ses_id = cartpage.ses_id 
 GROUP BY prepage.week
 ORDER BY 1;
