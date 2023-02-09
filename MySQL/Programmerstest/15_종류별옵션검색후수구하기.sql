"""
자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151137
CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
"""

/*- mine : 처음에는 LOCATE >0 으로 찾았다가, LIKE로 찾았다가, 더 좋은 방법은 없을까 해서 찾은게 REGEXP -*/

-- MySQL
-- 1
SELECT car_type, COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE LOCATE('통풍시트', options) > 0
   OR LOCATE('열선시트', options) > 0
   OR LOCATE('가죽시트', options) > 0
GROUP BY car_type
ORDER BY 1;

-- 2
SELECT car_type, COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE options LIKE '%통풍시트%'
   OR options LIKE '%열선시트%'
   OR options LIKE '%가죽시트%'
GROUP BY car_type
ORDER BY 1;

-- 3
SELECT car_type, COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE options REGEXP '통풍시트|열선시트|가죽시트'
GROUP BY car_type
ORDER BY 1;


"""잘못된 예"""

-- 옵션을 in 을 사용하여 찾는 것은 불가하다. 옵션은 여러 옵션들이 options라는 컬럼에 들어가있는 것인데 이것이 in () 과 일치하느냐는 물음은 잘못되었다.
-- 위의 예시들은 options 안에 해당 옵션이 있는지를 찾는 것이고, 아래 예시는 해당 옵션들이랑 같은 options가 있는지 묻는 것이다. 
-- 만약 옵션같은 것이 아닌 이름, 카테고리 처럼 하나로 정해진 것이었으면 할 수 있다.
-- https://school.programmers.co.kr/learn/courses/30/lessons/59046
SELECT car_type, COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE options in ('통풍시트','열선시트','가죽시트')
GROUP BY car_type
ORDER BY 1;
