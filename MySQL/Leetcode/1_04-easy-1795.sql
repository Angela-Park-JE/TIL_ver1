"""
1795. Rearrange Products Table
https://leetcode.com/problems/rearrange-products-table/?envType=study-plan&id=sql-i
product_id is the primary key for this table.
Each row in this table indicates the product's price in 3 different stores: store1, store2, and store3.

If the product is not available in a store, the price will be null in that store's column.
Write an SQL query to rearrange the Products table so that each row has (product_id, store, price). 
If a product is not available in a store, do not include a row with that product_id and store combination in the result table.

Input: 
Products table:
+------------+--------+--------+--------+
| product_id | store1 | store2 | store3 |
+------------+--------+--------+--------+
| 0          | 95     | 100    | 105    |
| 1          | 70     | null   | 80     |
+------------+--------+--------+--------+
Output: 
+------------+--------+-------+
| product_id | store  | price |
+------------+--------+-------+
| 0          | store1 | 95    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store1 | 70    |
| 1          | store3 | 80    |
+------------+--------+-------+
"""

/* mine : 처음에는 CASE WHEN 으로 풀어가려고 했으나 기억이 나지 않아서 UNPIVOT 따위의 단위만 생각하다가 찾아보았다. 
    */

-- MySQL:  참고> https://ubiq.co/database-blog/unpivot-table-mysql/
SELECT product_id, 'store1' store, store1 price
FROM PRODUCTS
WHERE store1 IS NOT NULL
UNION ALL
SELECT product_id, 'store2' store, store2 price
FROM PRODUCTS
WHERE store2 IS NOT NULL
UNION ALL
SELECT product_id, 'store3' store, store3 price
FROM PRODUCTS
WHERE store3 IS NOT NULL;


-- Oracle: UNPIVOT 을 사용한 방법
-- SELECT * 필수 참고> https://dejavuhyo.github.io/posts/oracle-unpivot/
SELECT * 
FROM PRODUCTS
UNPIVOT 
    (
    price        -- 밸류가 들어갈 자리
    FOR store    -- 컬럼명이 들어갈 자리
    IN (         -- 그래서 무엇을 언피봇
        store1 AS 'store1',
        store2 AS 'store2',
        store3 AS 'store3'
        )
    );

