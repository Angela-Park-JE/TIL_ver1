/*
요일별로 결제 금액 top3의 결제 정보 가져오기
https://solvesql.com/problems/top-3-bill/
*/


-- 250419: RANK()를 사용한 서브쿼리 조회 방식
SELECT  day
      , time
      , sex
      , total_bill
  FROM  
      (
        SELECT  day
              , RANK() OVER (PARTITION BY day ORDER BY total_bill DESC) AS ranks
              , total_bill
              , time
              , sex
          FROM  tips 
      )  billranktable
 WHERE  ranks<=3
;
