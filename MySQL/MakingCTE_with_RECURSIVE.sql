-- WITH RECURSIVE 문 
-- (주의 : mysql 5.7 이하 버전은 지원하지 않는다)

-- 메모리 상 가상 테이블을 만들어 임시로 저장시켜둔다.
-- 재귀쿼리(자기 자신을 다시 참조하여 결과를 만드는 쿼리)를 이용하여 실제로 테이블을 생성하거나,
--    데이터 삽입(INSERT)를 사용하지 않아도 가상 테이블을 생성할 수 있다.
-- 계층적 구조를 가진 데이터를 다룰 때 좋다.


WITH RECURSIVE 테이블명 AS (
	SELECT 초기값 AS 컬럼별명1
	UNION ALL
	SELECT 컬럼별명1 계산식 FROM 테이블명 WHERE 제어문
	)


-- 프머스 3-4에서 0~23 hour 단위의 빈 테이블을 만드는 것에 쓰인다.--
WITH RECURSIVE TEMP AS (
	SELECT 0 AS hours 			-- 앵커 멤버 (Anchor member), 자기 자신을 참조하지 않음.
	UNION ALL					-- 중복 데이터를 빼고 싶다면 UNION 만 쓰게 된다.	
	SELECT hours + 1 FROM TEMP  -- 재귀 멤버 (Recursive member), 재퀴 쿼리 실행 결과를 참조
	WHERE hours < 23
	)

SELECT hours, COUNT(ANIMAL_OUTS.DATETIME) AS COUNT
FROM TEMP						-- 재귀쿼리로 만든 TEMP를 사용하는 부분
LEFT JOIN ANIMAL_OUTS
			ON TEMP.hours = HOUR(ANIMAL_OUTS.DATETIME)
GROUP BY hours; 

----

-- CTE 는 Non-recursive 타입과 Recursive 타입 두 종류로 나뉜다. 
-- https://www.mysqltutorial.org/mysql-recursive-cte/
-- 참조 블로그1 : https://hyunmin1906.tistory.com/149
-- 참조 블로그2 : https://alreadythehomeofmyheart.tistory.com/5
