/*

https://solvesql.com/problems/shoppingmall-monthly-summary/
*/

SELECT  EXTRACT(YEAR_MONTH FROM order_date)
  FROM  orders o RIGHT JOIN order_items it ON o.order_id = it.order_id
--  GROUP  BY 
