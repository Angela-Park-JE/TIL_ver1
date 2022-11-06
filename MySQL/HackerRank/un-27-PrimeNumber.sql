"""
Prepare> SQL> Alternative Queries> Print Prime Numbers
https://www.hackerrank.com/challenges/print-prime-numbers/problem
Write a query to print all prime numbers less than or equal to 1000. 
Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
For example, the output for all prime numbers <= 10 would be:
`2&3&5&7`
"""

"""답을 보고 배우는 git"""

/*- MySql by.bvsenthil : RECURSIVE CTE를 사용하고 싶었던, 내가 원하는 풀이에 가장 가깝다.-*/
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
	

/*- MySql by.Popuko : 도저히 풀지 못하겠어서 알아보던 중 신기한 풀이 *-/
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
