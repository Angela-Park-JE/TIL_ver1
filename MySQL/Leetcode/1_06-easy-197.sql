"""
197. Rising Temperature
https://leetcode.com/problems/rising-temperature/description/?envType=study-plan&id=sql-i
id is the primary key for this table.
This table contains information about the temperature on a certain day.

Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
"""



/* mine : 허허 함부로 연산 하지 말기 배움.*/

-- MySQL : 3번에서 발전시킨 것. 다른 답들을 찾아본 뒤로 date 타입 계산 관련한 문제인 것이라는 결론에 닿았다. 
-- WHERE에서 조인하든 이렇게 FROM 절에 명시하든 다 같은 결과를 반환했으니 말이다.
SELECT t1.id Id
FROM WEATHER t1 JOIN WEATHER t2 
    ON SUBDATE(t1.recorddate, 1)= t2.recorddate
WHERE t1.temperature > t2.temperature;

-- 실제로 오답으로 처리가 되었던 2번도 date 연산 관련한 부분만 고쳤더니 (SUBDATE 사용) 제대로 돌아갔다.
SELECT id Id
FROM 
    (SELECT id, 
            recorddate, 
            temperature, 
            LAG(temperature, 1) OVER (ORDER BY recorddate) as tem,
            LAG(recorddate, 1) OVER (ORDER BY recorddate) as prev
    FROM WEATHER
    ORDER BY recorddate) temp
WHERE tem < temperature
  AND SUBDATE(recorddate, 1) = prev;



"""오답노트"""
-- 1. 일단 id 와 record와 순서가 둘다 오름차순이 아니다 섞여있고, date는 건너뛰는 날이 있기도 하다.
-- 하지만 여기서 원하는 건 어제이고, 어제 데이터가 없으면 그 날짜도 나오면 안된다. 정확한 검증 방법을 이런식으로 하려다 말렸다.
SELECT id Id
FROM 
    (SELECT id, 
            recorddate, 
            LAG(recorddate, 1) OVER (ORDER BY id) as prev,
            temperature, 
            LAG(temperature, 1) OVER (ORDER BY recorddate) as tem
    FROM WEATHER) temp
WHERE tem < temperature
  AND prev = recorddate - 1
  ;
  
-- 2. 이건 한 케이스 빼고 다 통과를 했는데, 한 케이스는 데이터가 엄청 많은 케이스여서 정확히 어떤 부분을 놓쳤는지 바로 감을 잡기 어려웠다.
SELECT id Id
FROM 
    (SELECT id, 
            recorddate, 
            temperature, 
            LAG(temperature, 1) OVER (ORDER BY recorddate) as tem,
            LAG(recorddate, 1) OVER (ORDER BY recorddate) as prev
    FROM WEATHER
    ORDER BY recorddate) temp
WHERE tem < temperature
  AND recorddate -1 = prev
;

-- 3. INNER JOIN 으로 하루 전 것을 붙인 다음, WHERE 에서 오늘 것이 더 높은 것을 거르는 방식이다.
-- 문제는 2번에서 처럼 같은 데이터셋에서 딱 막힌다.
SELECT t1.id Id
FROM WEATHER t1 JOIN WEATHER t2 
    ON t1.recorddate-1 = t2.recorddate
WHERE t1.temperature > t2.temperature;



"""다른 풀이"""

-- MySQL by.mingjun : 조금 억울한 것이다. 논리적으로 결국 같은 것 같은데, Date에 대한 함수를 제대로 쓰지 않아서인것인가.
SELECT w1.Id FROM Weather w1, Weather w2
WHERE subdate(w1.recordDate, 1)=w2.recordDate AND w1.Temperature>w2.Temperature

-- MySQL by.fabrizio3 : 원래 달렸던 솔루션인데, 나도 date로 했는데 뭐가 문제인 것일까...
SELECT wt1.Id 
FROM Weather wt1, Weather wt2
WHERE wt1.Temperature > wt2.Temperature AND 
      TO_DAYS(wt1.DATE)-TO_DAYS(wt2.DATE)=1;



"""솔루션 업로드 내용
**_WARNING!_**
    You must use date column, not 'Id'.
    'Id' ins't ordered data. it just unique value or the row. 

### simple Code
you just join with a condition, minus date.
you should use SUBDATE or date function etc. 
Do not `recordDate -1`. this makes error... (I don't know why)
```sql
SELECT t1.id Id
FROM WEATHER t1 JOIN WEATHER t2 
     ON SUBDATE(t1.recorddate, 1)= t2.recorddate
WHERE t1.temperature > t2.temperature;
```


### complecated code
Not used `JOIN`
I used a window function `LAG()`. 
It lags the data directly, within the set window(range).
And check the data within a row.


```sql
SELECT id Id
FROM 
    (SELECT id, 
            recorddate, 
            temperature, 
            LAG(temperature, 1) OVER (ORDER BY recorddate) as tem,
            LAG(recorddate, 1) OVER (ORDER BY recorddate) as prev
    FROM WEATHER
    ORDER BY recorddate) temp
WHERE tem < temperature
  AND SUBDATE(recorddate, 1) = prev
;
```
"""
