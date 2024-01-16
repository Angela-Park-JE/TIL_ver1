/* 230104: 
만약 주별로 wish_view의 evnet_name을 제외한 '_view' 로 끝나는 view들의 각 %를 보고싶다면? */

WITH
  tmp1 AS 
  (
  SELECT
      DATE(DATE_TRUNC(timestamp, week)) AS week,
      event_name,
      COUNT(session_id) AS session_count
   FROM DB.LOG_DATA
  WHERE 1=1
    AND event_name !='wish_view' -- wish_view가 들어가면 파이가 wish_view를 포함한 파이가 되기 때문에 빼놓고 분석하기
    AND REGEXP_CONTAINS(event_name,'_view$') -- '_view'로 끝나는 데이터
  GROUP BY 1, 2 
  ORDER BY 1, 2
  )

SELECT 
  week, 
  event_name, 
  session_count,
  SUM(session_count) OVER (PARTITION BY week) AS total_by_week,
  session_count /SUM(session_count) OVER (PARTITION BY week) as session_rate,
  round(session_count/SUM(session_count) OVER (PARTITION BY week),3) as session_rate_round
FROM tmp1



/* 만약 주별로 wish_view의 evnet_name을 제외한 '_view' 로 끝나는 view들의 합 대비 wish_view의 비율은? */
WITH
  tmp1 AS 
  (
  SELECT
    DATE(DATE_TRUNC(timestamp, week)) AS week,
    session_id
   FROM D.LOG_DATA
  WHERE 1=1
    AND event_name !='wish_view'
    AND REGEXP_CONTAINS(event_name,'_view$') -- '_view'로 끝나는 데이터
  GROUP BY 1, 2 
  ORDER BY 1, 2
  ),
  tmp2 AS
  (
  SELECT 
    DATE(DATE_TRUNC(timestamp, week)) AS week,
    session_id
   FROM wanted-preonboarding-challenge.data_challenge_202401.LOG_DATA
  WHERE 1=1
    AND event_name ='wish_view'
  )

SELECT 
  tmp1.week, 
  ROUND(COUNTIF(tmp2.session_id IS NOT NULL)/COUNT(tmp1.session_id), 3)
FROM tmp1 LEFT JOIN tmp2 ON tmp1.session_id = tmp2.session_id AND tmp1.week = tmp2.week
GROUP BY tmp1.week
ORDER BY 1
