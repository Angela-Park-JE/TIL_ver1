/*- FUNCTIONS -*/
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

-- 
