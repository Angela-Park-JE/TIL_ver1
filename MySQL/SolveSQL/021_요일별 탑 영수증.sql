/*
데이터리안 SQL 캠프 마스터반> 레스토랑 요일 별 구매금액 Top 3 영수증
https://solvesql.com/problems/top-3-bill/
*/


-- 250725: 엥 이게왜 4단
SELECT  day
      , time
      , sex
      , total_bill
  FROM  
        (
            SELECT  *
                  , ROW_NUMBER() OVER (PARTITION BY day ORDER BY total_bill DESC) AS rownum
              FROM  tips
        ) rowtable  -- total_bill 등수를 먹여놓고 출력하도록 전체 테이블을 포
 WHERE  rownum <= 3
;
