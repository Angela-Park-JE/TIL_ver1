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

/*- MySQL: 파워와 에이지가 같다면 적은 코인을 내는 것을 찾아 넣어야했던 것이다. 헤르미온느... 돈도 돈이지만 시야를 좀 넓히는 건 어때 -*/


"""오답노트"""

/*- MySQL: 왜 정답이 아닐까 고민중이다. 파워와 에이지가 같은 경우 가장 적은 코인을 내야하는 지팡이 한개만 출력해야 하는걸까. 딱히 그런 점은 적힌게 없는데.-*/
SELECT w.id, p.age, w.coins_needed, w.power
FROM WANDS w, WANDS_PROPERTY p
WHERE w.code = p.code
    AND p.is_evil = 0
ORDER BY 4 DESC, 2 DESC;

/*- 답 by.dun_zhang2012 -*/
select w.id, p.age, w.coins_needed, w.power 
from Wands as w 
  join Wands_Property as p on (w.code = p.code) 
where p.is_evil = 0 
  and w.coins_needed = 
    (
    select min(coins_needed) 
    from Wands as w1 join Wands_Property as p1 on (w1.code = p1.code) 
    where w1.power = w.power and p1.age = p.age
    ) 
order by w.power desc, p.age desc
