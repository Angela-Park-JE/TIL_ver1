



"""오답노트"""
-- 
SELECT s.name
FROM SALESPERSON s, COMPANY c, ORDERS o
WHERE o.sales_id = s.sales_id
  AND o.com_id = c.com_id
  AND INSTR(c.name, 'RED') > 0
  AND s.sales_id NOT IN (SELECT sales_id FROM ORDERS);


-- 
SELECT s.name
FROM ORDERS o LEFT JOIN SALESPERSON s ON o.sales_id = s.sales_id
              LEFT JOIN COMPANY c ON o.com_id = c.com_id
WHERE INSTR(c.name, 'RED') > 0
  AND s.sales_id NOT IN (SELECT sales_id FROM ORDERS);
