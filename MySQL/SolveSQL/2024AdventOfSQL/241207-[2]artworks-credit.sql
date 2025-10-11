/*
소장품 중 부분 기증품을 포함한 기증품의 비율이 어떻게 되는지
https://solvesql.com/problems/ratio-of-gifts/
데이터에 대한 이해 + 문제에 대한 이해가 부족했음 + 문자열은 대소문자가 있다는 것...
*/


-- 250123: 문제는 의외로 간단했다. 'gift'를 대문자가 포함되어있는 경우가 있는 것이었다.
-- `credit LIKE '%gift%'` 이게 아니라 `LOWER(credit) REGEXP 'gift'` 이게 필요했던것.
-- 즉 복잡하게 개별 artwork를 구분짓는 것에 대해 고심할 필요 없이 모든 소장품은 artwork_id 개별로 취급되며, 
-- gift(Gift, GIft, GIFT, gifT ...) 가 들어가는 소장품에 대해서 세는 것이 정답.
SELECT  ROUND((SELECT COUNT(artwork_id) FROM artworks WHERE LOWER(credit) LIKE '%gift%') / COUNT(artwork_id) * 100, 3) AS ratio
  FROM  artworks
;



/*오답노트*/

-- 241207: 처음에 했던 답. 8% 대가 나오는데 알고보니 부분 기증품을 포함한다고 한다. 
-- 데이터를 뜯어보니 부분 기증품이 상당히 여러개 겹치기 때문에 숫자가 많이 차이날 수 밖에 없다.
-- object number 로 바꾸어서 해도 같은 답이 나온다. 
SELECT  ROUND(COUNT(artwork_id)/ (SELECT COUNT(*) FROM artworks)* 100, 3) AS ratio
  FROM  artworks
 WHERE  credit LIKE '%gift%'
;

-- 241207: 오래 돌아간다. 0이 나오는데 0을 나누는 문제가 혹시 있나? 
-- title과 object_number
SELECT  ROUND(COUNT(DISTINCT title)/ (SELECT COUNT(DISTINCT title) FROM artworks)* 100, 3) AS ratio
  FROM  artworks
 WHERE  credit LIKE '%gift%'
;
-- 마찬가지로 오래 돌아간다. 부분 기증품을 포함한다는 뜻이 하나의 작품을 만드는 여러 부분 기증품을 다 합하여 하나로 본다는 게 아닌가?
SELECT  ROUND(COUNT(DISTINCT title, object_number)/ (SELECT COUNT(DISTINCT title, object_number) FROM artworks)* 100, 3) AS ratio
  FROM  artworks
 WHERE  credit LIKE '%gift%'
;

-- 250120: 부분작품을 포함한 작품 별로 먼저 테이블을 만들어 세는 방식은 어떨까...
SELECT  object_number
      , credit
  FROM  artworks
 GROUP  BY object_number

-- 250123: 다시 짜보았다. 기증품을 포함한 소장품에 대해서 기증품으로 간주하고, 전체 소장품에 대해 비율을 구한다. 그러나 마찬가지로 오래 돌아가다가 나온 답은 1이었다.
-- WHERE절에 조건에 맞는 대상에 대해 GROUP BY 되었으면 그럴리 없는데라고 생각했다... 기증품이 있는 소장품만 포함이 될테니까... 기증품이 없는 소장품은 all_table에서 집계가 될 것이고...
-- SUBSTRING_INDEX를 쓰는 대신 object_number를 쓰더라도 오래돌아간다. 
WITH 
  gift_table AS 
  (
  SELECT  SUBSTRING_INDEX(object_number, '.', 2) object_number_cliped
    FROM  artworks
   WHERE  credit LIKE '%gift%'
   GROUP  BY  SUBSTRING_INDEX(object_number, '.', 2)
  )

, all_table AS
  (
  SELECT  SUBSTRING_INDEX(object_number, '.', 2) object_number_cliped
    FROM  artworks
   GROUP  BY  SUBSTRING_INDEX(object_number, '.', 2)
  )

SELECT  COUNT(gift_table.object_number_cliped)/COUNT(all_table.object_number_cliped)
  FROM  gift_table, all_table
;

-- 250123: 이렇게 하면 안되는 것 아닌가? 힌트를 찾으러 찾아보다 다시 짜본 것인데 이것도 정답이 아니다. 
-- artwork_id가 gift인 것이 포함된 artwork에 대해 모든 artwork_id가 같이 서브쿼리 안 데이터로 취급되어야 하는데 안되는 쿼리이다. 
SELECT  ROUND(
              (
                  SELECT  COUNT(DISTINCT artwork_id)
                    FROM  artworks
                   WHERE  credit LIKE '%gift%'
              )
              / COUNT(DISTINCT artwork_id)*100
              , 3) AS ratio
  FROM  artworks
;
