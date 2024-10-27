/*
1667. Fix Names in a Table
https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
  Return the result table ordered by user_id.
  Table: Users
  +----------------+---------+
  | Column Name    | Type    |
  +----------------+---------+
  | user_id        | int     |
  | name           | varchar |
  +----------------+---------+
  user_id is the primary key (column with unique values) for this table.
*/


-- 241027: LEFT와 SUBSTR의 조합
SELECT  user_id
      , CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2))) AS name
  FROM  USERS
 ORDER  BY 1;
