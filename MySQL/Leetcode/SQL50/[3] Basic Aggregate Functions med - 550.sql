/*
550. Game Play Analysis IV
https://leetcode.com/problems/game-play-analysis-iv/?envType=study-plan-v2&envId=top-sql-50
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
  Table: Activity
  +--------------+---------+
  | Column Name  | Type    |
  +--------------+---------+
  | player_id    | int     |
  | device_id    | int     |
  | event_date   | date    |
  | games_played | int     |
  +--------------+---------+
  (player_id, event_date) is the primary key
*/


-- 241022:
