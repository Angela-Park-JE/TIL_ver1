/**- FUNCTIONS -**/
-- If we do simpe calculate, we can write `SELECT` query without `FROM`.
-- BUT! we can not write SUM(), AVG() etc, aggregating functions. 


/*- Character Functions -*/

-- CHAR_LENGTH(str) & LENGTH(str) : length & byte size
SELECT CHAR_LENGTH("SQL"), LENGTH("SQL"), CHAR_LENGTH("컴퓨터"), LENGTH("컴퓨터"); -- : 3, 3, 3, 9

-- CONCAT(s1, s2, ...) & CONCAT_WS(sep, s1, s2, ...) : join the characters without & with seperator
SELECT CONCAT("It", "was", "always", "you"), 			-- : Itwasalwaysyou
	   CONCAT("IT", "was", NULL, "you"),    			-- : [NULL]
	   CONCAT_WS(" ", "It", "was", "always", "you");	-- : It was always you

-- FORMAT(x, d) : add comma at the thousand points in integer, `d` is decimal place.
SELECT FORMAT(13579000, 0), FORMAT(13579000, 3);		-- : 13,579,000, 13,579,000.000

-- INSTR(str, substr) : seach the `substr` in `str`, and return the first location number.
-- LOCATE(substr, str, pos) : same with INSTR but we can set the position to start seaching.
-- POSITION(substr IN str) : return the starting location number in `str`
SELECT INSTR("It was always you", "a"),						-- : 5
	   LOCATE( "a", "It was always you", 5), 				-- : 5
	   LOCATE( "a", "It was always you", 6), 				-- : 8
	   LOCATE("my", "This is mysql in my computuer.", 10), -- : 18
	   POSITION("my" IN "This is mysql in my computuer."); -- : 9
-- They don't seperate uppercase and lowercase letters.
SELECT INSTR("It was always you", "A"),						-- : 5 w'a's
	   LOCATE("a", "It was Always you"), 					-- : 5 w'a's
	   LOCATE("A", "It was Always you"), 					-- : 5 w'a's
	   LOCATE("MY", "This is mysql in MY computuer."), 	-- : 9 'my'sql
	   POSITION("MY" IN "This is mysql in MY computuer."); -- : 9 'my'sql

-- LOWER(str) = LCASE(str) & UPPER(str) = UCASE(str)
SELECT LOWER("STRing"), LCASE("STRing"), UPPER("STRing"), UCASE("STRing"); -- :string, string, STRING, STRING

-- LPAD(str, len padstr), RPAD(str, len, padstr) : padding the `str` with `padstr` as long as `len`.
SELECT LPAD("you", 5, '~'), RPAD("you", 5, '~');	-- : ~~you, you~~

-- TRIM(str), LTRIM(str), RTRIM(str) : cut off the space each directions.
SELECT LTRIM("    you    "), RTRIM("    you  "), TRIM("    you    "); -- : 'you    ', '    you', 'you'

-- LEFT(str, len), RIGHT(str, len) : return a value as long as `len` from each directions.
SELECT LEFT("It was always you", 6),  				-- : It was
	   RIGHT("It was always you", 3);				-- : you

-- REPEAT(str, count) : repeat the `str`, `count` times.
SELECT REPEAT("melon", 3);							-- : melonmelonmelon

-- REPLACE(str, from_str, to_str) : replace specific characters.
SELECT REPLACE("It was always you", "you", "me");	-- : It was always me

-- REVERSE(str) : reverse the characters sequence.
SELECT REVERSE("melon");							-- : nolem

-- SUBSTR(str, pos, len) : cut the `str` from `pos` as long as `len`. `pos` can have minus sign and it means start from end of `str`.
-- = SUBSTRING() = MID(), And `len` can be passed, it means "bring to the end".
SELECT SUBSTR("It was always you", 15, 3),
	   SUBSTRING("It was always you", -3, 3),
	   MID("It was always you", 4);  				-- : you, you, was always you

-- TRIM([{BOTH/LEADING/TRAILING} [remstr] FROM] str) : cut off the `remstr` by the direction.
-- TRIM(str) make the trim space from both the head and the tail.
SELECT TRIM("    you    "),							-- : 'you'
	   TRIM(BOTH "~" FROM "~~ ~~you~~ ~~"),		-- : ' ~~you~~ '
	   TRIM(LEADING "~" FROM "~~ ~~you~~ ~~"),		-- : ' ~~you~~ ~~'
	   TRIM(TRAILING "~" FROM "~~ ~~you~~ ~~");	-- : '~~ ~~you~~ '

-- STRCMP(str1, str2) : compare them by ordering sequence and return `0` when they are same,
-- when `str1` is bigger than `str2` = 1, when `str1` is smaller than `str2` = -1.
SELECT STRCMP("MySQL", "mysql"),					-- : 0
	   STRCMP("MySQL1", "mysql2"),					-- : -1		
	   STRCMP("MySQL2", "mysql1");					-- : 1



-- p.195 quiz swap the rabbit to the turtle.
SELECT REPLACE("산토끼 토끼야 어디를 가느냥", "토끼", "거북이"); -- : '산거북이 거북이야 어디를 가느냥'
