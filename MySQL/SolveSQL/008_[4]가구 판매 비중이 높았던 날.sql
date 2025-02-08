/*
가구 판매 비중이 높았던 
https://solvesql.com/problems/day-of-furniture/
*/


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
-- 다시 수정하여 정답!
