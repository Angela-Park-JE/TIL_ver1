"""
데이터리안 SQL 캠프 입문반> 지역별 주문의 특징
https://solvesql.com/problems/characteristics-of-orders/
"""

-- 240331: 주문id 안에 여러 Furniture만 주문한 경우 여러 주문이더라도 한 order_id이기 때문에 한 개로 count 해야한다.
SELECT
      region Region
    , SUM(CASE WHEN category = 'Furniture' THEN ids ELSE 0 END
        ) AS 'Furniture'
    , SUM(CASE WHEN category = 'Office Supplies' THEN ids ELSE 0 END
      ) AS 'Office Supplies'
    , SUM(CASE WHEN category = 'Technology' THEN ids ELSE 0 END
      ) AS 'Technology'
FROM (SELECT region
            , category
            , COUNT(DISTINCT order_id) ids
        FROM RECORDS
       GROUP BY 1, 2) r
GROUP BY region
ORDER BY 1 ASC;



-- 오답노트: 한 주문 안에서도 여러 개의 Furniture가 있다면 여러개로 산정된다. 계속 값이 더 크게 나와서 고민했다. 그래서 설마 했는데...!
SELECT
      region Region
    , SUM(CASE WHEN category = 'Furniture' THEN 1 ELSE 0 END
        ) AS 'Furniture'
    , SUM(CASE WHEN category = 'Office Supplies' THEN 1 ELSE 0 END
      ) AS 'Office Supplies'
    , SUM(CASE WHEN category = 'Technology' THEN 1 ELSE 0 END
      ) AS 'Technology'
FROM records
WHERE country = 'United States'
GROUP BY region
ORDER BY 1 ASC;
