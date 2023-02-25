"""
자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기
https://school.programmers.co.kr/learn/courses/30/lessons/157340
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 
대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 
이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
"""

/*- mine : 조금 헤맸었다. 간단히 생각했을때, car_id 별 결과를 내야하는데 결과가 숫자가 아닌 형태로 된다. 이 부분을 1과 0으로 대체해서 했다. 
    car_id 별로 가장 최근 건수(history_id)로 검색하는 것도 생각해봤으나, 10-16 뒤의 예약건수가 있는 경우는 제대로 잡히지 않을 수 있다.
    MAX를 날짜에 쓰는것으로는 혼동될 수 있다. 
    그래서 가장 좋은 방법으로 우선 대여중인 결과 로우가 있으면 대여중인게 맞으므로 1로, 그외에는 0으로 출력되게 해두고,
    그 컬럼의 max값을 조건문으로 써서 결과로 대여중과 대여가능을 표기하도록 서브쿼리를 만들었다. -*/
    
-- MySQL
SELECT car_id, CASE WHEN MAX(availability) = 1 THEN '대여중' ELSE '대여 가능' END availability
FROM 
    (
    SELECT car_id, start_date, end_date,
        CASE WHEN '2022-10-16' BETWEEN start_date AND end_date 
             THEN 1 ELSE 0 
              END availability
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    ) tmp
GROUP BY car_id
ORDER BY 1 DESC;



"""다른 풀이"""

-- 훨씬 똑똑한 방법. CASE WHEN을 한 번만 썼다. 해당날짜가 사이에 있는 car_id는 대여중이고, 그렇지 않은 차는 대여가능이도록!
-- https://school.programmers.co.kr/questions/44463
SELECT DISTINCT CAR_ID,
    CASE 
        WHEN CAR_ID IN (
            SELECT CAR_ID 
            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
            WHERE DATE('2022-10-16') BETWEEN START_DATE AND END_DATE
        ) THEN '대여중'
        ELSE '대여 가능'
    END `AVAILABILITY`
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
ORDER BY 1 DESC;

-- 그래서 다른분 질문 올린것 답 달면서 수정해드린 것이 아래이다. 바로 위와 같은 방식으로(IN 사용) 해결했다. (소문자로 첨삭함)
-- https://school.programmers.co.kr/questions/44581
SELECT distinct CAR_ID,
    CASE WHEN 
        car_id in 
        (
        select car_id from car_rental_company_rental_history 
        where '2022-10-16' BETWEEN TO_CHAR(START_DATE,'YYYY-MM-DD') AND TO_CHAR(END_DATE,'YYYY-MM-DD') 
        )
        THEN '대여중'
        ELSE '대여 가능'
        END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
ORDER BY CAR_ID DESC;
