/*
게임사들의 주력 플랫폼 알아보기
https://solvesql.com/problems/main-platform-of-game-developers/
*/


-- 241216: 한 번 제출에 바로 정답하고 싶어서 30분 좀 안되게 노력했는데 예쁘게 잘 되었다 (음주주의)
-- 먼저 게임사들의 플랫폼 별 총 매출과 총 매출이 높은 순으로 누적 rank를 구하는 WITH 서브쿼리를 만들어둔다.
-- 또한 게임사의 id가 null인 경우는 미리 여기서 제외한다(게임사 별 주력 플랫폼을 알아보는 것이 목적이므로 의미가 없음)
-- 메인 쿼리에서 누적 rank가 1인 건들에 한해 데이터를 데려오면서 id와 name을 매칭시키면 완성
WITH platform_sales_by_dev AS 
    (
        SELECT  developer_id
              , platform_id
              , SUM(sales_na + sales_eu + sales_jp + sales_other) AS sales 
              -- DENSE_RANK 사용하여 공동 최고 세일즈 플랫폼 함께 출력
              , DENSE_RANK() OVER (PARTITION BY developer_id ORDER BY SUM(sales_na + sales_eu + sales_jp + sales_other) DESC) AS platform_rank  
          FROM  games
              -- 게임사가 null인 경우 제외
         WHERE  developer_id IS NOT NULL  
         GROUP  BY developer_id, platform_id
    )  -- 게임사의 플랫폼 별 total_sales 및 매출 rank

SELECT  c.name AS developer
      , p.name AS platform
      , ps.sales
  FROM  platform_sales_by_dev ps
      , platforms p
      , companies c
 WHERE  ps.platform_id = p.platform_id AND ps.developer_id = c.company_id  -- join condition
   AND  platform_rank = 1
;
