/*
1527. Patients With a Condition
https://leetcode.com/problems/patients-with-a-condition/description/?envType=study-plan-v2&envId=top-sql-50
  Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. 
  Type I Diabetes always starts with DIAB1 prefix.
  Return the result table in any order.
  Table: Patients
  +--------------+---------+
  | Column Name  | Type    |
  +--------------+---------+
  | patient_id   | int     |
  | patient_name | varchar |
  | conditions   | varchar |
  +--------------+---------+
*/


-- 241110: 문제 설명이 이상하다. "Type I Diabetes always starts with DIAB1 prefix." 라고 해놓고 중간에 들어가 있어도 데려와야함.
-- ...?
SELECT  patient_id
      , patient_name
      , conditions
  FROM  PATIENTS
 WHERE  conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%'
;

-- MySQL: 정규표현식 이용.
SELECT patient_id,
       patient_name,
       conditions
  FROM PATIENTS
 WHERE conditions REGEXP '^DIAB1[0-9]*|\\sDIAB1[0-9]*'
 ;
-- Oracle: '^DIAB1[0-9]*|\sDIAB1[0-9]*'에 백슬래시 두번 들어가면 "ACNE DIAB100"이런 경우가 검색이 안됨
SELECT patient_id,
       patient_name,
       conditions
  FROM PATIENTS
 WHERE REGEXP_LIKE(conditions, '^DIAB1[0-9]*|\sDIAB1[0-9]*')
 ;



/*오답노트*/

-- 241110: 정규표현식 이용 : "ACNE +DIAB100"이 검색된다.
SELECT patient_id,
       patient_name,
       conditions
  FROM PATIENTS
 WHERE conditions REGEXP '\\bDIAB1[0-9]*\\b'
;
