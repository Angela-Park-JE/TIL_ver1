/*-
1661. Average Time of Process per Machine
https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50
      There is a factory website that has several machines each running the same number of processes. 
      Write a solution to find the average time each machine takes to complete a process.
      The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
      The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
      The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
      Return the result table in any order.
      Table: Activity
      +----------------+---------+
      | Column Name    | Type    |
      +----------------+---------+
      | machine_id     | int     |
      | process_id     | int     |
      | activity_type  | enum    |
      | timestamp      | float   |
      +----------------+---------+
-*/


-- 240814: 기계 별 프로세스 별 runtime을 구한 다음 기계 별로 평균 프로세스 runtime을 구해야 한다.
-- 서브쿼리를 쓰게 되었지만 더 줄이는 방법은 없을까 고민해보았지만 떠오르지 않았다. 
SELECT  machine_id
      , ROUND(AVG(ts), 3) AS processing_time
  FROM (
        SELECT  machine_id
              , process_id
              , MAX(timestamp) - MIN(timestamp) ts
          FROM  ACTIVITY 
         GROUP  BY machine_id, process_id
        ) tmp
 GROUP  BY 1


/*- 다른 풀이 -*/
-- lancexie: start와 end를 각각 a, b 테이블에 두고 머신과 프로세스 아이디를 일치시킨 다음 구하는 방식이다.
-- 생각하지 못했던 부분인데 JOIN을 써야하는 문제 의도 상 좋은 방법 같다고 생각한다.
select a.machine_id, round(avg(b.timestamp - a.timestamp), 3) as processing_time 
from activity a join activity b
on a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end'
group by 1;
