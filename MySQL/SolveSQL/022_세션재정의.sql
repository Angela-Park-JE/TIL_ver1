/*
데이터리안 SQL 캠프 실전반> 세션 재정의하기
https://solvesql.com/problems/redefine-session/
*/



/*풀이과정*/
-- 250802:
-- 먼저 생각이 든건 event_timestamp 기준으로 rownumber를 먹인 다음, 다음 넘버와 대조하도록 하는 것인데, 
-- event_name에 session_start라는 이름이 따로 있다. 이것을 기준으로 수정하도록 보아도 될 것 같다는 생각이 잠시 들었다가,
-- session_start라는 게 세션의 시작을 구할 뿐이지 w세션의 마지막 로그와 대조할 필요가 있기 때문에 지운다.
-- 따라서 먼저 진짜 세션 시작을 기준으로 ga_session_id를 묶고 시작 시간과 종료 시간을 먹이면 된다.
WITH 
  onehour_added_CTE AS 
    (
      SELECT  *
            , DATE_ADD(event_timestamp_kst, INTERVAL -1 HOUR ) AS stnd  -- 행동 기준 이전 1시간 (이내에 이전 행동이 있으면 같은 session)
            , ROW_NUMBER() OVER (ORDER BY event_timestamp_kst, FIELD(event_name, 'session_start') DESC) AS rownum  
                  -- event_name으로도 정렬해야 세션 시작시에 맞춰 session_start event가 먼저 나온다. ('user_engagement'라는 것 때문에 그냥 DESC는 의미없음)
        FROM  ga
       WHERE  1=1
         AND  user_pseudo_id  = 'S3WDQCqLpK'
    )
    ,
  real_startpoint_CTE AS
    (
      SELECT  *
            , CASE WHEN LAG(event_timestamp_kst) OVER (ORDER BY rownum) <= stnd  -- 이전 마지막 행동이 지금 행동 기준 1시간 보다 더 이전이면 1 : 즉 진짜 session_start
                        THEN 1 
                        ELSE 0
                        END AS real_start_yn
        FROM  onehour_added_CTE
    )

-- 실패한 것. 같은 세션id내에서 1이 합으로 나오지 않을 경우 이전 id를 불러와야 하는데 
-- 0이면서 session_start인, 즉 가짜 start에 대해서는 변경이 되지만 그 그룹에 대해서 전부 바뀌진 않음
SELECT   event_timestamp_kst
      , ga_session_id
      , event_name
      , real_start_yn
      , CASE WHEN SUM(real_start_yn) OVER (PARTITION BY ga_session_id) = 0   -- 해당 세션 그룹에 sum이 0일 경우 이전 세션id로 변경되도록함
             THEN LAG(ga_session_id) OVER (ORDER BY rownum)   
             ELSE ga_session_id 
             END AS ga_session_id
  FROM  real_startpoint_CTE
-- real_start_yn기준으로 하나의 그룹을 만들 수는 없을까...
