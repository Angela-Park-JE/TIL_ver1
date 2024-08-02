/*-
584. Find Customer Referee
https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50
  Find the names of the customer that are not referred by the customer with id = 2.
  Return the result table in any order.
  Table: Customer
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | id          | int     |
  | name        | varchar |
  | referee_id  | int     |
  +-------------+---------+
-*/


-- 240802: IS NULL으로 2가 아니면 모두를 가져오거나 (407ms, 87.68%)
SELECT  name
  FROM  CUSTOMER
 WHERE  referee_id != 2 OR referee_id IS NULL;

-- 240802: 2만 제외하고 출력하도록 하는 것도 있다. (406ms, 88.19%)
SELECT  name
  FROM  CUSTOMER
 WHERE  id NOT IN
          (SELECT  id
             FROM  CUSTOMER
            WHERE  referee_id = 2);
