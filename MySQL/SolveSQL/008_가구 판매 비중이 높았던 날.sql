/*
가구 판매 비중이 높았던 
https://solvesql.com/problems/day-of-furniture/
*/


-- 250314: 완! 근데 daily_furniture_orders와 daily_tot_orders를 한 번에 출력 어떻게 못하나
WITH  daily_furniture_orders AS    -- 데일리 가구 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(DISTINCT order_id) AS fur_cnt
        FROM  records
       WHERE  category = 'Furniture'
       GROUP  BY 1
      )
    , daily_tot_orders AS    -- 데일리 총 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(DISTINCT order_id) AS tot_cnt
        FROM  records
       GROUP  BY 1
      HAVING  COUNT(DISTINCT order_id)>=10
      )
    , daily_orders_info AS
      (
      SELECT  dfo.order_date    -- 데일리 가구 주문건수 비율
            , ROUND(fur_cnt/tot_cnt*100, 2) AS fur_pct
        FROM  daily_tot_orders AS dto
              LEFT JOIN daily_furniture_orders AS dfo ON dto.order_date = dfo.order_date
      )

SELECT  doi.order_date
      , fur_cnt AS furniture
      , fur_pct AS furniture_pct
  FROM  daily_orders_info AS doi
        LEFT JOIN daily_furniture_orders AS dfo ON doi.order_date = dfo.order_date
 WHERE  fur_pct>=40
 ORDER  BY 3 DESC, 1
 ;

-- 코파일럿으로 optimize 한 쿼리이다. 서브쿼리 하나를 줄일 수 있다.
WITH daily_orders AS (
    SELECT DATE(order_date) AS order_date,
           COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id END) AS fur_cnt,  --> 이렇게 줄여쓸 수 있다!
           COUNT(DISTINCT order_id) AS tot_cnt
    FROM records
    GROUP BY DATE(order_date)
    HAVING COUNT(DISTINCT order_id) >= 10  --> 마찬가지로 넣는 부분
),
daily_orders_info AS (
    SELECT order_date,
           fur_cnt,
           ROUND(fur_cnt / tot_cnt * 100, 2) AS fur_pct
    FROM daily_orders
)

SELECT order_date,
       fur_cnt AS furniture,
       fur_pct AS furniture_pct
FROM daily_orders_info
WHERE fur_pct >= 40
ORDER BY furniture_pct DESC, order_date;



/* 오답노트 */
-- 250207: 우선 "일별 주문 수"의 기준을 order_date로 하지 않고 order_id로 하였다. 
-- order_id 자체가 한 번의 주문 건으로 집계가 될 텐데, order_id는 고유하지 않기 때문
-- 그러나 order_id 하나 안에 Furniture가 있을 경우도 있고, Furniture가 여러개 있을 수도 있다. 
-- 그렇다면 둘 중 하나이다. 있기만 하면 포함해서 하나로 퉁쳐 집계를 해야하는 것, 혹은 order_date로 집계해서 각각을 주문으로 보는 것.
-- 후자가 처음 접근과는 다르지만 그렇게 해보기로 하였다. 
-- 우선 주문수가 10개 이상인 날을 조건으로, furniture이면 1 아니면 0으로 하는 쿼리를 생성
SELECT  order_date
      , CASE category WHEN 'Furniture' THEN 1 ELSE 0 END AS furniture_yn             
  FROM  records
 WHERE  order_date IN 
                    (
                    SELECT  order_date
                      FROM  records
                     GROUP  BY order_date
                    HAVING  COUNT(*) >= 10
                    )
-- 그리고 다음과 같이 집계하였다.
SELECT  order_date
      , SUM(furniture_binary) AS furniture
      , ROUND(SUM(furniture_binary)/COUNT(*)*100, 2) AS furniture_pct
  FROM  (
      SELECT  order_date
            , CASE category WHEN 'Furniture' THEN 1 ELSE 0 END AS furniture_binary             
        FROM  records
      WHERE  order_date IN 
                          (
                          SELECT  order_date
                            FROM  records
                          GROUP  BY order_date
                          HAVING  COUNT(*) >= 10
                          )
        ) furniture_agg_table
 GROUP  BY order_date
HAVING  furniture_pct >= 40 
 ORDER  BY 3 DESC;
-- 그러나 이 쿼리의 문제. 12건중 6건만 뜸. 실제로 보니 11월 19일 같은 경우 전체 주문 제품이 25건?26건으로 뜨는데 결과에서는 15건만 뜬다고 한다.
-- WHERE절 서브쿼리를 HAVING  COUNT(order_id) >= 10라고 바꾸어도 결과는 같았다.
-- 다음으로 확인해보았다.
SELECT  order_date, order_id, category
  FROM  records
 WHERE  order_date = '2020-11-19'
 ORDER  BY order_date, order_id, category
-- 아니나 다를까, 처음에 접근한 방식이 맞았던 것이다. furniture가 포함이 되면 주문한 것으로 간주하는 것이다. 

-- 250209: 그래서 바꾸어보았다. 먼저 order_id가 10개 이상인 날들에 대해 GROUP_CONCAT(category)에 가구가 있는지 없는지 확인하여 1, 0을 부여하여 집계
-- (서브쿼리는 문제 없으나) "check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS c ON r.order_id = c.order_id GROUP BY 1' at line 18" 
      -- 문법 오류가 생긴다.
