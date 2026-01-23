/*
쇼핑몰의 온라인 주문에 대해 배송 형태 집계하기
https://solvesql.com/problems/yearly-shipping-usage/
*/


-- 260123: 좋은 문제다. 2단치고 함정이 많아! (데이터를 먼저 살펴보지 않은 바보)
WITH  unioned_about_returned         -- 반품의 경우를 'Standard' 로 하여 추가 레코드를 만든 서브쿼리
  AS 
    (
        SELECT  transaction_id
              , purchased_at
              , shipping_method
          FROM  transactions
         WHERE  is_online_order = 1    -- 온라인 거래 한정
         UNION  ALL                    -- UNION ALL로 중복으로 추가
        SELECT  transaction_id
              , purchased_at
              , 'Standard' AS shipping_method
          FROM  transactions
         WHERE  is_online_order = 1
           AND  is_returned = 1        -- 반품건 한정으로 standard 배송 추가
    )

SELECT  YEAR(purchased_at) AS year
      , SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END) AS standard      -- CASE WHEN과 SUM을 동시이용한 피벗
      , SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express
      , SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
  FROM  unioned_about_returned
 GROUP  BY 1
 ORDER  BY 1
;



/*오답노트*/
우선 거래 id가 반품건도 같이 있는지 확인
SELECT  transaction_id
      , COUNT(*)
  FROM  transactions
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 100
;

-- 반품건에 대해 추가 집계를 위해 방법은 두 가지이다
-- 'is_returned = 1' 일 경우에 대해 해당 레코드를 집계시 standard를 1을 추가하게 할 건지
-- 'is_returned = 1' 인 경우만 따로 집계하여 이들의 배송을 standard로 바꾸고 UNION을 사용하여 한 테이블로 합친 뒤 전체를 집계할 건지
-- 후자가 더 간단해 보여서 그렇게 하기로 함
WITH  unioned_about_returned   -- 반품의 경우를 'Standard' 로 하여 추가 레코드를 만든 서브쿼리
  AS 
    (
        SELECT  transaction_id
              , purchased_at
              , shipping_method
          FROM  transactions
         UNION
        SELECT  transaction_id
              , purchased_at
              , 'Standard' AS shipping_method
          FROM  transactions
         WHERE  is_returned = 1
    )

SELECT  YEAR(purchased_at) AS year
      , SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END) AS standard
      , SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express
      , SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
  FROM  unioned_about_returned
 GROUP  BY 1
 ORDER  BY 1
;

-- Standard 값이 거의 두배 가까이 많다. 위는 바보같이 오프라인 판매까지 넣은 문제가 있었다. 이는 온라인 판매내역만 있는 것이 아니다! 
-- 지금 보니 모든 shipping_method 가 아예 비어있는 경우는 오프라인 판매이므로 제외를 해야하며
-- CTE 만들 때 'is_returned = 1'했던 부분은 shipping_method가 비어있을 경우도 함께 해야한다.
  SELECT  transaction_id
        , purchased_at
        , shipping_method
        , is_returned
        , store_id
    FROM  transactions
   LIMIT  100;
;

-- 다시쓴 것!
WITH  unioned_about_returned   -- 반품의 경우를 'Standard' 로 하여 추가 레코드를 만든 서브쿼리
  AS 
    (
        SELECT  transaction_id
              , purchased_at
              , shipping_method
          FROM  transactions
         WHERE  store_id IS NULL
         UNION
        SELECT  transaction_id
              , purchased_at
              , 'Standard' AS shipping_method
          FROM  transactions
         WHERE  store_id IS NULL
           AND  is_returned = 1
    )

SELECT  YEAR(purchased_at) AS year
      , SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END) AS standard
      , SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express
      , SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
  FROM  unioned_about_returned
 GROUP  BY 1
 ORDER  BY 1
;

-- 그러나 이번엔 Standard 값이 100이나 적다. 그리고 'store_id IS NULL' 대신 'is_online_order = 1' 이걸로 바꾸어도 값은 같다. (서로 반대)
-- 그렇다면 
  SELECT  transaction_id
        , purchased_at
        , shipping_method
        , is_returned
        -- , store_id
        -- , is_online_order
        , 'Standard' AS shipping_method
    FROM  transactions
   WHERE  is_online_order = 1
   ORDER BY is_returned DESC
   LIMIT  100;
;

-- 네 발견했죠 바보였구연 UNION은 자동으로 중복을 제거해주는 기능이 있지요? 에구야 저런 아무튼 어렵지 않게 해결~
WITH  unioned_about_returned   -- 반품의 경우를 'Standard' 로 하여 추가 레코드를 만든 서브쿼리
  AS 
    (
        SELECT  transaction_id
              , purchased_at
              , shipping_method
          FROM  transactions
         WHERE  is_online_order = 1
         UNION  ALL
        SELECT  transaction_id
              , purchased_at
              , 'Standard' AS shipping_method
          FROM  transactions
         WHERE  is_online_order = 1
           AND  is_returned = 1
    )

SELECT  YEAR(purchased_at) AS year
      , SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END) AS standard
      , SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express
      , SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
  FROM  unioned_about_returned
 GROUP  BY 1
 ORDER  BY 1
;
