"""
자동차 평균 대여 기간 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/157342
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 평균 대여 기간이 7일 이상인 자동차들의 자동차 ID와 평균 대여 기간(컬럼명: AVERAGE_DURATION) 리스트를 출력하는 SQL문을 작성해주세요. 
평균 대여 기간은 소수점 두번째 자리에서 반올림하고, 결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고, 평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.
"""

/*- mine : 처음 문제를 읽으면서는 WINDOW 함수를 쓸 생각을 했다가 평균 대여 기간을 구하면서 자연스럽게 HAVING 으로 해결이 되었다.
    다만 한가지, 대여기간은 DATEDIFF로 구했을 떄 + 1일이 된다. 당일만 빌렸어도 하루 빌린 것으로 되기 때문이다. datetiff가 30일이더라도 대여를 시작한 날짜 자체가 포함된다. 
    그래서 이런 문제를 풀 때 주의할 점이 바로 그것. 4분 걸릴 것 1분 더 걸린 이유 ㅠ-*/

-- MySQL
SELECT car_id, ROUND(AVG(DATEDIFF(end_date, start_date) + 1), 1) AVERAGE_DURATION
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY car_id
HAVING AVERAGE_DURATION >= 7
ORDER BY 2 DESC, 1 DESC;



-- 복습
-- 230909: DATEDIFF 를 DATE_DIFF로 적어서 왜 안되지 하고 있었었다는, 그 외의 것들은 이전에 한 것과 같다.
SELECT car_id, ROUND(AVG(DATEDIFF(end_date, start_date)+1), 1) AS AVERAGE_DURATION
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY car_id
HAVING AVERAGE_DURATION >= 7
ORDER BY 2 DESC, 1 DESC;
