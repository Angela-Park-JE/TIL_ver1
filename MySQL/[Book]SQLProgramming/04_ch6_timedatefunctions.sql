/**- FUNCTIONS -**/

/*- DATE and TIME FUNCTIONS -*/

/*- functions about now -*/

-- SYSDATE() : datetime right now, the moment of running the *function*
SELECT SYSDATE();		-- : 2022-09-30 20:19:19

-- CURDATE(), CURRENT_DATE(), CURRENT_DATE : print date now in the PC
SELECT CURDATE(), current_date(), current_DATE;

-- CURTIME(), CURRENT_TIME(), CURRENT_TIME : print time now
SELECT CURTIME(), current_time(), CURRENT_TIME;

-- NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP : print date, time now, the moment of running the *query*
SELECT NOW(); 			-- : 2022-09-30 20:21:38

-- DATE(expr): date part
-- TIME(expr): time part
SELECT DATE('2022-09-30 20:21:38'), 					-- : 2022-09-30	
		TIME('2022-09-30 20:21:38');					-- : 20:21:38



/*- format functions -*/

-- DATE_FORMAT(date, format) : alter the `date` in `format`
SELECT DATE_FORMAT('2022-09-30 20:21:38', 'YEAR: %Y'),	-- : YEAR: 2022
	   DATE_FORMAT('2022-09-30 20:21:38', '%i:%S'),	-- : 21:38
	   DATE_FORMAT('2022-09-30', '%y/%m/%d %W (%j)'); 	-- : 22/09/30 Friday (273)

-- STR_TO_DATE(str, format) : change the str to sql date format
SELECT STR_TO_DATE('22,9,30', '%y, %m, %d'),			-- : 2022-09-30
	   STR_TO_DATE('22, 30, 9', '%y, %d, %m');			-- : 2022-09-30



/*- functions about day -*/

-- DAYNAME(date) : weekday
SELECT DAYNAME('2023-01-01');  							-- : Sunday

-- DAYOFWEEK(date) : the weekday number in the week
SELECT DAYNAME('2023-02-01'), DAYOFWEEK('2023-02-01');	-- : Wednesday, 4

-- DAYOFMONTH(date), DAY(date) : day
SELECT DAYOFMONTH('2023-01-01'), DAY('2023-02-01');		-- : 1, 1

-- DAYOFYEAR(date) : the day number in the year
SELECT DAYOFYEAR('2023-02-01');							-- : 32

-- LAST_DAY(date) : last day of the month
SELECT LAST_DAY('2023-01-01');							-- : 2023-01-31

-- YEAR(date) : year
-- MONTH(date) : month
-- QUARTER(date) : quarter
-- WEEK(date) : week number in year
SELECT YEAR('2023-01-31'), MONTH('2023-01-31 12:31:31'), QUARTER('2023-01-31'); 		-- : 2023, 1, 1
SELECT WEEK('2023-01-31', 5);								-- : 5

-- WEEKOFYEAR(date) : number of the week in year
SELECT WEEKOFYEAR('2022-12-25');							-- : 51

-- YEARWEEK(date, mode) : the year and the week number of the `date`
SELECT YEARWEEK('2022-12-25', 5);							-- : 202251 



/*- functions about times-*/

-- HOUR(time) : hour
-- MINUTE(time) : minute
-- SECOND(time) : second
SELECT HOUR('2022-12-25 11:22:33'), MINUTE('2022-12-25 11:22:33'), SECOND('11:22:33'); -- : 11, 22, 33



/*- functions calculating date -*/

-- DATE_ADD(date, INTERVAL expr unit) : `date` + `expr`, `unit` means day or month etc.
-- = ADDDATE(date, INTERVAL expr unit)
-- ADDDATE(expr, days) : `expr` + `days` 
SELECT DATE_ADD('2022-09-30 20:21:38', INTERVAL 100 day),					-- : 2023-01-08 20:21:38
	   ADDDATE('2022-09-30 20:21:38', INTERVAL 10 month),					-- : 2023-07-30 20:21:38
	   ADDDATE('2022-09-30 20:21:38', 100),									-- : 2023-01-08 20:21:38
	   ADDDATE('2022-09-30', INTERVAL '1 1' year_month);					-- : 2023-10-30

