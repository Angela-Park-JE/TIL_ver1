"""
조건에 맞는 사용자 정보 조회하기 (/164670 문제와 제목 바뀜;;)
https://school.programmers.co.kr/learn/courses/30/lessons/164668
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 
결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
"""

-- 230314
/*- mine : WHERE에서 조건을 걸었다. 복잡할 것 없는 문제. 
    쓰는 스타일에 대한 생각을 하고있다. 
    개인적으로 오름차순 내림차순은 ASC, DESC 써주는게 나중에 긴 쿼리에서 더 직관적으로 보기 편한 것 같고 정리되어 보여서 선호하는데, 다들 오름차순은 안쓰더라. 
    쿼리 글자수를 줄이는게 많이 중요한 때가 오면 없애야지 싶다. 
    그리고 함수와 테이블 자체 이름은 대문자로 쓰는 편인데 아예 대문자나 아예 소문자로 쓰는게 편한가도 싶고. -*/
    
-- MySQL
SELECT b.writer_id, u.nickname, SUM(b.price) AS total_sales
  FROM USED_GOODS_BOARD b, USED_GOODS_USER u
 WHERE b.writer_id = u.user_id
   AND b.status = 'DONE'
 GROUP BY b.writer_id
HAVING SUM(b.price) >= 700000   -- HAVING total_sales >= 700000 도 가능하다. 
 ORDER BY 3 ASC;



-- 복습

-- 230812: 3분 걸렸나? 지금보니 확실히 SQL스러운 사고방식이 둔화된 것 같다. HAVING을 잘 안쓰네.
-- 하지만 기본적으로 구조는 깔끔하게 잘 되었다고 생각...
SELECT *
FROM (
    SELECT u.user_id, u.nickname, SUM(b.price) total
      FROM USED_GOODS_USER u LEFT JOIN USED_GOODS_BOARD b ON u.user_id = b.writer_id
     WHERE b.status = 'DONE'
     GROUP BY u.user_id
    ) tmp
WHERE total>=700000
ORDER BY 3 ASC


    
-- 231226: 금방 했다. 처음에 풀었던 방식과 거의 흡사하다. WHERE 조인을 사용했다.
SELECT g.writer_id, u.nickname, SUM(g.price)
  FROM USED_GOODS_BOARD g, USED_GOODS_USER u
 WHERE g.writer_id = u.user_id
   AND g.status = 'DONE'
 GROUP BY g.writer_id
HAVING SUM(g.price) >= 700000
 ORDER BY 3 ASC;
