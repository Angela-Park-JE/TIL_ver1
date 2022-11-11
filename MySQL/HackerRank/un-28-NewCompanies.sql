"""
Prepare> SQL> Advanced Select> New Companies
https://www.hackerrank.com/challenges/the-company/problem
Amber's conglomerate corporation just acquired some new companies. 
Each of the companies follows this hierarchy: FOUNDER - LEAD MANAGER - SENIOR MANAGER - MANAGER - EMPLOYEE
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
total number of senior managers, total number of managers, and total number of employees. 
Order your output by ascending company_code.
"""




"""오답노트"""
-- 내가 해커랭크에서 풀지 않은 문제가 6개 이하라는 것에 아주 약간의 위안을 얻었다 

-- 1. 한 명 아래의 사람들을 세도록 한 후 SUM을 할 예정이었으나 말을 듣지 않음.
    -- COUNT(a.lead_manager_code) OVER (PARTITION BY a.company_code),
    -- COUNT(a.senior_manager_code) OVER (PARTITION BY a.lead_manager_code), 
    -- COUNT(a.manager_code) OVER (PARTITION BY a.lead_manager_code), 
    -- COUNT(a.employee_code) OVER (PARTITION BY a.manager_code)


-- 2. 활용하여 가장 답과 가까워 보이는 형태를 구했으나, 이게 답이 아니어서 실제 인원이아니라 구조 상 인원이 정해져있는 방식을 구하라는 줄 알고 다른 방식을 찾기 시작함.
-- SELECT a2.company_code, b.founder, a2.r1, a2.r2, a2.r3, a2.r4
-- FROM COMPANY b JOIN
--         (
--         SELECT a.company_code,
--             COUNT(DISTINCT a.lead_manager_code) r1, 
--             COUNT(DISTINCT a.senior_manager_code) r2,
--             COUNT(DISTINCT a.manager_code) r3, 
--             COUNT(DISTINCT a.employee_code) r4
--         FROM EMPLOYEE a 
--         GROUP BY a.company_code
--         ORDER BY a.company_code
--         ) a2 ON a2.company_code = b.company_code
-- ;


-- 3. senior manager 세는 sm_counts까지는 되지만, m_counts에서 두 개 이상의 컬럼을 반환하면서 동작하지 않음
-- SELECT DISTINCT main.company_code, main2.founder,

--     (SELECT COUNT(lead_manager_code) 
--      FROM LEAD_MANAGER a
--      WHERE a.company_code = main.company_code
--      GROUP BY company_code) lm_counts,
     
--      (SELECT COUNT(senior_manager_code) 
--       FROM SENIOR_MANAGER a
--       WHERE a.company_code = main.company_code
--       GROUP BY company_code, lead_manager_code) sm_counts,
     
--      (SELECT COUNT(manager_code)
--       FROM MANAGER a
--       WHERE a.company_code = main.company_code
--       GROUP BY company_code, lead_manager_code, senior_manager_code) m_counts
     
-- FROM EMPLOYEE main JOIN COMPANY main2 ON main.company_code = main2.company_code
-- ORDER BY main.company_code;
