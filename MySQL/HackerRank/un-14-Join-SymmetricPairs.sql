"""
Prepare> SQL> Advanced Join> Symmetric Pairs
https://www.hackerrank.com/challenges/symmetric-pairs/problem
You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
"""

/*- MySQL : BASIS_CTE에서 rownum을 매겨서 MAIN_CTE에서 같지 않은 컬럼이 조회되도록 한후, 
            서로가 같은 짝인 아이들이 중복으로 검색되는 것을 거르도록 x1 <= y1와 DISTINCT(x=y인 아이들 중복)를 사용한다. -*/
WITH BASIS_CTE AS
    (
    SELECT x, y, 
           ROW_NUMBER() OVER (ORDER BY x ASC) row_num
    FROM FUNCTIONS
    ORDER BY 1, 2
    ),
     MAIN_CTE AS
    (
    SELECT a.x x1, a.y y1, a.row_num
    FROM BASIS_CTE a, BASIS_CTE b
    WHERE 1=1
      AND b.x = a.y
      AND b.y = a.x
      AND a.row_num != b.row_num
    ORDER BY 1, 2
    )

SELECT DISTINCT x1, y1
FROM MAIN_CTE
WHERE x1 <= y1;


"""좋은 답"""
/*- MSSQL, MySQL by.vvk78 : 메인쿼리에서 아예 같은 것을 짝지어 놓는 것이 내가 하고싶었던 방식인데, HAVING 이 잘 이해가 가지 않아서 가져왔다.
    HAVING 절이 없을 때는 모든 데이터를 가져오게 되는데,
    `COUNT(f1.X)>1` 여기서 x=y인 데이터를 가져오고,
    `f1.X<f1.Y` 여기서는 서로짝인 것들 중 중복될 수 있는 row들을 거른다.
    (his explanation)
    The criteria in the having clause allows us to prevent duplication in our output while still achieving our goal of finding mirrored pairs. 
    We have to treat our pairs where f1.x = f1.y and f1.x <> f1.y differently to capture both. 
    The first criteria handles pairs where f1.x = f1.y and the 2nd criteria handles pairs where f1.x <> f1.y, which is why the or operator is used.
    The first part captures records where f1.x = f1.y. The 'count(f1.x) > 1' requires there to be at least two records of a mirrored pair to be pulled through. 
    Without this a pair would simply match with itself (since it's already it's own mirrored pair) and be pulled through incorrectly when you join the table on itself.
    The 2nd part matches the remaining mirrored pairs. It's important to note that for this challenge, the mirrored match of (f1.x,f1.y) is considered a duplicate and excluded from the final output. 
    You can see this in the sample output where (20, 21) is outputted, but not (21,20). The 'or f1.x < f1.y' criteria allows us to pull all those pairs where f1.x does not equal f1.y, but where f1.x is also less than f1.y so we don't end up with the mirrored paired duplicate.-*/
SELECT f1.X, f1.Y FROM Functions f1
INNER JOIN Functions f2 ON f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X 



"""오답노트"""

/*- MySQL : 실패한 부분. 잘못생각함. -*/
SELECT f1.x1, f1.y1
FROM (SELECT x x1, y y1 FROM FUNCTIONS) f1
    JOIN (SELECT x x2, y y2 FROM FUNCTIONS) f2 ON f1.x1 = f2.x2
WHERE f1.x1 = f2.y2 AND f1.y1 = f2.x2 AND f1.x1 <= f1.y1
ORDER BY 1;

/*- MySQL:  -*/
SELECT f1.x, f1.y
FROM FUNCTIONS f1, FUNCTIONS f2
WHERE 1=1
    AND (f1.x = f2.y AND f1.y = f2.x)
ORDER BY f1.x;
