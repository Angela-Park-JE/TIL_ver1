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
