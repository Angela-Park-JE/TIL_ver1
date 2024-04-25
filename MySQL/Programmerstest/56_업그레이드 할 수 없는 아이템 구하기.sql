"""
코딩테스트 연습> IS NULL> 업그레이드 할 수 없는 아이템 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/273712
  더 이상 업그레이드할 수 없는 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
  이때 결과는 아이템 ID를 기준으로 내림차순 정렬해 주세요.
"""



-- 240425 : parent_id가 되지 않는 item을 찾아라!
SELECT  i.item_id AS item_id
      , item_name
      , rarity
  FROM  ITEM_INFO i
        LEFT JOIN ITEM_TREE t ON i.item_id = t.parent_item_id 
            -- t.item_id이 상위템으로, t.item_id의 있냐 없냐 여부로 상위템이 있냐 없냐를 따질 수 있다.
            -- parent가 즉 하위가 되는거라 의미적으로 생각하다보면 사고하는데 좀 헷갈릴 수 있다.
 WHERE  t.item_id IS NULL
 ORDER  BY  1 DESC;
  
