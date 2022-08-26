"""
Prepare> SQL> Advanced Select> Binary Tree Nodes
https://www.hackerrank.com/challenges/binary-search-tree-1/
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
  Root: If node is root node.
  Leaf: If node is leaf node.
  Inner: If node is neither root nor leaf node.
"""

/*- MySQL -*/
WITH TBL as 
    (SELECT b4.P AS c1, b3.P AS c2, b2.P AS c3, b1.P AS c4, b1.N as C5 
     FROM BST b1 
                JOIN BST b2 ON b1.P = b2.N
                JOIN BST b3 ON b2.P = b3.N
                JOIN BST b4 ON b3.P = b4.N)

(SELECT DISTINCT c5, 'Leaf' FROM TBL)
UNION
(SELECT DISTINCT c4, 'Inner' FROM TBL)
UNION
(SELECT DISTINCT c3, 'Inner' FROM TBL)
UNION
(SELECT DISTINCT c2, 'Root' FROM TBL)
ORDER BY 1;

"""
조건과 반복문을 잘 만들 수 있었다면 더 쉽게 결과물을 냈을 수도 있다는 답답함을 느꼈다.
1. 차례대로 N을 P로 엮으면서, N이 Null이 되면 멈추고, 
2. 순서대로 그룹을 묶어서 차례대로 컬럼 unique값이 2진(1, 2, 4, 8 ...)인 것을 확인하여 
3. 각 컬럼의 DISTINCT 값을, 첫번째는 Root로, 마지막은 'Leaf'로, 그 나머지는 'Inner'가 붙도록 하는 것이다...는 꿈이었다.
"""
