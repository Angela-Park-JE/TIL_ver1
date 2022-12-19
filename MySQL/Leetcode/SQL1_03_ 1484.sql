"""
1484. Group Sold Products By The Date
https://leetcode.com/problems/group-sold-products-by-the-date/?envType=study-plan&id=sql-i
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.

Write an SQL query to find for each date the number of different products sold and their names.
The sold products names for each date should be sorted lexicographically.
Return the result table ordered by sell_date.

Input: 
Activities table:
+------------+------------+
| sell_date  | product     |
+------------+------------+
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |
+------------+------------+
Output: 
+------------+----------+------------------------------+
| sell_date  | num_sold | products                     |
+------------+----------+------------------------------+
| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
+------------+----------+------------------------------+
"""


/* mine : GROUP_CONCAT 이 생각이 안나서 검색의 도움을 받아버렸다. 
    날짜별로 중복되는 물건에 대해서는 표시가 한 가지만 되어야 한다. 그래서 DISTINCT 필요. */

SELECT sell_date, COUNT(DISTINCT product) AS num_sold, 
    GROUP_CONCAT(DISTINCT product) products
FROM ACTIVITIES 
GROUP BY sell_date
ORDER BY sell_date;


"""다른 답안"""
/* MySQL by. DonBosco256 : 상세하게 지정하는 부분들을 적은 코드이다. 커스텀이 필요한 경우 이것을 참고하면 좋을 듯.*/

SELECT sell_date, count( DISTINCT product ) as num_sold ,
    
    GROUP_CONCAT( DISTINCT product order by product ASC separator ',' ) as products
    
        FROM Activities GROUP BY sell_date order by sell_date ASC;