-- DATE_SUB(date INTERVAL expr unit) : `date` - `expr`, `unit` means day or month etc.
-- = SUBDATE(date INTERVAL expr unit) 
-- SUBDATE(expr, days) : `expr` - `days`
SELECT DATE_SUB('2022-09-30 20:21:38', INTERVAL 100 day),				-- : 2022-06-22 20:21:38
	   SUBDATE('2022-09-30 20:21:38', INTERVAL 10 month),				-- : 2021-11-30 20:21:38
	   SUBDATE('2022-09-30 20:21:38', 100),								-- : 2022-06-22 20:21:38
	   SUBDATE('2022-09-30', INTERVAL '10 10' day_hour);				-- : 2022-09-19 14:00:00
        
-- I found that `ADDTIME`, `SUBTIME` are also calculate time, and it works with 6 number of expr
-- ADDTIME(time, expr) : `time` + `expr`
-- SUBTIME(time, expr) : `time` - `expr`
SELECT ADDTIME('13:13:13', 100000),			-- : 23:13:13
	   ADDTIME('13:13:13', 110000),			-- : 24:13:13
	   SUBTIME('13:13:13', 111000),			-- : 02:03:13
	   SUBTIME('13:13:13', 111100),			-- : 02:02:13
	   ADDTIME('13:13:13', 111110),			-- : 24:24:23
	   SUBTIME('13:13:13', 111111),			-- : 02:02:02
	   ADDTIME('2022-09-30 20:21:38', 100),	-- : 2022-09-30 20:22:38
	   SUBTIME('2022-09-30 20:21:38', 300);	-- : 2022-09-30 20:18:38

-- EXTRACT(unit FROM date) : return the `unit` from `date`
SELECT EXTRACT(YEAR_MONTH FROM '2022-09-30 20:18:38'), 		-- : 202209
	   EXTRACT(DAY_HOUR FROM '2022-09-30'),					-- : 0
	   EXTRACT(HOUR_MINUTE FROM '2022-09-30 20:18:38'),		-- : 2018
	   EXTRACT(MINUTE_SECOND FROM '2022-09-30 20:18:38'); 	-- : 1838

-- DATEDIFF(expr1, expr2) : `expr1` - `expr2` days, time unit is ignored.
SELECT DATEDIFF('2022-09-30 20:18:38', '2022-06-22'),		-- : 100
	   DATEDIFF('2023-01-01 00:00:00', '2022-12-31 23:59:59'); -- : 1

-- MAKEDATE(year, dayofyear) : return the day of the year in `year`
SELECT MAKEDATE(2022, 300),									-- : 2022-10-27
	   MAKEDATE('2022', 300);								-- : 2022-10-27




/*- unit types-*/
/* with ADDDATE(), SUBDATE()

year, month, quarter, week, day, hour, minut, second
	`INTERVAL 12 day`
year_month, day_hour(day and hour)
	`INTERVAL '1 1' year_month`
day_minute(day, hour, minute)
	`INTERVAL '1 1:20' day_minute`
day_second(day, hour, minute, second)
	`INTERVAL '1 1:20:30' day_second`
hour_minute
	`INTERVAL '1:20' hour_minute`
hour_second(hour, minute, second)
	`INTERVAL '1:20:30' hour_second`
minute_second
	`INTERVAL '20:30' minute_second`

*/


/*- date format -*/
/* with DATE_FORMAT(), STR_TO_DATE()

%y : 22			%Y : 2022
%m : 09			%M : September			%b : Sep			%c : 9
%d : 30			%e : 30(int)
%j : 001, 002, 363, 365

%W : Friday		%w : 5
%U : 01 (start with SUNDAY FROM 0, 00~53, ex:2021-01-03)
%u : 00 (start with MONDAY FROM 0, 00~53, ex:2021-01-03)
%V : 01 (start with SUNDAY FROM 1, 01~53, ex:2021-01-03)
%v : 53 (start with MONDAY FROM 1, 01~53, ex:2021-01-03)

%H : 12, 24		%h, %I : 12, 00
%p : AM, PM
%i : 01, 30, 59(minute)
%S, %s : 00, 59(second)
%T : 00:12:34 (time in 24)
%r : 12:12:34 AM (time in 12)


*/


-- p.211 quiz. weekday of last day in the month, now.
SELECT DAYNAME(LAST_DAY(SYSDATE())),
		DATE_FORMAT(LAST_DAY(SYSDATE()), '%W');
