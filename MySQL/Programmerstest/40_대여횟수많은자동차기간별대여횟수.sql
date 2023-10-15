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
 WHERE 1=1
   AND start_date BETWEEN '2022-08-00' AND '2022-11-00'
   AND car_id IN 
        (
        SELECT car_id
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE start_date BETWEEN '2022-08-00' AND '2022-11-00'
        GROUP BY car_id HAVING COUNT(history_id) >= 5
        )
 GROUP BY MONTH(start_date), car_id
 HAVING COUNT(*) != 0
 ORDER BY 1 ASC, 2 DESC;


-- 다른 사람들 도와주면서 본 건데, 바깥 WHERE 절에서 WHERE start_date BETWEEN '2022-08-00' AND '2022-11-00' 이것을 안한 사람들이 정말 많더라
-- 해당 조건을 걸지 않으면 8~10월이 아닌 월들에 대해서도 월별 결과를 집계하는 것이기 때문이다.


"""
중요 추가! (23.03.17) 
원래 이렇게 적고 주석처리를 해두었었음.
--  HAVING COUNT(*) != 0 -- 해당 조건은 사족임. 이미 대여 기록이 있는 것들을 기준으로 검색하기 때문에.! (사실 아님. 왜?)

그리고 다른 분께 답변을 달을 때에도 저렇게 알려드렸었음. 
그런데 어떤 분이 내 답의 저 부분이 '사족이 아니라 애초에 필요가 없는 부분'이라고 지적했음.(사실 조금 냉랭한 말투라 상처받을뻔) (23.03.06)
그러게, 안그래도 있으나 없으나 정답인 건 매한가지네? 나도 감사합니다! 하고 말았음. 
그리고 그 뒤로 며칠 간 다른 분들 답변 달며 도와드릴 때 저 부분을 따로 지적하지 않았음. (우직하게, 적은 분들도 계시긴 했음.)

오늘 와서 다른 분 질문에 힌트 달려고 문제 다시 보면서 생각해보니 무조건 있어야 하는 조건이 맞는 것임. 
--> 왜냐하면 8, 9, 10월 총 합쳐서 5회 이상인 차량 목록을 뽑았기 때문에 저 조건이 없어도 된다는게 말이 안됨. 
--> 총 5회 이상이지 월 별 5회이상이 아니기 때문. 월별로 나누어보면 0인 차량이 있을 수도 있는 것임. 0인 데이터는 빼라고 했기 때문에 필요한 조건이 맞음.
--> 예를 들어 8월 3회, 9월 2회, 10월 0회 대여된 차량이라면 조건에 맞는 차량인건 맞지만 10월에는 0으로 카운트가 뜰 수밖에 없음. (기막히게 검정 데이터엔 그런 차량이 없었던 것임.)
내가 처음 생각한게 맞고, 나중에 가서 내 쿼리에서 사족이라고 달은 것도 잘못되었고, 사족인걸 필요가 없다고 지적한 사람도 잘못된 것임.

테스트 데이터가 그렇다는데 뭐... 아무튼 도와주는 분들은 고맙지만 모든 말이 맞지는 않다는게 슬픔.
그래서 SQL 같은 것은 더욱이 조건이 있으면 논리적으로 완전히 꼭같은 조건이 아니고서야 전부 적게 되는 것 같음.
"""

-- 23.03.28 달은 답변
-- https://school.programmers.co.kr/questions/46495
/*- 왜 기간조건을 두 번 거느냐 (바깥에 걸면 다 걸러지는 것 아닌가) 하시는 질문이었다. 
https://school.programmers.co.kr/questions/44218 <여기에 달았던 답변에 댓글로 문의주신건데 해당질문과 똑같은 궁금증이라고 하셨다.
엄밀히 말하면 둘은 다른 문제다. 질문글을 올리신건 바깥 쿼리에 있을 때의 문제, 답변 달았던(44218)문제는 차량조회 서브쿼리 안에있을 때의 문제다.
한번만 쓴다고 같은게 아니라 둘이 결과자체가 아예 다르다.
답변요약: 적어주신 `WHERE`절의 조건이 적용되는 부분은 조회하려는 대상(차량)에 대한 조건(차량)이 아니라 메인쿼리의 조회(보려는 기간) 조건입니다. 
메인쿼리는 서브쿼리로서 추출된 car_id에 대하여 테이블에 표시할 기간을 정하는 것이지 추출하려는 car_id와는 상관이 없기 때문에 써주어야 합니다.
  -*/

SELECT MONTH(START_DATE) AS 'MONTH', CAR_ID, COUNT(CAR_ID) AS 'RECORDS' FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN (SELECT CAR_ID FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
               WHERE MONTH(START_DATE) BETWEEN 8 AND 10 -- here
               GROUP BY CAR_ID
               HAVING COUNT(CAR_ID)>=5
               )
               AND MONTH(START_DATE) BETWEEN 8 AND 10 
GROUP BY MONTH(START_DATE), CAR_ID
HAVING RECORDS > 0
ORDER BY MONTH(START_DATE) ASC, CAR_ID DESC;


-- 23.04.12 다른 방식의 풀이이다. 물론 기존에 했었던 방식이 훨씬 나은 방식인건 맞지만 이렇게 확실하게 한 번더 싸주는 방식도 있을 수 있다.
-- id를 추출해두고, 그 id들의 렌탈 히스토리에서 월 정보만 추출해서 테이블을 만들어 둔 뒤, 그 테이블을 GROUP BY하여 count해줘버리는 것이다.
-- https://school.programmers.co.kr/questions/46977
-- ORACLE
SELECT to_number(month) as month, CAR_ID, COUNT(CAR_ID)  -- SELECT MONTH, CAR_ID, COUNT(CAR_ID) 에서 수정
    FROM
    (SELECT TO_CHAR(START_DATE, 'MM') AS MONTH, CAR_ID
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE CAR_ID IN
                (SELECT CAR_ID
                    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                    WHERE TO_CHAR(START_DATE, 'YYYY-MM') BETWEEN '2022-08' AND '2022-11'
                    GROUP BY CAR_ID
                    HAVING COUNT(*) >= 5)
        AND TO_CHAR(START_DATE, 'YYYY-MM') BETWEEN '2022-08' AND '2022-11') 
    GROUP BY MONTH, CAR_ID
    HAVING COUNT(*) > 0
    ORDER BY MONTH, CAR_ID DESC;



-- 복습
-- 230816 복습: EXTRACT을 까먹고 YEAR_MONTH .... 홀홀홀 모드라~ 이러고 있었음
-- 0인 조건에 대해서 안쓴게 감점이라면 감점이지만 처음 풀었던 정답과 거의 비슷하다. (0인 기록이 없기 때문에 넘어가짐.)
SELECT MONTH(start_date), car_id, COUNT(history_id) AS records
  FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        -- 조건을 걸어두는게 좋기 때문에 월별 그룹화는 겉에서 한번 더 해주기로하고 테이블을 한 번 더 데려오는 게 조금더 낫다
        -- 따라서 FROM 절로 데려오는 것이 아니라 조건에 맞는 차 목록만 데려와서 그룹화를 하는 것이 나음
 WHERE car_id IN
       (SELECT car_id
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE EXTRACT(YEAR_MONTH FROM start_date) BETWEEN '202208' AND '202210'
        GROUP BY car_id 
        HAVING COUNT(history_id)>=5)
   AND EXTRACT(YEAR_MONTH FROM start_date) BETWEEN '202208' AND '202210'
GROUP BY MONTH(start_date), car_id
ORDER BY 1 ASC, 2 DESC;



— 231015
