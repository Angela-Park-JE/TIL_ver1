"""
일명 '별찍기'. 임의로 무언가를 만드는 일이 거의 없다보니, 변수선언부터 찾아봤지만... SQL로 도저히 어떻게 풀 수가 없어서 방법을 찾아보았다. 
Prepare> SQL> Alternative Queries> Draw The Triangle 1
https://www.hackerrank.com/challenges/draw-the-triangle-1/
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * *
* * * *
* * *
* *
*
Write a query to print the pattern P(20).
"""

/*- MySQL by.anulkanpuria -*/
with recursive x as
    (select '*', 20 as cnt
     union
     select '*', cnt-1 from x where cnt > 1)

select repeat('* ',cnt) from x;

/*- MySQL by.borsechetan800 -*/
set @number = 21;    
select repeat(
    '* ', @number := @number - 1
) 
from information_schema.tables limit 20;

/*- Oracle by.hengyiyhy -*/
select
    rpad('* ', level, '* ')
from
    dual
where
    mod(level, 2) = 0
connect by
    level <= 40
order by
    1 desc;

/*- MSSQL by.https://mizykk.tistory.com/135 -*/
DECLARE @NUM INT, @TIME INT  -- 변수 선언
SET @NUM = 20
SET @TIME = 0

WHILE @NUM>@TIME  -- 20이 1이 될 때까지
BEGIN 
SELECT REPLICATE('* ', @NUM)  -- NUM만큼 '* '을 출력
SET @NUM = @NUM-1   -- NUM이 하나씩 내려가도록
END;

/*- MSSQL by.ceoncu -*/
declare @i int
set @i = 20
while @i >= 1
begin
print replicate('*'+space(5),@i) 
set @i = @i - 1
end


"""
참고해서 해보려고 노력했던 것...
`recursive`를 사용했어야 했다.
"""

/*- 실패: 함수를 만드는 것을 활용해서 20까지 정수를 찍는 테이블을 만들려고 했던것 -*/
DROP TABLE IF EXISTS bin_TBL;
CREATE TABLE bin_TBL (txt VARCHAR(10));

DROP PROCEDURE IF EXISTS whileAstarisk;

DELIMITER $$
CREATE PROCEDURE whileAstarisk()
BEGIN
    DECLARE @NUM INT
    DECLARE @TIME INT;
    SET @NUM = 20
    SET @TIME = 0;

    WHILE @NUM>=@TIME DO
        SET @TIME = @TIME + 1;
        SET numbers = @TIME;
    END WHILE;
END $$;
DELIMITER;

SELECT *
FROM bin_TBL;
