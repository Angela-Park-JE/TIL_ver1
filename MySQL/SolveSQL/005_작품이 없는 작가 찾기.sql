/*
연습 문제> 작품이 없는 작가 찾기 
https://solvesql.com/problems/artists-without-artworks/
*/

-- 240411: 각 연결을 어떻게 할 것인지 테이블 내용만 파악을 잘 하면 어려울 것 없었던 문제
-- MoMA에 등록된 아티스트 = ar, 등록된 작품들 = wo, 등록된 작품과 그의 아티스트들 = woar
SELECT  ar.artist_id
      , ar.name
  FROM  ARTWORKS wo 
        LEFT JOIN ARTWORKS_ARTISTS woar
          ON wo.artwork_id = woar.artwork_id
        FULL JOIN ARTISTS ar
          ON woar.artist_id = ar.artist_id
 WHERE  ar.death_year IS NOT NULL
   AND  woar.artwork_id IS NULL;
