"""
Prepare> SQL> Basic Join> Ollivander's Inventory
https://www.hackerrank.com/challenges/harry-potter-and-wands/
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age.
"""

-- WANDS : id, code, coins_needed, power
-- WANDS_PROPERTY : code, age, is_evil


"""오답노트"""

/*- MySQL: 왜 정답이 아닐까 고민중이다. -*/
SELECT w.id, p.age, w.coins_needed, w.power
FROM WANDS w, WANDS_PROPERTY p
WHERE w.code = p.code
    AND p.is_evil = 0
ORDER BY 4 DESC, 2 DESC;
