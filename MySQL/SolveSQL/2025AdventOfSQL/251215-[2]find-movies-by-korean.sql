/*
한국 감독 영화
https://solvesql.com/problems/find-movies-by-korean-artists/
*/


-- 251215: 260330 쉽게 풀어버린
-- -- 먼저 한국은 어떤식으로 표기되어있나 확인 후 
-- SELECT  DISTINCT nationality
-- FROM  artists
-- ORDER  BY 1
-- ;
-- -- 'Korean' 이라고 되어있음

SELECT  arti.name AS artist
      , aw.title AS title
  FROM  artworks aw
        LEFT JOIN artworks_artists aa ON aw.artwork_id = aa.artwork_id
        LEFT JOIN artists arti ON aa.artist_id = arti.artist_id 
 WHERE  aw.classification LIKE 'Film%' 
   AND  arti.nationality = 'Korean'
;
