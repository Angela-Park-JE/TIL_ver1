"""
  유사한 문제 풀이(유튜브 techTFQ) : https://www.youtube.com/watch?v=ka9kDqkITX4
  블로그 정리 : 
특정 유저와 친구인 사람이 한 명씩 등록되어 있다고 해보자.
일반적인 친구 목록과는 달리 한 유저에 한 유저씩 등록되어 있었다.
A와 B가 친구고 B가 C와 친구면 B는 A와 C의 mutual friend라고 할 수 있다.
두 계정 사이에 mutual friends가 많을 수록 현실에서 친구일 가능성이 높다.
즉 A와 C는 B같은 친구가 많을수록 실제 친구일 가능성이 높은 것.
특정 계정과 친구일 가능성이 가장 높은 친구를 검색한다.

FRIENDS 테이블 구조는 ID1 과 ID2만 있다.

문제에서 알려져있는 상태로 구한다면 조건은 이렇게 만들 수 있다.
mutual friend를 구하기 위해서는
A라는 사람의 
  (1) ID2가 서로 같은 사람
  (2) ID1에 있는 사람의 ID2 사람의 ID1가 A 일때 
  
셀프조인으로 풀려고 했는데 맞는지 어려웠던 것으로 기억한다.
"""


-- 240516:
WITH all_friends AS 
	(
    SELECT  friend1, friend2
	  FROM  MUTUAL_FRIENDS2
	 UNION  ALL
	SELECT  friend2, friend1
	  FROM  MUTUAL_FRIENDS2
    )

SELECT  f.*
	  , af.friend2 AS mutual_friends
      -- (2) WINDOW 함수로 세기 : 다중컬럼 비교시 "f.friend1, f.friend2" 처럼 나열하기!
      , COUNT(af.friend2) OVER (PARTITION BY f.friend1, f.friend2 ORDER BY f.friend1, f.friend2
                        	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS cnt 
  FROM  MUTUAL_FRIENDS2 f
		LEFT JOIN all_friends af  -- (1) LEFT JOIN으로 바꿈 
        ON f.friend1 = af.friend1
            AND af.friend2 IN (
                        SELECT  af2.friend2 
                          FROM  all_friends af2
                         WHERE  af2.friend1 = f.friend2)
 ORDER  BY 1
 ;
