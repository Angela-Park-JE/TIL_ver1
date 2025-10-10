/*
언더바를 포함하지 않는 조건
https://solvesql.com/problems/data-without-underscore/
*/


--241205: 그러고보니 REGEXP의 부정문은 몰랐는데 NOT을 쓰면 되는 것이었다. 간단!
SELECT  DISTINCT page_location
  FROM  ga
 WHERE  page_location NOT REGEXP '[_]'
 ORDER  BY 1
;
