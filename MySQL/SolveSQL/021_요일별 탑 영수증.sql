/*
데이터리안 SQL 캠프 마스터반> 레스토랑 요일 별 구매금액 Top 3 영수증
https://solvesql.com/problems/top-3-bill/
*/


-- 250725: 윈도우만 알면 어렵지 않게 해결할 수 있는 것
-- 그런데 이 ROW_NUMBER 정렬이 효율적인 방법은 아니다보니 다른 방법도 있지 않을까 고민된다.
SELECT  day
      , time
      , sex
      , total_bill
  FROM  
        (
            SELECT  *
                  , ROW_NUMBER() OVER (PARTITION BY day ORDER BY total_bill DESC) AS rownum
              FROM  tips
        ) rowtable  -- total_bill 등수를 먹여놓고 바로 출력이 가능하도록 전체 테이블 포함
 WHERE  rownum <= 3
;
