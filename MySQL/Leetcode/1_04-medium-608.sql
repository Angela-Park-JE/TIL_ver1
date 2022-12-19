"""
608. Tree Node
https://leetcode.com/problems/tree-node/?envType=study-plan&id=sql-i
Each node in the tree can be one of three types:
Leaf: if the node is a leaf node.
Root: if the node is the root of the tree.
Inner: If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.
Return the result table in any order.

Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
Explanation: 
Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.
"""


/* mine : 허허 생각보다 시간이 오래걸렸다. 35분이상... */

-- MySQL
SELECT id, 
       CASE WHEN p_id IS NULL THEN 'Root'
            WHEN p_id IS NOT NULL
                AND id IN (SELECT DISTINCT p_id FROM TREE) THEN 'Inner'
        ELSE 'Leaf'
        END type
FROM TREE;



"""오답노트"""

-- 똑같이 case when을 쓰는데, 
-- `p_id = NULL THEN 'Root'` 썼더니 Root가 안나오고 비어있었는데,
-- `p_id IS NULL THEN 'Root'` 썼더니 Root가 제대로 나왔었다.
SELECT id, 
       CASE WHEN p_id IS NULL THEN 'Root'

-- 아무튼 뭔가 단단히 잘못 생각하고 Inner 를 제대로 정리를 못하고 있다가, 어느 순간 팍 하고 떠올라버렸다.
SELECT id, 
       CASE WHEN p_id IS NULL THEN 'Root'
       
            # WHEN p_id IS NOT NULL AND id NOT IN (SELECT DISTINCT p_id FROM TREE) THEN 'Leaf' -- 부모는 있는데 부모가 된적이 없으면 leaf 아닌가 이건 안됨
            
            # WHEN p_id IN (SELECT id FROM TREE WHERE p_id IS NULL) 
            #     AND id IN (SELECT DISTINCT p_id FROM TREE) THEN 'Inner' -- 이게 아니라
            WHEN p_id IS NOT NULL
                AND id IN (SELECT DISTINCT p_id FROM TREE) THEN 'Inner'   -- 이것

        ELSE 'Leaf'
        END type
FROM TREE;
