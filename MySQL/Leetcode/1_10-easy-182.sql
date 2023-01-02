"""
182. Duplicate Emails
https://leetcode.com/problems/duplicate-emails/?envType=study-plan&id=sql-i
Write an SQL query to report all the duplicate emails.
Return the result table in any order.
Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
"""



/*- mine : id는 고유키니까 그것으로 COUNT가 1 초과면 나오도록 했다.
    어차피 칼럼이 둘 뿐이다보니까 `GROUP BY email`을 하던가 말던가인줄 알았는데, 
    그렇게 되면 전체 email 을 대상으로 COUNT 하는 식이 되어버리나보다. 거를 이메일이 없을 때 거를 이메일이 나온다. -*/
    
-- MySQL
SELECT email Email
FROM PERSON
GROUP BY email
HAVING COUNT(id) > 1;
