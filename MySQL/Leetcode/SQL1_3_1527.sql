"""

"""




/* mine : 어떻게 구성할까 고민은 역시 데이터가 어떻게 생겼는지를 알아야 해결할 수도 있다는 것. */

-- MySQL

SELECT patient_id, patient_name, conditions
FROM PATIENTS
WHERE (LEFT(conditions, 5) = 'DIAB1')     -- 정확히 그것으로 시작하거나
   OR (conditions LIKE '% DIAB1%')     -- 중간에 그것으로 시작하거나
ORDER BY patient_id;



"""오답노트"""
-- DIAB1 으로 시작한다길래 LEFT로 찾으니, 띄어쓰기 후 DIAB1이 포함된 건도 했어야 했다.
-- DIAB1 이 포함된 것을 INSTR로 찾으니, 앞에 SA가 붙어 SADIAB100이런 건도 있는데 걸러야 했다. (INSTR(conditions, 'DIAB1') != 0)

-- 이런 조건을 붙였다가 의미없어서 지웠다.
```
WHERE INSTR(conditions, 'DIAB1') != 0       -- 포함을 하는데,
  AND
```
