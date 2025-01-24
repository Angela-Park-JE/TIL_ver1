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


-- 250121: 2014년만 해본 것인데 결과행이 나오지 않는다.
SELECT  DISTINCT main_aw.classification AS classification
      , (SELECT COUNT(*)  FROM artworks a14 WHERE main_aw.classification = a14.classification 
                                              AND YEAR(a14.acquisition_date) = 2014)  AS '2014'
  FROM  (SELECT IFNULL(classification, '(not assigned)') AS classification FROM artworks) main_aw

ORDER  BY 1;
-- 일단 전에 했던 것에서 두번째쿼리를 보면 메인쿼리 프롬절의 tmp 테이블이 WHERE로 기간이 제한되어서 classification의 종류가 제한되어 있을 수밖에 없다는 문제점을 발견했다.
-- 그래서 먼저 classlist만 구한 다음 각 해별로 1, 0 하고 SUM을 구하는 쿼리를 조인시키는 식으로 했...는데 생각해보니 class_list는 class_list가 아니라 그냥 class만 데려온 상태인 것이었다.
SELECT  DISTINCT class_list.classification
      , s14 AS '2014'
      , s15 AS '2015'
      , s16 AS '2016'
  FROM  
        (SELECT IFNULL(classification, '(not assigned)') AS classification FROM artworks) AS class_list
                LEFT JOIN 
                         (
                          SELECT  classification AS classification
                                , SUM('2014') AS s14
                                , SUM('2015') AS s15
                                , SUM('2016') AS s16
                            FROM   
                                (
                                  SELECT  IFNULL(classification, '(not assigned)') AS classification
                                        , CASE WHEN YEAR(acquisition_date) = 2014 THEN 1 ELSE 0 END AS '2014'
                                        , CASE WHEN YEAR(acquisition_date) = 2015 THEN 1 ELSE 0 END AS '2015'
                                        , CASE WHEN YEAR(acquisition_date) = 2016 THEN 1 ELSE 0 END AS '2016'
                                    FROM  artworks
                                  WHERE  YEAR(acquisition_date) BETWEEN 2014 AND 2016 
                                 ) AS num_by_class
                           GROUP  BY 1
                         ) AS cnt_by_class
                        ON class_list.classification = cnt_by_class.classification

 ORDER  BY 1
;
