"""
586. Customer Placing the Largest Number of Orders
order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.
Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.
The test cases are generated so that exactly one customer will have placed more orders than any other customer.
Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
"""


/*- mine : 몇가지 해결책 중 처음은 서브쿼리를 이용하는 것이었고, 둘째로 HAVING 을 사용하는 것이었다. -*/

-- MySQL
SELECT customer_number
FROM
    (
    SELECT customer_number, COUNT(order_number)
    FROM Orders
    GROUP BY 1 ORDER BY 2 DESC
    ) tmp
LIMIT 1;



"""다른 풀이"""

-- MySQL by.LeetCode : 어차피 로우는 고객 별 주문이기 때문에 *로 간단하게 할 수 있다.
SELECT
    customer_number
FROM
    orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC -- 만약 필요하다면  count(customer_number) desc 로 쓸 수 있다.
LIMIT 1;

-- MySQL by.BobbyCurry : HAVING 에서 검색하는 값을 고객별 주문량 중 가장 큰 것으로 지정한다. 사실 이렇게 할 바에 내가 한게 훨씬 빠름.
SELECT customer_number
FROM orders
GROUP BY customer_number
HAVING COUNT(order_number) = (
	SELECT COUNT(order_number) cnt
	FROM orders
	GROUP BY customer_number
	ORDER BY cnt DESC
	LIMIT 1
)

-- MySQL by.ashishkjha : WINDOW 함수를 쓰는 방식. (보기 불편해서 일부 줄 정리를 함)
select customer_number
from (
        select customer_number, rank() over (order by count(1) desc) rank_val
        from orders
        group by customer_number
        ) a 
where rank_val = 1



-- 아래에서 잘 정리해둠
-- https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/solutions/384220/3-simple-mysql-solutions/?envType=study-plan&id=sql-i&orderBy=most_votes
