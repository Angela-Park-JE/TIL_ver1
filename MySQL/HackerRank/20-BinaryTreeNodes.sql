"""
Prepare> SQL> Advanced Select> Binary Tree Nodes
https://www.hackerrank.com/challenges/binary-search-tree-1/
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
  Root: If node is root node.
  Leaf: If node is leaf node.
  Inner: If node is neither root nor leaf node.
"""

/*- MySQL 
조건과 반복문을 잘 만들 수 있었다면 더 쉽게 결과물을 냈을 수도 있다는 답답함을 느꼈다.
1. 차례대로 N을 P로 엮으면서, N이 Null이 되면 멈추고, 
2. 순서대로 그룹을 묶어서 차례대로 컬럼 unique값이 2진(1, 2, 4, 8 ...)인 것을 확인하여 
3. 각 컬럼의 DISTINCT 값을, 첫번째는 Root로, 마지막은 'Leaf'로, 그 나머지는 'Inner'가 붙도록 하는 것이다...는 꿈이었다. -*/

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


""" ANOTER ANSWERS """
/*- SQLServer by.firatkuas : 와 iif라는 것을 사용해서 테이블을 계속 이은 효과를 냈다. 충격적. -*/
SELECT
    DISTINCT
    (
        IIF(s.P is null,
            str(b.N)+' Leaf',
                IIF(b.P is null,
                    str(b.N)+' Root',
                        str(b.N)+' Inner'))
    )
FROM
    BST b 
    left join BST s on b.N = s.P
    
/*- MySQL by.tubededentifrice : 위와 같이 If를 사용하는 방식인데, 조금더 간단하게 Inner와 Leaf를 구별한다. 내가 보고 이해하기 좋은 방향을 약간의 수정을 거쳤다. -*/
SELECT N, 
    IF(P IS NULL,'Root',
        IF((SELECT COUNT(*) FROM BST WHERE P=B.N)>0,'Inner','Leaf')) 
FROM BST AS B 
ORDER BY N

/*- Oracle by.marinskiy : 저도ㅠ CASE WHEN 을 정말 쓰고 싶었어요 근데 넘 멋지네요 답이 위에 다 우겨넣고 아래로 간결해지는게 아름다워요-*/
SELECT N,
    CASE
        WHEN P IS NULL THEN 'Root'
        WHEN N IN (SELECT P FROM BST) THEN 'Inner'
        ELSE 'Leaf'
    END
FROM BST
ORDER BY N;
