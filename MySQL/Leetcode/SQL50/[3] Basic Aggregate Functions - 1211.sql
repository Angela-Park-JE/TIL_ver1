/*
1211. Queries Quality and Percentage
https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50
  We define query quality as:
    The average of the ratio between query rating and its position.
  We also define poor query percentage as:
    The percentage of all queries with rating less than 3.
  Write a solution to find each query_name, the quality and poor_query_percentage.
  Both quality and poor_query_percentage should be rounded to 2 decimal places.
  Return the result table in any order.
  Table: Queries
  +-------------+---------+
  | Column Name | Type    |
  +-------------+---------+
  | query_name  | varchar |
  | result      | varchar |
  | position    | int     |
  | rating      | int     |
  +-------------+---------+
  This table may have duplicate rows.
*/


-- 240910: 문제의 예시 output을 보고 확실하게 해결 방식을 세우고 해서 큰 문제는 없었다. (294ms Beats 97.23%)
-- 그러나 테스트 12번 케이스에서 query_name이 null인 항목이 있어서 아예 없애버리니 문제가 없었다.
-- duplicate rows가 있다고 했는데 결국 별다른 전처리 없이도 정답 처리가 되었다.
SELECT  query_name
      , ROUND(AVG(quality), 2) AS quality
      , ROUND(AVG(poor_cnt)*100, 2) AS poor_query_percentage
  FROM  (
        SELECT  query_name
              , rating/position AS quality
              , CASE WHEN rating<3 THEN 1 
                     ELSE 0 END AS poor_cnt
          FROM  QUERIES
         WHERE  query_name IS NOT NULL -- test12에서 query_name이 null인 항목이 있음
        ) tmp
 GROUP  BY query_name;
