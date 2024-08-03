/*-
595. Big Countries
https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50
  A country is big if: 
    it has an area of at least three million (i.e., 3000000 km2), or
    it has a population of at least twenty-five million (i.e., 25000000).
  Write a solution to find the name, population, and area of the big countries.
  Return the result table in any order.

  Table: World
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | name        | varchar |
  | continent   | varchar |
  | area        | int     |
  | population  | int     |
  | gdp         | bigint  |
  +-------------+---------+
-*/


-- 240803: 두 조건 중 하나만 만족하면 된다.
SELECT  name
      , population
      , area
  FROM  WORLD
 WHERE  area >= 3000000  
    OR  population >= 25000000;
