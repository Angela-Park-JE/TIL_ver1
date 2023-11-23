"""
코딩테스트 연습 > 해시 > 완주하지 못한 선수
https://school.programmers.co.kr/learn/courses/30/lessons/42576

문제 설명
  수많은 마라톤 선수들이 마라톤에 참여하였습니다. 단 한 명의 선수를 제외하고는 모든 선수가 마라톤을 완주하였습니다.
마라톤에 참여한 선수들의 이름이 담긴 배열 participant와 완주한 선수들의 이름이 담긴 배열 completion이 주어질 때, 완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성해주세요.

제한사항
  마라톤 경기에 참여한 선수의 수는 1명 이상 100,000명 이하입니다.
  completion의 길이는 participant의 길이보다 1 작습니다.
  참가자의 이름은 1개 이상 20개 이하의 알파벳 소문자로 이루어져 있습니다.
  참가자 중에는 동명이인이 있을 수 있습니다.
"""



# 231123: 정렬후 대조하는 방식이나... 나중에 다시또 풀어봐야겠다는 생각이다.
# (1) 먼저 선수가 1명인 경우를 생각하고 (같은 문제에서 런타임에러가 뜬다는 분의 질문의 답변을 보고 힌트를 얻음. 전혀 생각못했다...)
# (2) 정렬 상 마지막만 다른 경우 마지막선수가 answer가되도록 하고
# (3) 다른 경우는 일일히 대조하며 같지 않은 경우의 선수이름을 데려온다. 
# 정확성: 58.3 | 효율성: 41.7 | 합계: 100.0 / 100.0
def solution(participant, completion):
    participant.sort()
    completion.sort()
    answer = 0
    if len(participant) == 1:
        answer = participant[0]
    elif participant[-1] != completion[-1]:
        answer = participant[-1]
    else:
        for i in range(len(completion)):
            if participant[i]==completion[i]:
                continue
            else:
                answer = participant[i]
                break
    return answer
# 같은 것이지만 리스트컴프리헨션을 쓰고자 했던 것
def solution(participant, completion):
    participant.sort()
    completion.sort()
    answer = 0
    if len(participant) == 1:
        answer = participant[0]
        return answer
    elif participant[-1] != completion[-1]:
        answer = participant[-1]
        return answer
    else:
        someone = [participant[i] for i in range(len(completion)) if participant[i]!=completion[i]]
        return someone[0]



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

# 231123: 정렬후 끝이 같은지 확인하고(for문때문에 먼저 검사)
# 같은지 대조하는 방식으로 다른 것을 찾아내는 방식. 같으면 바로 종료하도록 break를 추가했다.
# 그러나 문제 하나에서 런타임에러가 발생했다
def solution(participant, completion):
    participant.sort()
    completion.sort()
    answer = 0
    if participant[-1] != completion[-1]:
        answer = participant[-1]
    else:
        for i in range(len(completion)):
            if participant[i]==completion[i]:
                continue
            else:
                answer = participant[i]
                break
    return answer
