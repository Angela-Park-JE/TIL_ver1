-- 250310: 입문반 캠프 문제인데 문제가 보이길래 풀어본 문제
SELECT  DISTINCT artist_id
      , name
  FROM  artists a
 WHERE  artist_id NOT IN (SELECT  DISTINCT artist_id FROM artworks_artists)
;
