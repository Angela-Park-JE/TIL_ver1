/*
특정 시기의 연도별 소장품 갯수, 없는 것도 포함.
https://solvesql.com/problems/summary-of-artworks-in-3-years/
*/


-- 241212: 우선 이렇게 먼저 요약 집계를 해줬다.
SELECT  IFNULL(classification, '(not assigned)') AS classification
      , CASE WHEN YEAR(acquisition_date) = 2014 THEN 1 ELSE 0 END AS '2014'
      , CASE WHEN YEAR(acquisition_date) = 2015 THEN 1 ELSE 0 END AS '2015'
      , CASE WHEN YEAR(acquisition_date) = 2016 THEN 1 ELSE 0 END AS '2016'
  FROM  artworks
 WHERE  YEAR(acquisition_date) BETWEEN 2014 AND 2016
 ORDER  BY 1
-- 그리고 다음이 풀이 쿼리. 요약한다. 그러나...  (제출: 22개, 정답: 28개)
SELECT  classification
      , SUM('2014') AS '2014'
      , SUM('2015') AS '2015'
      , SUM('2016') AS '2016'
  FROM  
         (
          SELECT  IFNULL(classification, '(not assigned)') AS classification
                , CASE WHEN YEAR(acquisition_date) = 2014 THEN 1 ELSE 0 END AS '2014'
                , CASE WHEN YEAR(acquisition_date) = 2015 THEN 1 ELSE 0 END AS '2015'
                , CASE WHEN YEAR(acquisition_date) = 2016 THEN 1 ELSE 0 END AS '2016'
            FROM  artworks
           WHERE  YEAR(acquisition_date) BETWEEN 2014 AND 2016
          ) tmp
 GROUP  BY 1
 ORDER  BY 1
;