SELECT  r.order_date
      , SUM(c.furnitures) AS furniture
      , SUM(c.funitures)/COUNT(c.order_id) AS furniture_pct
  FROM  records r
      RIGHT JOIN 
      (
        SELECT  order_id
              , CASE WHEN GROUP_CONCAT(category) LIKE '%Furniture%' THEN 1 ELSE 0 END AS furnitures      
          FROM  records
         WHERE  order_date IN 
                            (
                            SELECT  order_date
                              FROM  records
                             GROUP  BY 1
                            HAVING  COUNT(order_id) >= 10
                            )
         GROUP  BY 1
      ) countbyorderid c ON r.order_id = c.order_id
 GROUP  BY 1;

-- 250212: 자꾸 c 부터 문제가 생겨서 c로 임시테이블 이름을 바꾸고 오타가 나있던 메인쿼리 3번째 줄을 고쳤더니 정상 작동!
SELECT  r.order_date
      , SUM(c.furnitures) AS furniture
      , SUM(c.furnitures)/COUNT(c.furnitures) AS furniture_pct
  FROM  records r,
      (
        SELECT  order_id
              , CASE WHEN GROUP_CONCAT(category) LIKE '%Furniture%' THEN 1 ELSE 0 END AS furnitures      
          FROM  records
         WHERE  order_date IN 
                            (
                            SELECT  order_date
                              FROM  records
                             GROUP  BY 1
                            HAVING  COUNT(order_id) >= 10
                            )
         GROUP  BY 1
      )  c 
 WHERE  r.order_id = c.order_id
 GROUP  BY 1
 ;
-- 그래서 완성한 쿼리였는데, 정답은 12개나 제출은 84개인 쿼리가 되어버렸다.
SELECT  r.order_date
      , SUM(c.furnitures) AS furniture
      , ROUND(SUM(c.furnitures)/COUNT(c.furnitures)*100, 2) AS furniture_pct
  FROM  records r,
      (
        SELECT  order_id
              , CASE WHEN GROUP_CONCAT(category) LIKE '%Furniture%' THEN 1 ELSE 0 END AS furnitures      
          FROM  records
         WHERE  order_date IN 
                            (
                            SELECT  order_date
                              FROM  records
                             GROUP  BY 1
                            HAVING  COUNT(order_id) >= 10
                            )
         GROUP  BY 1
      )  c 
 WHERE  r.order_id = c.order_id
 GROUP  BY 1
HAVING  SUM(c.furnitures)/COUNT(c.furnitures) >= 0.40
 ORDER  BY 3 DESC, 1
 ;


-- 250314: 다시, 새로 시작했다. (무식하게..?) WITH 문 쓰면서 해봤는데, 생각보다 금방금방 결과가 나왔다. 문제는 레코드 개수 부터 달랐다. (제출: 43개, 정답: 12개)
-- 그니까, 주문건수가 가구를 같이 시키면 주문한 걸로 해당 주문 통째로 가구 주문인건지, 아니면 주문 하나하나 물건단위로 세야하는지 애매모호 하다. 생각하는 사람마다 다를 것 같고.
WITH  daily_furniture_orders AS    -- 데일리 가구 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(order_id) AS fur_cnt
        FROM  records
       WHERE  category = 'Furniture'
       GROUP  BY 1
      )
    , daily_tot_orders AS    -- 데일리 총 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(order_id) AS tot_cnt
        FROM  records
       GROUP  BY 1
      )
    , daily_orders_info AS
      (
      SELECT  dfo.order_date    -- 데일리 가구 주문건수 비율
            -- , fur_cnt
            -- , tot_cnt
            , ROUND(fur_cnt/tot_cnt*100, 2) AS fur_pct
        FROM  daily_furniture_orders AS dfo
              LEFT JOIN daily_tot_orders AS dto ON dfo.order_date = dto.order_date
      )

SELECT  doi.order_date
      , fur_cnt
      , fur_pct
  FROM  daily_orders_info AS doi
        LEFT JOIN daily_furniture_orders AS dfo ON doi.order_date = dfo.order_date
 WHERE  fur_pct>=40
 ORDER  BY 3 DESC, 1
 ;
-- ㅋㅋ 아이런~ 주문 건수가 10건 이상인 날 조건을 안걸었잖아~ 완료!
WITH  daily_furniture_orders AS    -- 데일리 가구 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(DISTINCT order_id) AS fur_cnt
        FROM  records
       WHERE  category = 'Furniture'
       GROUP  BY 1
      )
    , daily_tot_orders AS    -- 데일리 총 주문건수
      (
      SELECT  DATE(order_date) AS order_date
            , COUNT(DISTINCT order_id) AS tot_cnt
        FROM  records
       GROUP  BY 1
      HAVING  COUNT(DISTINCT order_id)>=10
      )
    , daily_orders_info AS
      (
      SELECT  dfo.order_date    -- 데일리 가구 주문건수 비율
            , ROUND(fur_cnt/tot_cnt*100, 2) AS fur_pct
        FROM  daily_tot_orders AS dto  -->  조건 걸면서 조인 시키는 역할 바꿈
              LEFT JOIN daily_furniture_orders AS dfo ON dto.order_date = dfo.order_date
      )

SELECT  doi.order_date
      , fur_cnt AS furniture
      , fur_pct AS furniture_pct
  FROM  daily_orders_info AS doi
        LEFT JOIN daily_furniture_orders AS dfo ON doi.order_date = dfo.order_date
 WHERE  fur_pct>=40
 ORDER  BY 3 DESC, 1
 ;
