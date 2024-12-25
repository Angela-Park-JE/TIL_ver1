/*
메이저 플랫폼에서 출시된 게임 중 메이저 플랫폼 두 가지 이상의 출시인 2012년도 이후 출시된 게임
https://solvesql.com/problems/multiplatform-games/
*/


-- 241225: solvesql의 SQL 포맷팅 기능을 잘못 눌렀더니 이전 것으로 못돌아가는 문제가 ㅠㅠ
-- 아무튼 group by를 활용을 하려고 하면서 어떻게 CASE WHEN과 묶을 수 있을까했다.
-- 처음엔 1을 넣고 0을 넣어서 SUM(majors)가 2 이상이면-인 것으로 했다가, 생각해보니 PS3, PS4이렇게 출시되어도 SUM이 2이상이 될 것이었다.
-- 그래서 그냥 바꿔서 GROUP_CONCAT으로 문자열 합친 다음에 문자열 길이로 셌음. 
-- 나름 색다른 방법을 쓴 것 같지만 CASE WHEN을 걸어야할 것이 많아질 경우 효용성이 현저히 낮아진다. 
SELECT
  name
FROM
  (
    SELECT
      g.name,
      CASE
        WHEN p.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
        WHEN p.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
        WHEN p.name IN ('X360', 'XONE') THEN 'Microsoft'
        ELSE '0'
      END majors
    FROM
      games g
      LEFT JOIN platforms p ON g.platform_id = p.platform_id
    WHERE
      g.year >= 2012
  ) gameswithcount
WHERE
  majors != '0' -- 메이저 플랫폼 출시 아닌 건수 뺸 다음 GROUP_CONCAT 했을 때 가장 짧은 길이(다행히 가장 긴 길이보다 김)끼리의 합보다 길면 ok

GROUP BY
  name
HAVING
  CHAR_LENGTH(GROUP_CONCAT(DISTINCT majors)) > 12
;
