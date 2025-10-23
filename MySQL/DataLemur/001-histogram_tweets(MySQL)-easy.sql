/*
# Histogram of Tweets
Twitter SQL Interview Question
https://datalemur.com/questions/sql-histogram-tweets
*/


-- 251023: 조건 걸고, 거기서 유저별 count 한 뒤, 그 count별로 user를 셌다. 어려울 것 없었다는!
SELECT  tw_cnt AS tweet_bucket
      , COUNT(user_id) AS users_num
  FROM  
        (
          SELECT  user_id
                , COUNT(tweet_id) as tw_cnt
            FROM   
                  (
                  SELECT  * 
                    FROM  tweets
                   WHERE  YEAR(tweet_date) = 2022
                  )  2022tbl
           GROUP  BY user_id
        )  cntgrp
 GROUP  BY tw_cnt
 ORDER  BY 1
;
