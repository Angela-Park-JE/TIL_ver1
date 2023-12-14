"""
코딩테스트 연습> 코딩테스트 입문> 옹알이 (1)
https://school.programmers.co.kr/learn/courses/30/lessons/120956
문제 설명
  머쓱이는 태어난 지 6개월 된 조카를 돌보고 있습니다. 조카는 아직 "aya", "ye", "woo", "ma" 네 가지 발음을 최대 한 번씩 사용해 조합한(이어 붙인) 발음밖에 하지 못합니다. 
  문자열 배열 babbling이 매개변수로 주어질 때, 머쓱이의 조카가 발음할 수 있는 단어의 개수를 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ babbling의 길이 ≤ 100
  1 ≤ babbling[i]의 길이 ≤ 15
  babbling의 각 문자열에서 "aya", "ye", "woo", "ma"는 각각 최대 한 번씩만 등장합니다.
  즉, 각 문자열의 가능한 모든 부분 문자열 중에서 "aya", "ye", "woo", "ma"가 한 번씩만 등장합니다.
  문자열은 알파벳 소문자로만 이루어져 있습니다.
"""



# 23.12.15: 조금 헤맸던 부분이 (1)replace를 하면 재할당을 해주어야하는 점 
# (2) 'wyeoo' : 처음엔 ''로 replace하고 len(w) ==0 으로 검사했는데 wyeoo('ye'치환) -> woo('woo'치환) 으로 통과되지 않아야할게 통과되면서 카운트가 올라갔던 점
# 따라서 처음에 떠올랐던 아이디어 그대로 ' ' 공백으로 넣어주고 strip으로 공백만 있는지 없는지 검사한다.
def solution(babbling):
    possible = ["aya", "ye", "woo", "ma"]
    answer = 0
    for w in babbling:
        # 공백으로 바꾸되 길이가 15이기 때문에 최대 7번이다('ye'*7)
        for i in possible:
            w = w.replace(i, ' ', 7)
        # 공백으로 바꾸기 때문에 한번 바뀌고 잘린건 ('wyeoo'의 'w oo') 더이상 위for에서 바꾸어지지 않고 다음에서 걸린다.
        if len(w.strip()) == 0:
            answer += 1

    return answer
