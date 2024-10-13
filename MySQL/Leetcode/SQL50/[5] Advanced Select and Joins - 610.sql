/*
610. Triangle Judgement
https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50
  Report for every three line segments whether they can form a triangle.
  Return the result table in any order.
  Table: Triangle
  +-------------+------+
  | Column Name | Type |
  +-------------+------+
  | x           | int  |
  | y           | int  |
  | z           | int  |
  +-------------+------+
  In SQL, (x, y, z) is the primary key column for this table.
*/


-- 241013: 되면 0 안되면 1, 따라서 안되는 것이 하나라도 있으면 'No' 다 되면 0이므로 'Yes' 반환한다.
-- 셋 중 MAX를 찾는 방식을 생각해내지 못해서 세 번 연산을 하도록 할 수 밖에 없었다.
SELECT  x, y, z
      , IF(IF(x+y>z, 0, 1) + IF(x+z>y, 0, 1) + IF(y+z>x, 0, 1)!= 0, 'No', 'Yes') AS triangle
  FROM  TRIANGLE



/*다른 풀이*/
-- https://leetcode.com/problems/triangle-judgement/solutions/5544572/mysql-clean-simple-solution
-- 결국 이런 방식밖에 없는 것 같다. 
SELECT *,
    CASE WHEN x+y>z and x+z>y and y+z>x then "Yes" else "No" END
AS triangle From Triangle;
