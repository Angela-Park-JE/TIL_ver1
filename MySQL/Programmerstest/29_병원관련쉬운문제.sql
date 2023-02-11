"""
흉부외과 또는 일반외과 의사 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/132203
DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.
DOCTOR 테이블에서 진료과가 흉부외과(CS)이거나 일반외과(GS)인 의사의 이름, 의사ID, 진료과, 고용일자를 조회하는 SQL문을 작성해주세요. 
이때 결과는 고용일자를 기준으로 내림차순 정렬하고, 고용일자가 같다면 이름을 기준으로 오름차순 정렬해주세요.
"""


/*- mine : 문자열 검색하는 방법에는 여러 가지가 있지만 or 조건 검색을 할 때에는 REGEX 혹은 in () 을 하는 것이 가장 간편한 듯 하다. -*/

-- MySQL
SELECT dr_name, dr_id, mcdp_cd, DATE_FORMAT(hire_ymd, '%Y-%m-%d')
FROM DOCTOR
WHERE mcdp_cd in ('CS', 'GS')
ORDER BY 4 DESC, 1 ASC;




"""
12세 이하인 여자 환자 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/132201
PATIENT 테이블은 다음과 같으며 PT_NO, PT_NAME, GEND_CD, AGE, TLNO는 각각 환자번호, 환자이름, 성별코드, 나이, 전화번호를 의미합니다.
PATIENT 테이블에서 12세 이하인 여자환자의 환자이름, 환자번호, 성별코드, 나이, 전화번호를 조회하는 SQL문을 작성해주세요. 
이때 전화번호가 없는 경우, 'NONE'으로 출력시켜 주시고 결과는 나이를 기준으로 내림차순 정렬하고, 나이 같다면 환자이름을 기준으로 오름차순 정렬해주세요.
"""


/*- mine : IFNULL 만 알면 쉬워지는 문제이다. -*/

-- MySQL
SELECT pt_name, pt_no, gend_cd, age, IFNULL(tlno, 'NONE') tlno
FROM PATIENT
WHERE age <=12 AND gend_cd = 'W'
ORDER BY age desc, pt_name asc;
