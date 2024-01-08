-- 문제1.(SQL) jd 컬럼을 ‘주요업무’, ‘자격요건’, ‘우대사항’, ‘혜택 및 복지’ 단어로 구분하여 컬럼을 4개로 나눠주세요.

-- 230108: 내 방식은 이렇다
-- ‘주요업무’, ‘자격요건’, ‘우대사항’, ‘혜택 및 복지’ 각각의 index를 뽑아둔다. 그 인덱스에서부터 가져오도록 메인쿼리를 짠다.
-- CHAR_LENGTH('주요업무') 식으로 '주요업무'가 시작되는 부분을 잘라버릴 생각도 있었는데, 
-- CHAR_LENGTH를 굳이 구해지는 것보다 그냥 글자수를 내가 더하는게 낫겠어서 더해버렸다. 덜 '코딩'스럽지만 효율을 위해서는 나을 수 있겠다.
-- 물론 +1을 따로 둘 필요도 없긴 하다. (나중에 스스로 확인 했을 때 이해하기 좋게)
WITH index_list AS
    (
    SELECT position_id, 
        INSTR(jd, '주요업무') +4 +1 AS index_resp, 
        INSTR(jd, '자격요건') +4 +1 AS index_qual,
        INSTR(jd, '우대사항') +4 +1 AS index_pref,
        INSTR(jd, '혜택 및 복지') +7 +1 AS index_bnft
      FROM data_challenge_202401.wanted_position
    --  LIMIT 10
    )

SELECT m.position_id, m.position, 
    SUBSTR(jd, index_resp, index_qual -index_resp -6) AS responsibilities, -- 엔터+다음글자4개+띄어쓰기
    SUBSTR(jd, index_qual, index_pref -index_qual -6) AS requirements,
    SUBSTR(jd, index_pref, index_bnft -index_pref -9) AS preference,       -- 엔터+다음글자7개+띄어쓰기
    SUBSTR(jd, index_bnft, CHAR_LENGTH(jd) -index_bnft -1) AS benefits     -- 마지막 엔터 지우기
FROM DB.positions AS m JOIN index_list AS l ON m.position_id = l.position_id
