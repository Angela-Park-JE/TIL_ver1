

/-* MySQL : 실패한 부분. 잘못생각함. *-/
SELECT f1.x1, f1.y1
FROM (SELECT x x1, y y1 FROM FUNCTIONS) f1
    JOIN (SELECT x x2, y y2 FROM FUNCTIONS) f2 ON f1.x1 = f2.x2
WHERE f1.x1 = f2.y2 AND f1.y1 = f2.x2 AND f1.x1 <= f1.y1
ORDER BY 1;
