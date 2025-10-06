/*
Flow and Stock
https://solvesql.com/problems/flow-and-stock/
*/


-- 251006: 연별로 생기는 저량에 대해서는 window 함수를 쓰면 되겠다는 생각이었고
-- 유량은 연별로 별다른 조건 없이 (획득연도를 알 수 없는것만 아니면) 집계해도 됐다. 
-- 전에 문제 풀면서 했던 바로는 데이터베이스 엄청 복잡하게 생겼던데 그냥 COUNT떄려도 됨. 이게 왜 난이도4지? 싶었음
SELECT  ay AS 'Acquisition year'
      , naty AS 'New acquisitions this year (Flow)'
      , SUM(naty) OVER (ORDER BY ay) AS 'Total collection size (Stock)'
  FROM  
        (
          SELECT  YEAR(acquisition_date) AS ay
                , COUNT(*) AS naty
            FROM  artworks 
           WHERE  YEAR(acquisition_date) IS NOT NULL
           GROUP  BY 1
        ) acq_years
 ORDER  BY 1
;
