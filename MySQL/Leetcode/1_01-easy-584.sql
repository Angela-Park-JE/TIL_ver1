"""
584. Find Customer Referee
https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan&id=sql-i
Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.
The query result format is in the following example.

Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
"""



/*- 왜째서인지 테스트 케이스에서는 NULL 인 사람들도 포함해야하고, 실제 시험 케이스에서는 NULL 인 사람들을 제외해야 했다. 
  문제에 문제가 있다고 생각했고 많은 사람들이 문제가 있다고 이야기 하고 있었으나... 
  COALESCE() 를 사용한 어떤 사람의 답은 모든 케이스에서 맞는 것으로 채점되었다. -*/

/*- mine : NULL 이 아니고, 2가 아닌 사람들을 찾기 -*/
-- MySQL
SELECT name
FROM CUSTOMER
WHERE referee_id != NULL
  AND referee_id != 2;



"""다른 답안"""

-- by. Vaishnav-Dahake
select name
from Customer
where coalesce(referee_id,'') != 2
