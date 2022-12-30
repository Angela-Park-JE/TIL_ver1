"""
1393. Capital Gain/Loss
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
