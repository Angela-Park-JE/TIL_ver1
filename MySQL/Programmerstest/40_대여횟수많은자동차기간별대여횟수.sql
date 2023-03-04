"""
대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/151139?language=mysql
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 
해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
"""


/*- mine : 복잡한 방법밖에 생각나지 않았다. 그룹바이 계층을 다르게 해야하는 점 때문에 WHERE절에 조건을 검색할 서브쿼리를 썼는데 좀 더 간단하게도 가능할 것 같다. -*/

-- MySQL
SELECT MONTH(start_date), car_id, COUNT(*) records
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE start_date BETWEEN '2022-08-00' AND '2022-11-00'
  AND car_id IN 
    (
    SELECT car_id
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE start_date BETWEEN '2022-08-00' AND '2022-11-00'
    GROUP BY car_id HAVING COUNT(history_id) >= 5
    )
GROUP BY MONTH(start_date), car_id
HAVING COUNT(*) IS NOT NULL
ORDER BY 1, 2 DESC;


-- 다른 사람들 도와주면서 본 건데, 바깥 WHERE 절에서 WHERE start_date BETWEEN '2022-08-00' AND '2022-11-00' 이것을 안한 사람들이 정말 많더라
