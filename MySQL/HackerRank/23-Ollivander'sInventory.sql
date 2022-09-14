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
SELECT w1.id, p1.age, w1.coins_needed, w1.power
FROM WANDS w1, WANDS_PROPERTY p1
WHERE w1.code = p1.code
    AND p1.is_evil = 0
    AND w1.coins_needed = 
    (SELECT MIN(w2.coins_needed) FROM WANDS w2, WANDS_PROPERTY p2 
     WHERE w2.code = p2.code AND w1.power = w2.power AND p1.age = p2.age)
ORDER BY 4 desc, 2 desc;


"""오답노트"""

/*- MySQL: 왜 정답이 아닐까 고민중이다. 파워와 에이지가 같은 경우 가장 적은 코인을 내야하는 지팡이 한개만 출력해야 하는걸까. 딱히 그런 점은 적힌게 없는데.-*/
SELECT w.id, p.age, w.coins_needed, w.power
FROM WANDS w, WANDS_PROPERTY p
WHERE w.code = p.code
    AND p.is_evil = 0
ORDER BY 4 DESC, 2 DESC;

/*- 참고 MySQL by.dun_zhang2012 -*/
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

/*- 참고 ORACLE by.Sardor_Bayramov : PPARTITION을 사용하고 조인을 최소화했다. 너무 믓지다-*/
select id, age, minimum_cost, power
  from (select w.id,
               p.age,
               w.coins_needed,
               min(w.coins_needed) over(partition by w.power, p.age) minimum_cost,
               w.power
          from wands w
          join wands_property p
            on p.code = w.code
           and p.is_evil = 0)
 where coins_needed = minimum_cost
 order by power desc, age desc;
