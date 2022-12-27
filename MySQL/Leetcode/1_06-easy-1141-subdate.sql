"""
1141. User Activity for the Past 30 Days I
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan&id=sql-i
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.

Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
A user was active on someday if they made at least one activity on that day.
Return the result table in any order.

Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Explanation: Note that we do not care about days with zero active users.
"""


/*- mine : 해당 날짜를 포함 하는가 아닌가에서 문제가 생긴다. SUBDATE를 쓴 부분은 0627을 포함하지 않게 되고, 
    지정된 0727 조건 부분은 해당 날짜가 포함되도록 계산된다. 
    상당히 느린 것으로 나타났다.-*/
-- MySQL
SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM ACTIVITY
WHERE activity_date > SUBDATE('2019-07-27', 30) 
  AND '2019-07-27' >= activity_date
GROUP BY activity_date;



"""다른 풀이"""
-- MySQL by.anisg1976 : DATEDIFF라는 좋은 방법이 있었다. 기간 자체를 조건으로 주고 그 안에 있기만 하면 되는 것이다.
select activity_date as day, count(distinct user_id) as active_users 
from Activity
where datediff('2019-07-27', activity_date) <30
group by activity_date;
