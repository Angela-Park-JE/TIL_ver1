# 250707
## PCCE6 가채점 : 디버깅
# https://school.programmers.co.kr/learn/courses/30/lessons/250128
# 인덱스를 제대로 활용할 줄 아시나요?

def solution(numbers, our_score, score_list):
    answer = []
    for i in range(len(numbers)):
        if our_score[i] == score_list[numbers[i]-1]:   # 원래 : if numbers[our_score[i]] == score_list[i]:
            answer.append("Same")
        else:
            answer.append("Different")
    
    return answer
