/*-
코딩테스트 연습> IS NULL> ROOT 아이템 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/273710
  ROOT 아이템을 찾아 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME)을 출력하는 SQL문을 작성해 주세요. 
  이때, 결과는 아이템 ID를 기준으로 오름차순 정렬해 주세요.
  단, 각 아이템들은 오직 하나의 PARENT 아이템 ID를 가지며, ROOT 아이템의 PARENT 아이템 ID는 NULL 입니다. ROOT 아이템이 없는 경우는 존재하지 않습니다.
-*/


-- 240423: 문제에서 해답을 준 케이스이다. ROOT 아이템을 찾으라고 하였고, 그들은 parent_item_id가 NULL이라고 했다.
SELECT  i.item_id
      , i.item_name
  FROM  ITEM_INFO i
        LEFT JOIN ITEM_TREE t ON i.item_id = t.item_id
 WHERE  t.parent_item_id IS NULL
 ORDER  BY 1;
