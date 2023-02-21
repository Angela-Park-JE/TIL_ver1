"""
즐겨찾기가 가장 많은 식당 정보 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131123

Column name	Type	Nullable
REST_ID	VARCHAR(5)	FALSE
REST_NAME	VARCHAR(50)	FALSE
FOOD_TYPE	VARCHAR(20)	TRUE
VIEWS	NUMBER	TRUE
FAVORITES	NUMBER	TRUE
PARKING_LOT	VARCHAR(1)	TRUE
ADDRESS	VARCHAR(100)	TRUE
TEL	VARCHAR(100)	TRUE

REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 
이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 처음에는 MAX값을 WHERE 절에서 =로 찾을 까 했는데 값을 정확히 rest_id 와 일치시켜야 레스토랑은 다른데 좋아요수가 같을 경우를 대비할 수 있다. 
    그래서 타입별 맥스값을 갖는 서브쿼리를 FROM 절에서 사용했다.
    어느 분 질문에 답변 올렸는데 좋은 답변이라는 칭찬받아서 기뻤음 ㅠㅠ -*/

-- MySQL
-- 정답1
SELECT r.food_type, r.rest_id, r.rest_name, r.favorites
FROM REST_INFO r, (SELECT food_type, MAX(favorites) maxv FROM REST_INFO GROUP BY food_type) tmp
WHERE r.food_type = tmp.food_type 
  AND r.favorites = tmp.maxv
ORDER BY 1 DESC;

-- 정답 2
SELECT FOOD_TYPE
     , CASE WHEN MAX(FAVORITES) = FAVORITES THEN REST_ID END AS REST_ID
     , CASE WHEN MAX(FAVORITES) = FAVORITES THEN REST_NAME END AS REST_NAME
     , CASE WHEN MAX(FAVORITES) = FAVORITES AND FOOD_TYPE = FOOD_TYPE THEN FAVORITES END AS FAVORITE
FROM REST_INFO
GROUP BY FOOD_TYPE
ORDER BY FAVORITES DESC


-- 간단하게 그룹별 맥스의 값들을 리스트화해서 같은 애들을 뽑으려하면 문제가 생긴다.
-- 일식이 나오지 않게된다. 왜? 다른 푸드 타입의 favorites와 같은 수를 가진게 맥스라서.
SELECT r.food_type, r.rest_id, r.rest_name, r.favorites
FROM REST_INFO r, (SELECT DISTINCT food_type FROM REST_INFO) t
WHERE t.food_type = r.food_type
GROUP BY food_type
HAVING MAX(favorites) = favorites
ORDER BY 1 DESC;
-- 같은 favorites를 가진 문제의 음식점들
SELECT food_type, rest_id, rest_name, favorites
FROM REST_INFO
WHERE favorites = 230
-- GROUP BY food_type
-- HAVING MAX(favorites) = favorites 
ORDER BY 1 DESC;
