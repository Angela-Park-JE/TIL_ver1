/*-
-*/


-- 240817: 생각보다 복잡했다 머리로 이해가 안가는게 아닌데 ㅠㅠ피곤해서인가
SELECT  product_id
      , sales/SUM(units) 
  FROM  (
        SELECT  s.product_id
              , p.price*s.units AS sales
              , s.units
        FROM  UNITSSOLD s LEFT JOIN PRICES p
              ON s.product_id = p.product_id
              AND s.purchase_date BETWEEN p.start_date AND p.end_date
        ) tmp
 GROUP  BY 1;
