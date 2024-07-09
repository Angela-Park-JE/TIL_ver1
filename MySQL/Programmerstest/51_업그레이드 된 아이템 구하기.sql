/*-
코딩테스트 연습> SELECT> 업그레이드 된 아이템 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/273711
  아이템의 희귀도가 'RARE'인 아이템들의 모든 다음 
  업그레이드 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
  이때 결과는 아이템 ID를 기준으로 내림차순 정렬주세요.
-*/


-- 240415: root아이템을 출력하는게 아니라 상위 아이템을 출력하라고
SELECT  DISTINCT i.item_id, i.item_name, i.rarity
  FROM  
        (
        SELECT  item_id  
          FROM  ITEM_TREE 
         WHERE  parent_item_id IN (SELECT item_id FROM ITEM_INFO WHERE rarity = 'RARE') 
        ) AS t
        LEFT JOIN  ITEM_INFO i
               ON  i.item_id = t.item_id
 ORDER  BY 1 DESC;



/*-오답노트-*/
-- 240415: 이건 rare템의 부모(하위, root) 아이템을 출력하는 쿼리이다
SELECT  DISTINCT i.item_id, i.item_name, i.rarity
  FROM  ITEM_INFO AS i
        LEFT JOIN (
                    SELECT  parent_item_id  
                      FROM  ITEM_TREE 
                     WHERE  item_id IN (SELECT item_id FROM ITEM_INFO WHERE rarity = 'RARE') 
                    ) AS t 
        ON i.item_id = t.parent_item_id
 ORDER  BY 1 DESC;
