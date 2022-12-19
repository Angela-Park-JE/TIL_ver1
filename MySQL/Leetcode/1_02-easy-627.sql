"""
627. Swap Salary
https://leetcode.com/problems/swap-salary/description/?envType=study-plan&id=sql-i
Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement 
  and no intermediate temporary tables.
Note that you must write a single update statement, do not write any select statement for this problem.
"""


/*- mine : update 라는 것을 잊었다. 두 가지 방법이 있다. 
    공부하면서 실제로 DB를 변형하는 부분을 적게 공부하면서 취약했기 때문인지 SET 이 바로 떠오르지 않았다.
    참조: https://dba.stackexchange.com/questions/69269/updating-multiple-rows-with-different-values-in-one-query -*/

-- 1 
UPDATE SALARY 
   SET sex = if(sex = 'f', 'm', 'f');
-- 2
UPDATE SALARY
   SET sex = CASE WHEN sex = 'f' THEN 'm' ELSE 'f' END;



"""오답노트"""

-- 계속 이러고 있었음
-- SELECT id, name, CASE sex WHEN 'f' THEN 'm' WHEN 'm' THEN 'f' END sex, salary
-- FROM SALARY;
