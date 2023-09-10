"""
코딩테스트 연습> GROUP BY> 진료과별 총 예약 횟수 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/132202
APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
"""

/*- mine : 취소 여부로 'N' 인 것만 뽑는 줄 알고 조건을 써넣었다가 오답이었다. 상관 없이 예약 건수 전체를 원하는 것이었다. -*/

-- MySQL
SELECT mcdp_cd '진료과 코드', COUNT(pt_no) '5월예약건수'
FROM APPOINTMENT
WHERE EXTRACT(YEAR_MONTH FROM apnt_ymd) = 202205 
--  AND apnt_cncl_yn = 'N'
GROUP BY mcdp_cd 
ORDER BY 2, 1;



-- 복습
-- 230910: 이전과 똑같이 했다. 다만 AS를 한 것, 들여쓰기를 한 것 정도가 다르다.
SELECT mcdp_cd AS '진료과 코드', COUNT(apnt_no) AS '5월예약건수'
  FROM APPOINTMENT
 WHERE EXTRACT(YEAR_MONTH FROM apnt_ymd) = '202205'
 GROUP BY mcdp_cd
 ORDER BY 2 ASC, 1 ASC;
