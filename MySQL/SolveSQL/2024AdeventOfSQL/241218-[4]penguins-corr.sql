/*
특정 생물의 종 별로 x, y의 상관관계 구하기
https://solvesql.com/problems/correlation-penguin/
*/


-- 250106: 역시! null 데이터 때문에 값이 일그러진 듯 했다. 이 부분이 조건에 따로 언급되지 않더라도 늘 확인하고 해봐야겠다.
WITH base_temp_table AS
      (
        SELECT  species
              , flipper_length_mm AS x
              , body_mass_g AS y
          FROM  penguins
         WHERE  flipper_length_mm IS NOT NULL AND body_mass_g IS NOT NULL -- POINT!
      ),  -- 종 별로 계산하여 뱉도록 쓰일 것. 종 별로 x, y라는 컬럼명을 갖도록 해본다.
     species_table AS
      (
        SELECT  DISTINCT species AS species
          FROM  penguins
      )
     
SELECT  species
      , 
        (
          SELECT  ROUND(  ( count(*) * sum(x * y) - sum(x) * sum(y) ) / 
                          ( sqrt( count(*) * sum(x * x) - sum(x) * sum(x) ) * sqrt( count(*) * sum(y * y) - sum(y) * sum(y) ) ),   3) AS corr
            FROM  base_temp_table
           WHERE  base_temp_table.species = species_table.species
        ) AS corr
  FROM  species_table
;


/*오답노트*/

-- 250104: CORR 함수가 따로 없으니 일일히 구해야 하므로 그 부분만 stackoverflow을 참조하였다. : https://stackoverflow.com/questions/2457645/mysql-math-is-it-possible-to-calculate-a-correlation-in-a-query
-- 종만 가지고 있는 테이블을 가지고 SELECT 문에서 타 테이블을 참조해 값을 계산하여 데려오도록 한 쿼리이다.
-- 그러나 틀린 이유는 값이 달라서였다. 보통 이럴 때에는 null의 문제가 있다. 그래서 null 체크 후 해보았다 (한 데이터포인트에 x나 y가 null일 경우 해당 포인트를 사용하지 않도록 함)

WITH base_temp_table AS
      (
        SELECT  species
              , flipper_length_mm AS x
              , body_mass_g AS y
          FROM  penguins
      ),  -- 종 별로 계산하여 뱉도록 쓰일 것. 종 별로 x, y라는 컬럼명을 갖도록 해본다.
     species_table AS
      (
        SELECT  DISTINCT species AS species
          FROM  penguins
      )
     

SELECT  species
      , 
        (
          SELECT  ( count(*) * sum(x * y) - sum(x) * sum(y) ) / 
                  ( sqrt( count(*) * sum(x * x) - sum(x) * sum(x) ) * sqrt( count(*) * sum(y * y) - sum(y) * sum(y) ) ) AS corr
            FROM  base_temp_table
           WHERE  base_temp_table.species = species_table.species
        ) AS corr
  FROM  species_table
;


/* 참고로 (해답을) SQL 포맷팅을 적용했더니 다음과 같다. 다른 줄은 괜찮지만 메인 쿼리의 ROUND() 부분은 읽기 편한건지 아닌지 모르겠다. 매일같이 쓰다보면 느껴질까 */
WITH
  base_temp_table AS (
    SELECT
      species,
      flipper_length_mm AS x,
      body_mass_g AS y
    FROM
      penguins
    WHERE
      flipper_length_mm IS NOT NULL
      AND body_mass_g IS NOT NULL 
  ), 
  species_table AS (
    SELECT DISTINCT
      species AS species
    FROM
      penguins
  )
SELECT
  species,
  (
    SELECT
      ROUND(
        (count(*) * sum(x * y) - sum(x) * sum(y)) / (
          sqrt(count(*) * sum(x * x) - sum(x) * sum(x)) * sqrt(count(*) * sum(y * y) - sum(y) * sum(y))
        ),
        3
      ) AS corr
    FROM
      base_temp_table
    WHERE
      base_temp_table.species = species_table.species
  ) AS corr
FROM
  species_table;
