/*-누적합, 이동평균등을 구할 때 WINDOW 함수를 사용할 수도 있지만 correlated subquery를 사용하는 방법도 있다.
   이는 SELECT 절에 서브쿼리를 적는데, 이 서브쿼리가 아우터 쿼리의 테이블을 참조하는 형식이다.
    이전에 배운 일반적인 서브쿼리는 아우터쿼리 안에 서브쿼리가 있어서 아우터쿼리가 서브쿼리를 참조하는 형식이었다는 점에서 다르다.-*/

-- 누적합: 특정 시간 기준으로 추산된 이용자들의 수(unique_user_cnt)를 일자별(datetime)로 누적(해당 날짜 포함)을 낸다고 해보자.
SELECT  datetime
      , unique_user_cnt
      , (SELECT  SUM(unique_user_cnt)  
           FROM  web_cnt_byday AS t2  
          WHERE  t2.datetime <= t1.datetime)
        AS running_SUM
  FROM  web_cnt_byday AS t1;


-- 이동평균: 이번엔 특정 시간 기준으로 이용자들의 수를 해당일 전후 날짜를 포함한 3일치의 평균을 구한다고 해보자.
SELECT  datetime
      , unique_user_cnt
      , (SELECT  SUM(unique_user_cnt)  
           FROM  web_cnt_byday AS t2  
          WHERE  t2.datetime BETWEEN DATE_SUB(t1.datetime, INTERVAL 1 DAY) AND DATE_ADD(t1.datetime, INTERVAL 1 DAY))
        AS moving_avg
  FROM  web_cnt_byday AS t1;

-- 만약 이동평균이기 때문에 해당 연도의 첫날 처럼 전날 데이터가 없을 시 Null을 뱉도록 CASE WHEN을 사용할 수도 있다.
-- 해당 날(t1)과 전날(t2)를 합하여 구하는 sql예시.
SELECT  datetime
      , t1.unique_user_cnt
      , CASE WHEN t1.datetime = '2022/01/01' THEN NULL
             ELSE (t1.unique_user_cnt
                 + (
                    SELECT  t2.unique_user_cnt
                      FROM  web_cnt_byday AS t2
                     WHERE  t2.datetime = DATE_SUB(t1.datetime, INTERVAL 1 DAY))
                   ) / 2
            END AS moving_avg
  FROM  web_cnt_byday AS t1
 ORDER  BY t1.order_date ASC;


-- 만약 해당 날보다 작은 값을 기록한 날들이 10개 미만인 날들을 세보고 싶다면
SELECT  datetime
      , unique_user_cnt
  FROM  web_cnt_byday t1
 WHERE  10 > (SELECT  COUNT(*)
                FROM  web_cnt_byday t2
               WHERE  t1.unique_user_cnt > t2.unique_user_cnt) -- 해당 날짜보다 작은 날들을 세어서
