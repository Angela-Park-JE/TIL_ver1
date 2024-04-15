/* 한 값을 조회해야 하나 여러 컬럼에 값이 나누어져 있을 때 
   여러 컬럼들을 하나로 묶은 다음 거기서 값을 검색할 수 있다. */

-- 주 재료에 양파가 들어간 메뉴를 찾는다고 해보자.
SELECT  id
      , menu
      , price
      , restaurant
  FROM  MENU_LIST
 WHERE  CONCAT_WS(', ', ingre1, ingre2, ingre13) REGEXP 'onion'
 ORDER  BY 3

-- 원래 찾는다면 이렇게 찾을 수 있다.
SELECT  id
      , menu
      , price
      , restaurant
  FROM  MENU_LIST
 WHERE  ingre1 = 'onion' OR ingre2 = 'onion' OR ingre13 = 'onion'
 ORDER  BY 3;
