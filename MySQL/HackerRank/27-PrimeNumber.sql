"""
Prepare> SQL> Alternative Queries> Print Prime Numbers
https://www.hackerrank.com/challenges/print-prime-numbers/problem
Write a query to print all prime numbers less than or equal to 1000. 
Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
For example, the output for all prime numbers <= 10 would be:
`2&3&5&7`
"""

/*- MySql: 소수를 구하는 방법을 찾다가... 오답노트 처럼 구현하다 막혀서 많이 찾아보던중 가장 괜찮은 구조를 찾았다. -*/
WITH RECURSIVE RE_CTE AS 
    (
     SELECT 1 num
     UNION ALL
     SELECT num + 1 FROM RE_CTE WHERE num < 1000
    )
    , MAIN_CTE AS
    (
    SELECT n1.num nums
    FROM RE_CTE n1, RE_CTE n2
    WHERE mod(n1.num,n2.num)=0
    GROUP BY n1.num
    HAVING count(n1.num)=2
    ORDER BY 1
    )

SELECT GROUP_CONCAT(nums SEPARATOR '&')
FROM MAIN_CTE;


/*- 참고 : https://lsh-story.tistory.com/57 -*/
accept range prompt '수를 입력하세요'
with num_list as ( select level as num
                    from dual
                    connect by level<=&&range)
select n1.num
from num_list n1, num_list n2
where mod(n1.num,n2.num)=0
group by n1.num
having count(n1.num)=2
order by 1;


"""오답노트"""
-- 일부 소수의 배수를 지워놓고 시작하려고 했으나, 이것을 반복적으로 하기 위해 함수를 활용하여 recursive cte를 만들면 어떨까 했다. 
-- 미완성이고, @같이 실패...
CREATE FUNCTION function1 (
    num1 DOUBLE,
    num2 DOUBLE
    ) RETURNS DOUBLE
BEGIN
    DECLARE divs DOUBLE;
    DECLARE remains DOUBLE;
    DECLARE squares DOUBLE; -- 변수 선언
    
    SELECT num1/num2
      INTO divs;
    SELECT num1%num2
      INTO remains;
    SELECT SQRT(num1)
      INTO squares; -- 여기까지 정의하다가 두었음 아래 함수 알고리즘은 짜지 
    
--     SET RETURNS = ;

--     RETURN ... ;
-- END

WITH RECURSIVE RE_CTE AS (
     SELECT 1 AS n 
     UNION ALL
     SELECT n + 1 FROM RE_CTE WHERE n< 1000
    )
    , CTE_2 AS (    -- delete 2's multiple
     SELECT n FROM RE_CTE WHERE (n%2 != 0) 
    )
    , CTE_3 AS (   -- delete 3's multiple
     SELECT n FROM CTE_2 WHERE (n%3 != 0) 
    )
    , CTE_5 AS (   -- delete 5's multiple
     SELECT n FROM CTE_3 WHERE (n%5 != 0) 
    )
    , CTE_7 AS (   -- delete 7's multiple
     SELECT n FROM CTE_5 WHERE (n%7 != 0)
    )
    , CTE_ AS (
     SELECT n FROM CTE_7
     WHERE ...........
    )

SELECT CASE WHEN a.n%b.n = 0 
FROM 
WHERE n**2 <= 1000


"""답을 보고 배우는 git"""
-- 도저히 풀지 못하겠어서 알아보던 중 배울만한 답들을 찾아본 적이 있다.

/*- MySql by.bvsenthil : RECURSIVE CTE를 사용하고 싶었던, 내가 원하는 풀이에 가장 가깝다. 
	WHERE 부분이 가장 어려웠다. WHERE NOT EXISTS 를 활용하는 것도 잊고 있었고.-*/
#select all the numbers till 1000 in the tblnums
with recursive tblnums
as (
	select 2 as nums
	union all
	select nums+1 
	from tblnums
	where nums<1000)
	
select group_concat(tt.nums order by tt.nums separator '&')  as nums
from tblnums tt
where not exists -- WHERE 절이 이 부분이 핵심
	#the num should not be divisible by any number less than it
	( select 1 from tblnums t2 
	where t2.nums <= tt.nums/2 and mod(tt.nums,t2.nums)=0)  
	

/*- MySql by.Popuko : 상당히 신기한 풀이. 실제로 함수를 정의하여 하려고 했던 내 시도가 향했던 방향이다. -*/
delimiter //
create procedure Print_Prime()
begin
    declare max_num int default 1000;
    declare result text default '2';
    declare temp_num int;
    declare current_num int default 3;
    declare is_prime boolean;
    while current_num<=max_num do
        set temp_num = 2;
        set is_prime = true;
        while temp_num<=floor(current_num/2) do
            if current_num%temp_num=0 then 
                set is_prime = false;
            end if;
            set temp_num=temp_num+1;
        end while;
        if is_prime = true then
            set result = concat(result,'&',current_num);
        end if;
        set current_num = current_num+2;
    end while;
    select result;
end//
delimiter ;
call Print_Prime();


/*- MySql by.DipS91 : 변수 정의를 활용해서 풀이한 방법.-*/
SELECT GROUP_CONCAT(NUMB SEPARATOR '&')
FROM (
    SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
) tempNum
WHERE NUMB<=1000 AND NOT EXISTS(
		SELECT * FROM (
			SELECT @nu:=@nu+1 as NUMA FROM
			    information_schema.tables t1,
			    information_schema.tables t2,
			    (SELECT @nu:=1) tmp1
			    LIMIT 1000
			) tatata
		WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
	)
