"""
1667. Fix Names in a Table
https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan&id=sql-i
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.

Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id.

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
"""

/*- mine: INITCAP 은 oracle에만 있고, mysql에는 없기 떄문에 따로 지정해서 만들어야 한다. -*/
SELECT user_id, CONCAT( UPPER(LEFT(name, 1)), SUBSTR(LOWER(name), 2) ) AS name
FROM USERS
ORDER BY user_id;


"""다른 풀이"""
/* MySQL by.aholzmann : LEFT 와 RIGHT를 활용하여 논리적으로 작성한 모습이다. */
SELECT
    user_id,
    CONCAT(UPPER(LEFT(name,1)),LOWER(RIGHT(name,LENGTH(name)-1))) AS name
FROM
    Activity    -- 중간에 문제가 수정되었는지 이 테이블로 된 답들도 많음
ORDER BY
    user_id ASC
