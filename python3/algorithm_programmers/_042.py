
# 코딩테스트 연습 > 해시 > 완주하지 못한 선수

# https://school.programmers.co.kr/learn/courses/30/lessons/42576




"""오답노트"""
# 231118: dictionary로 키를 사람이름으로 하려 했으나 생각해보니 잘못됐다.
# 동명이인의 경우는 수가 맞는지 확인해야한다. 
def solution(participant, completion):
    dict_p = dict.fromkeys(participant, 0)
    answer = 0
    for i in completion:
        dict_p[i] += 1
    for j in dict_p:
        if dict_p[j] == 0:
            answer = j
        else:
            continue
    return answer

# 231123: participant에서 completion에 있는 것들을 하나씩 빼기로 한다.
def solution(participant, completion):
    for i in completion:
        participant.remove(i)
    return participant[0]
    # 그러나 효율성 테스트에서 시간 초과가 걸리고 만다.
