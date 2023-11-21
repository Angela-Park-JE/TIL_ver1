
# 코딩테스트 연습 > 해시 > 완주하지 못한 선수

# https://school.programmers.co.kr/learn/courses/30/lessons/42576

def solution(participant, completion):
    dict_p = dict.fromkeys(participant, 0)
    for i in completion:
        dict_p[i] += 1
    for j in dict_p:
        if dict_p[j] == 0:
            answer = j
        else:
            continue
    return answer
