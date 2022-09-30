/*- DATE and TIME FUNCTIONS -*/

/*- functions about now -*/

-- CURDATE(), CURRENT_DATE(), CURRENT_DATE : print date now
SELECT CURDATE(), current_date(), current_DATE;

-- CURTIME(), CURRENT_TIME(), CURRENT_TIME : print time now
SELECT CURTIME(), current_time(), CURRENT_TIME;

-- NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP : print date, time now
SELECT NOW(); 											-- : '2022-09-30 20:21:38'

-- DATE(expr): date part
-- TIME(expr): time part
SELECT DATE('2022-09-30 20:21:38'), 					-- : 2022-09-30	
		TIME('2022-09-30 20:21:38');					-- : 20:21:38



/*- functions about day -*/

-- DAYNAME(date) : weekday
SELECT DAYNAME('2023-01-01');  							-- : Sunday

-- DAYOFMONTH(date), DAY(date) : day
SELECT DAYOFMONTH('2023-01-01'), DAY('2023-01-01');		-- : 1, 1

-- LAST_DAY(date) : last day of the month
SELECT LAST_DAY('2023-01-01');							-- : 2023-01-31

-- YEAR(date) : year
-- MONTH(date) : month
-- QUARTER(date) : quarter
SELECT YEAR('2023-01-31'), MONTH('2023-01-31 12:31:31'), QUARTER('2023-01-31'); 		-- : 2023, 1, 1

-- WEEKOFYEAR(date) : number of the week in year
SELECT WEEKOFYEAR('2022-12-25');						-- : 51



/*- functions about times-*/

-- HOUR(time) : hour
-- MINUTE(time) : minute
-- SECOND(time) : second
SELECT HOUR('2022-12-25 11:22:33'), MINUTE('2022-12-25 11:22:33'), SECOND('11:22:33'); -- : 11, 22, 33



/*- functions calculating date -*/

-- DATE_ADD(date, INTERVAL expr unit) : `date` + `expr` `unit`, `unit` means day or month etc.
-- = ADDDATE(date, INTERVAL expr unit)
-- ADDDATE(expr, days) : `expr` + `days` 
SELECT DATE_ADD('2022-09-30 20:21:38', INTERVAL 100 day),					-- : 2023-01-08 20:21:38
		ADDDATE('2022-09-30 20:21:38', INTERVAL 10 month),					-- : 2023-07-30 20:21:38
		ADDDATE('2022-09-30 20:21:38', 100);								-- : 2023-01-08 20:21:38

-- I found that `ADDTIME` is also calculate time, and it works with 6 number of expr
-- ADDTIME(time, expr) : `time` + `expr`
SELECT ADDTIME('13:13:13', 100000),			-- : 23:13:13
		ADDTIME('13:13:13', 110000),		-- : 24:13:13
        ADDTIME('13:13:13', 111000),		-- : 24:23:13
        ADDTIME('13:13:13', 111100),		-- : 24:24:13
        ADDTIME('13:13:13', 111110),		-- : 24:24:23
        ADDTIME('13:13:13', 111111),		-- : 24:24:24
        ADDTIME('2022-09-30 20:21:38', 100);-- : 2022-09-30 20:22:38

