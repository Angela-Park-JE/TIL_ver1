-- WITH RECURSIVE 문 
-- (주의 : mysql 5.7 이하 버전은 지원하지 않는다)

-- 메모리 상 가상 테이블을 만들어 임시로 저장시켜둔다.
-- 재귀쿼리를 이용하여 실제로 테이블을 생성하거나,
--    데이터 삽입(INSERT)를 사용하지 않아도 가상 테이블을 생성할 수 있다.

WITH RECURSIVE 테이블명 AS (
	SELECT 초기값 AS 컬럼별명1
	UNION ALL
	SELECT 컬럼별명1 계산식 FROM 테이블명 WHERE 제어문
	)


-- 프머스 3-4에서 0~23 hour 단위의 빈 테이블을 만드는 것에 쓰인다.--
WITH RECURSIVE TEMP AS (
	SELECT 0 AS HOUR
	UNION ALL
	SELECT HOUR +1 FROM TEMP
	WHERE HOUR < 23
	)

SELECT HOUR, COUNT(ANIMAL_OUTS.DATETIME) AS COUNT
FROM TEMP
LEFT JOIN ANIMAL_OUTS
			ON TEMP.HOUR = HOUR(ANIMAL_OUTS.DATETIME)
GROUP BY HOUR; 

----


-- https://www.mysqltutorial.org/mysql-recursive-cte/
-- 참조 블로그1 : https://hyunmin1906.tistory.com/149
-- 참조 블로그2 : https://alreadythehomeofmyheart.tistory.com/5
