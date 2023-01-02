"""
1158. Market Analysis I

"""



"""오답노트"""

-- 일단 IFNULL 을 쓰려고 했었는데, order_date 가 2019 가 아닌 것들이 아예 뜨지 않는 오류가 발생.
SELECT u.user_id buyer_id, u.join_date, 
       IFNULL(COUNT(o.order_id), 0) orders_in_2019
FROM USERS u LEFT JOIN ORDERS o ON u.user_id = o.buyer_id, ITEMS i
WHERE 1=1
  AND o.item_id = i.item_id
  AND YEAR(o.order_date) = 2019
GROUP BY o.buyer_id;
