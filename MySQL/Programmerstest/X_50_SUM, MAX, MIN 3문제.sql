"""
코딩테스트 연습> SUM, MAX, MIN> 조건에 맞는 아이템들의 가격의 총합 구하기
https://school.programmers.co.kr/learn/courses/30/lessons/273709
문제
  ITEM_INFO 테이블에서 희귀도가 'LEGEND'인 아이템들의 가격의 총합을 구하는 SQL문을 작성해 주세요. 이때 컬럼명은 'TOTAL_PRICE'로 지정해 주세요.
"""

-- 240414: 쉽지만 새로 
SELECT  SUM(price) AS TOTAL_PRICE
  FROM  ITEM_INFO
 WHERE  rarity = 'LEGEND'
 GROUP  BY rarity;



"""
코딩테스트 연습> SUM, MAX, MIN> 물고기 종류 별 대어 찾기
https://school.programmers.co.kr/learn/courses/30/lessons/293261
문제
  물고기 종류 별로 가장 큰 물고기의 ID, 물고기 이름, 길이를 출력하는 SQL 문을 작성해주세요.
  물고기의 ID 컬럼명은 ID, 이름 컬럼명은 FISH_NAME, 길이 컬럼명은 LENGTH로 해주세요.
  결과는 물고기의 ID에 대해 오름차순 정렬해주세요.
  단, 물고기 종류별 가장 큰 물고기는 1마리만 있으며 10cm 이하의 물고기가 가장 큰 경우는 없습니다.
"""

-- 240414: MySQL에서는 rank라는 단어는 예약어로 사용할 수 없다.
SELECT  id
      , fish_name
      , length
  FROM  
        (
            SELECT  id 
                  , ROW_NUMBER() OVER (PARTITION BY fi.fish_type ORDER BY length DESC) AS rnk
                  , length
                  , fish_name
              FROM  FISH_INFO fi LEFT JOIN FISH_NAME_INFO fni ON fi.fish_type = fni.fish_type
        ) tmp
 WHERE  rnk = 1
 ORDER  BY id;



"""
코딩테스트 연습> SUM, MAX, MIN> 연도별 대장균 크기의 편차 구하기 
https://school.programmers.co.kr/learn/courses/30/lessons/299310
문제
  분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
  분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 결과는 연도에 대해 오름차순으로 정렬하고 
  같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬해주세요.
"""



"""오답노트"""
-- 240414: 서브쿼리는 잘 되지만 YEAR로 묶는 지점에서 오류가 난다.
-- (1370, "execute command denied to user 'test'@'%' for routine 'e.YEAR'")
SELECT  YEAR(differentiation_date) AS YEAR
      , maxsize - size_of_colony AS YEAR_DEV
      , id
  FROM  ECOLI_DATA e
        LEFT JOIN 
                (
                SELECT  YEAR(differentiation_date) AS YEAR
                      , MAX(size_of_colony) AS maxsize
                  FROM  ECOLI_DATA
                 GROUP  BY 1
                ) tmp ON e.YEAR(differentiation_date) = tmp.YEAR

-- 240415: 윈도우함수로 구했는데 답이 잘 나오는 것으로 보이는데 정답이 아니라고 한다.
SELECT  YEAR(differentiation_date) AS YEAR
      , MAX(size_of_colony) OVER (PARTITION BY YEAR(differentiation_date)) - size_of_colony AS maxsize
      , id
  FROM  ECOLI_DATA
 ORDER  BY 1, 2;


