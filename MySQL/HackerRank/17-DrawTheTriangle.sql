"""
일명 '별찍기'. 임의로 무언가를 만드는 일이 거의 없다보니, 변수선언부터 찾아봤지만... SQL로 도저히 어떻게 풀 수가 없어서 방법을 찾아보았다. 
참고 페이지 : https://mizykk.tistory.com/135

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

/*- MSSQL -*/
DECLARE @NUM INT, @TIME INT  -- 변수 선언
SET @NUM = 20
SET @TIME = 0

WHILE @NUM>@TIME  -- 20이 1이 될 때까지
BEGIN 
SELECT REPLICATE('* ', @NUM)  -- NUM만큼 '* '을 출력
SET @NUM = @NUM-1   -- NUM이 하나씩 내려가도록
END;


"""
참고해서 해보려고 노력했던 것들
"""

/*- 함수를 만드는 것을 활용해서 20까지 정수를 찍는 테이블을 만들려고 했던것 -*/
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
