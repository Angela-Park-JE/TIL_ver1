/*
비디오 대여 가게에서 매출이 잘 나오게 하는 배우 특집으로 뭔가를 하고 싶은거야. (배우를 찾아 필름을 본다고 생각한거지.) 
https://solvesql.com/problems/top-revenue-actors/
*/


-- 260128: 먼저 film별로 매출액을 따져본 뒤, 해당 film에 actor를 붙여서 한 번 더 actor별로 산출, 그리고 그 산출한 결과로 마지막 메인 쿼리를 짠다
-- 찬찬히 짜보고 생각해보고 하면서 오답 없이 15분 정도에 풀은 것 같다. 2단계는 아닐지도
WITH 
  rental_rev_by_film AS
    (
      SELECT  f.film_id
            , SUM(amount) AS rental_rev
        FROM  rental r
              LEFT JOIN payment p ON r.rental_id = p.rental_id
              LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
              LEFT JOIN film f ON i.film_id = f.film_id
       GROUP  BY 1
    )
  ,
  rental_rev_by_films_actor AS
    (
      SELECT  actor_id
            , SUM(rental_rev) actor_rev
        FROM  film_actor a
              LEFT JOIN rental_rev_by_film cte_bf ON a.film_id = cte_bf.film_id
       GROUP  BY 1
      --  ORDER  BY 2 DESC
    )

SELECT  first_name
      , last_name
      , actor_rev AS total_revenue
  FROM  rental_rev_by_films_actor cte_ba
        LEFT JOIN actor ON cte_ba.actor_id = actor.actor_id
 ORDER  BY 3 DESC
 LIMIT 5
 ;
