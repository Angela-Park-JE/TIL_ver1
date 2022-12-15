"""
196. Delete Duplicate Emails
https://leetcode.com/problems/delete-duplicate-emails/?envType=study-plan&id=sql-i
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. 
Note that you are supposed to write a 'DELETE' statement and 'not a SELECT' one.

After running your script, the answer shown is the Person table. 
The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.
"""

/*- MySQL : 이메일로 GROUP BY하여 가장 id가 작은 것에 대한 데이터 남기고, 거기에 속하지 않은 id를 DELETE 하는 방식이다. 
    오류가 뜨지 않고 되는데 FROM 절에 PERSON 이 들어가는 것은 같은데-*/

DELETE 
FROM PERSON c1 WHERE id NOT IN 
    (SELECT * FROM 
        (SELECT MIN(id) FROM PERSON c2 GROUP BY email) c3);


"""오답노트"""

/*- MySQL : 첫 시도. 타겟 테이블을 FROM 에 놓을 수 없다는 말. 그럼 어떻게 데여오라는 말일까 하였다.-*/
-- You can't specify target table 'PERSON' for update in FROM clause
DELETE
FROM PERSON
WHERE email IN (SELECT email FROM PERSON GROUP BY email);

/*- MySQL : 두 번째 시도. 참조에서 낮은 것을 선택하여 남기도록 하는 식으로 부등호를 바꾸었다. 결국 또 같은 이유로 거부되었다. -*/
-- reference : https://www.delftstack.com/ko/howto/mysql/delete-duplicate-rows-in-mysql/
-- You can't specify target table 'c' for update in FROM clause
Delete FROM PERSON c WHERE id IN 
  (SELECT c1.id 
  FROM PERSON as c1
  INNER JOIN PERSON as c2 ON c1.id > c2.id AND c1.email = c2.email);

/*- MySQL : 다른 시도. 참조에서 가장 마지막에있는, ROW_NUMBER를 email 별로 매겨서 1보다 큰 것들만 선택하게 하여 지우는 방식이다. 
    그러나 무슨 문제인지 'row ~ row > 1);'가 문제라고 뜬다. -*/
DELETE 
FROM PERSON
WHERE id IN 
    (SELECT id 
     FROM 
        (SELECT id, 
                ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) row 
         FROM PERSON) t
     WHERE row > 1);
