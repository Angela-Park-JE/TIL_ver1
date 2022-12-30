"""
1393. Capital Gain/Loss
Write an SQL query to report the Capital gain/loss for each stock.
The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
Return the result table in any order.
Input: 
Stocks table:
+---------------+-----------+---------------+--------+
| stock_name    | operation | operation_day | price  |
+---------------+-----------+---------------+--------+
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |
+---------------+-----------+---------------+--------+
Output: 
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |
+---------------+-------------------+
"""



/*- mine : CASE WHEN 으로 어떻게 꾸리는 것이 좋을까 하다가 부호를 바꾸어 놓는 서브쿼리로 임시 테이블을 만들어 조회하기로 했다. 
    속도도 나쁘지 않은 편이었다. 이거랑, 윈도우 함수를 사용하는 방법도 생각해보았다.-*/

-- MySQL 
SELECT stock_name, SUM(prices) capital_gain_loss
FROM 
    (
    SELECT stock_name, 
        CASE operation WHEN 'Buy' THEN 0-price
                    WHEN 'Sell' THEN 0+price END prices
    FROM STOCKS
    ) tmp
GROUP BY 1;



"""다른 답안"""

-- MySQL by.ttsugrii : SUM 안에 CASE WHEN을 적은 방식이다. 오.... 서브쿼리를 쓸 필요가 없어진다.
SELECT stock_name, SUM(
    CASE
        WHEN operation = 'Buy' THEN -price
        ELSE price
    END
) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name; 
