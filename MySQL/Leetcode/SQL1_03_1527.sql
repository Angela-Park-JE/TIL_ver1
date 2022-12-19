"""
1527. Patients With a Condition
https://leetcode.com/problems/patients-with-a-condition/description/?envType=study-plan&id=sql-i
patient_id is the primary key for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.

Write an SQL query to report the patient_id, patient_name and conditions of the patients who have Type I Diabetes. 
Type I Diabetes always starts with `DIAB1` prefix.
Return the result table in any order.
Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.
"""


/* mine : 어떻게 구성할까 고민은 역시 데이터가 어떻게 생겼는지를 알아야 해결할 수도 있다는 것. */

-- MySQL
SELECT patient_id, patient_name, conditions
FROM PATIENTS
WHERE (LEFT(conditions, 5) = 'DIAB1')     -- 정확히 그것으로 시작하거나
   OR (conditions LIKE '% DIAB1%')        -- 중간에 그것으로 시작하거나
ORDER BY patient_id;



"""오답노트"""
-- DIAB1 으로 시작한다길래 LEFT로 찾으니, 띄어쓰기 후 DIAB1이 포함된 건도 했어야 했다.
-- DIAB1 이 포함된 것을 INSTR로 찾으니, 앞에 SA가 붙어 SADIAB100이런 건도 있는데 걸러야 했다. (INSTR(conditions, 'DIAB1') != 0)

-- 이런 조건을 붙였다가 의미없어서 지웠다.
```
WHERE INSTR(conditions, 'DIAB1') != 0       -- 포함하는지
  AND
```


"""다른 답안"""
-- MySQL by.anshulkapoor018 : 다 쳐내고 정리하면 이게 맞긴 하다. 
SELECT * FROM PATIENTS WHERE
CONDITIONS LIKE '% DIAB1%' OR
CONDITIONS LIKE 'DIAB1%';
