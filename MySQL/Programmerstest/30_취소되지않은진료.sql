"""
취소되지 않은 진료 예약 조회하기
https://school.programmers.co.kr/learn/courses/30/lessons/132204
PATIENT 테이블은 다음과 같으며 PT_NO, PT_NAME, GEND_CD, AGE, TLNO는 각각 환자번호, 환자이름, 성별코드, 나이, 전화번호를 의미합니다.
DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.
APPOINTMENT 테이블은 다음과 같으며 APNT_YMD, APNT_NO, PT_NO, MCDP_CD, MDDR_ID, APNT_CNCL_YN, APNT_CNCL_YMD는 각각 진료 예약일시, 진료예약번호, 환자번호, 진료과코드, 의사ID, 예약취소여부, 예약취소날짜를 나타냅니다.

PATIENT, DOCTOR 그리고 APPOINTMENT 테이블에서 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL문을 작성해주세요. 
진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력되도록 작성해주세요. 
결과는 진료예약일시를 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 조건이 많을 수록 차분하게 차근차근 쌓는 것이 좋다. 
    이렇게 조건이 많을 때에는 조건 절에서 조인하지 말고 정직하게 조인하는 것이 보기엔 더 편할 것 같긴하다. (그래서 원래 FROM 절에 조인을 명시하는 것을 더 좋아하는데...)
    아무튼 해당 날짜에 취소된 건이 아니라, 오늘이 4월 13일이면 오늘 있을 진료건을 출력하는 것이라고 생각하자. -*/

-- MySQL
SELECT a.apnt_no, p.pt_name, p.pt_no, a.mcdp_cd, d.dr_name, a.apnt_ymd
FROM APPOINTMENT a, PATIENT p, DOCTOR d
WHERE a.pt_no = p.pt_no AND a.mddr_id = d.dr_id 
  AND DATE(APNT_YMD) = '2022-04-13' 
  AND apnt_cncl_yn != 'Y'
  AND a.mcdp_cd = 'CS'
ORDER BY a.apnt_ymd ASC;



-- 복습
-- 230820: DATE 안하고 날짜랑 비교하고있으니 뜨지 않았다. 신기하게도 완전히 똑같다.
SELECT a.apnt_no, p.pt_name, p.pt_no, a.mcdp_cd, d.dr_name, a.apnt_ymd
  FROM APPOINTMENT a, PATIENT p, DOCTOR d
 WHERE p.pt_no = a.pt_no AND d.dr_id = a.mddr_id
   AND DATE(a.apnt_ymd) = '2022-04-13'
   AND a.mcdp_cd = 'CS' AND a.apnt_cncl_yn = 'N'
 ORDER BY a.apnt_ymd ASC;
