/*
특정 시기의 연도별 소장품 갯수, 없는 것도 포함.
https://solvesql.com/problems/summary-of-artworks-in-3-years/
*/


-- 250129: 메인쿼리에서 cnt를 SUM으로 합계 내주는 쿼리
SELECT  classification
      , SUM(cnt14) AS '2014'
      , SUM(cnt15) AS '2015'
      , SUM(cnt16) AS '2016'
  FROM  
      (
        SELECT  IFNULL(classification, '(not assigned)') AS classification
              , CASE WHEN YEAR(acquisition_date) = 2014 THEN 1 ELSE 0 END AS cnt14
              , CASE WHEN YEAR(acquisition_date) = 2015 THEN 1 ELSE 0 END AS cnt15
              , CASE WHEN YEAR(acquisition_date) = 2016 THEN 1 ELSE 0 END AS cnt16
          FROM  artworks
      ) cnt_table
 GROUP  BY 1
 ORDER  BY 1
;
-- 뭐한거야 다시 새롭게 시작하니 잘되는데... 
-- 물론 완전히 전과 달랐던 것은 아니다. WITH문을 만들려고 했었고 
-- `DISTINCT IFNULL(classification, '(not assigned)') AS classification` 이라는 컬럼을 가진 WITH테이블 하나를 메인에 두고 
-- SELECT 문에서 classification으로 조인시키면서 연도정보를 가진 문장으로 데려오려했음.
-- 문제는 `(SELECT COUNT() FROM artworks a1 WHERE c.classifications = a1.classification AND YEAR(acquisition_date) = 2014) AS '2014'` 
-- 이와같이 classification이 (not assigned)라고 처리되어있지 않은 artworks 원래 테이블에서 가져온다는 것임. 



/*오답노트*/

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


-- 250125: 일단 다른 artworks문제를 풀면서 artwork_id로만 집계를 해도 된다는 것을 알게되었다. 
-- 텍스트가 많아 데이터가 크기 때문에 간단하게 쓸 정보만 추려서 테이블을 하나 만드는게 날지 않을까 생각했다.
SELECT  artwork_id
      , YEAR(acquisition_date)
      , classification
  FROM  artworks 
 WHERE  YEAR(acquisition_date) IN (2014, 2015, 2016)
;
