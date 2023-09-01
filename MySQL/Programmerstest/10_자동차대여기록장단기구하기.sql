"""
자동차 대여 기록에서 장기/단기 대여 구분하기
https://school.programmers.co.kr/learn/courses/30/lessons/151138
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서 
대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요. 
결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
"""


/*- mine : 왜이러실까 했는데, DATE_DIFF가 >=30 이 아니라 >=29였어야 했다. 빌린 날짜부터 1로 치기 때문 아닐까 생각한다. -*/

-- MySQL
SELECT history_id, car_id, 
        DATE_FORMAT(start_date, '%Y-%m-%d') start_date, DATE_FORMAT(end_date, '%Y-%m-%d') end_date,
        CASE WHEN DATEDIFF(end_date, start_date) >= 29 THEN '장기 대여'
             ELSE '단기 대여' END rent_type
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE EXTRACT(YEAR_MONTH FROM start_date) = '202209'
ORDER BY history_id DESC;



-- 복습
-- 230901: 이전에 한것과 같다. 다만 여기서는 대여일 기준에 +1을 더하여 정확하게 표현을 했고 이전 것은 하루가 0으로 표현되는 것을 감안하여 29로 계산하였다.
SELECT history_id, car_id, DATE_FORMAT(start_date, '%Y-%m-%d'), DATE_FORMAT(end_date, '%Y-%m-%d'), 
       CASE WHEN (DATEDIFF(end_date, start_date)+1) >= 30 THEN '장기 대여' ELSE '단기 대여' END AS rent_type
  FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
 WHERE EXTRACT(YEAR_MONTH FROM start_date) = 202209
 GROUP BY history_id
 ORDER BY 1 DESC;
