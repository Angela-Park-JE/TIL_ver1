/*
196. Delete Duplicate Emails
https://leetcode.com/problems/delete-duplicate-emails/?envType=study-plan-v2&envId=top-sql-50
    Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
    For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
    For Pandas users, please note that you are supposed to modify Person in place.
    After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.
    Table: Person
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | email       | varchar |
    +-------------+---------+
*/


-- 241112: 오랫만에 써보는 DML!! 
-- Oracle
DELETE PERSON WHERE id NOT IN
    (
        SELECT  MIN(id)
          FROM  PERSON
         GROUP  BY email
    );

-- MySQL에서는 다음과 같은 오류가 뜨면서 되지 않았다...
-- You can't specify target table 'PERSON' for update in FROM clause

DELETE FROM PERSON WHERE id NOT IN
    (
        SELECT  MIN(id)
          FROM  PERSON
         GROUP  BY email
    );
