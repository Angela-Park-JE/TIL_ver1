"""
서울에 위치한 식당 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131118
REST_INFO와 REST_REVIEW 테이블에서 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL문을 작성해주세요. 
이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 결과는 평균점수를 기준으로 내림차순 정렬해주시고, 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 왜인지 모르겠는데 '서울'로 시작하는 것으로만 검색이 제대로 되는 것으로 나타났다. 서울로 시작해야만 하는게 맞긴 하지...
    지역 명에 무슨시 서울방구하기힘들어동 123번지 메가서울타워 이런 나쁜 지명이 있을 수 있지. 암암.
    TEL 넘버로는 4곳 중 3곳이 검색안되는 것도... 현실 반영이 참 잘된 문제인 것 같다. -*/ 
    -- -> TEL 의 경우 02가 아니라 010 식으로 개인 휴대폰 번호인 곳이 많아서임.

--MySQL
SELECT i.rest_id, i.rest_name, i.food_type, i.favorites, i.address, ROUND(AVG(r.review_score), 2) SCORE
FROM REST_INFO i RIGHT JOIN REST_REVIEW r ON i.rest_id = r.rest_id
WHERE i.address like "서울%"      -- DON'T DO LIKE -> WHERE INSTR(i.address, '서울') > 0 OR LEFT(i.tel, 2) = 02
GROUP BY i.rest_id
ORDER BY 6 DESC, 4 DESC;



-- 복습
-- 231006: LIKE 를 까먹었었나보다. 그건 그런데, '%서울%'은 안되고 '서울%'이 정답인 이유는 뭘까?
-- 일단 '%서울특별시%' 는 서울시로 주소가 적혀있는 식당들도 있어서 안된다.
-- 위에 방법에 적은 것처럼 WHERE INSTR(i.address, '서울') > 0 도 안된다. 이게 안되는 이유는 뭘까.
-- 찾아보니 WHERE로 찾은 방법은 '%서울%'과 같은 결과를 반환하게 된다고 한다. 
-- 그럼 결국 "서울(특별)시 외에 서울이 들어가는 지명이 또 존재한다"는 가설이 맞게 된다.
SELECT info.rest_id, info.rest_name, info.food_type, 
       info.favorites, info.address, ROUND(AVG(rev.review_score), 2) scores
FROM REST_INFO info RIGHT JOIN REST_REVIEW rev ON info.rest_id = rev.rest_id
WHERE info.address LIKE '%서울%'
GROUP BY info.rest_id
ORDER BY 6 DESC, 4 DESC;
