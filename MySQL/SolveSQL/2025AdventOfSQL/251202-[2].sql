/*
놀러가기 좋은 날(미세먼지)
https://solvesql.com/problems/good-days-for-a-seoulforest-picnic/
*/


-- 251202: 어려울 것이 없는 문제였다보니 올해 문제가 기대된다!
SELECT  measured_at AS good_day
  FROM  measurements 
 WHERE  1=1
   AND  EXTRACT(YEAR_MONTH FROM measured_at) = '202212'  -- 기간 조건
   AND  pm2_5 <= 9  -- 농도 조건
; 
