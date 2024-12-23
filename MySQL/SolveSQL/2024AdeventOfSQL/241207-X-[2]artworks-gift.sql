/*
소장품 중 부분 기증품을 포함한 기증품의 비율이 어떻게 되는지
https://solvesql.com/problems/ratio-of-gifts/
데이터에 대한 이해 + 문제에 대한 이해가 부족했음
데이터에 대한 설명이 좀 더 있었더라면... 
*/


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
