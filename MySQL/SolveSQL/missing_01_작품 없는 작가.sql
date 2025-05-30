-- 250310: 입문반 캠프 문제인데 문제가 보이길래 풀어본 문제
-- 분명 있었는데 출처 찾으려니까 문제가 없음...ㅠㅠ
SELECT  DISTINCT artist_id
      , name
  FROM  artists a
 WHERE  artist_id NOT IN (SELECT  DISTINCT artist_id FROM artworks_artists)
;
