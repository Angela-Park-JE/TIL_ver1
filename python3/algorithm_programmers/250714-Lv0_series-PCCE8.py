# PCCE 8번 같은 물건은 정리하여 숫자 세기 : 디버깅
# https://school.programmers.co.kr/learn/courses/30/lessons/250126
# 그냥 대충 훑어도 어디가 문제인지 바로 보일 정도의 문제 

def solution(storage, num):
    clean_storage = []
    clean_num = []
    for i in range(len(storage)):
        if storage[i] in clean_storage:
            pos = clean_storage.index(storage[i])
            clean_num[pos] += num[i]
        else:
            clean_storage.append(storage[i]) # storage[i]가 아니라 num[i]로 되어있었던
            clean_num.append(num[i])
            
    # 아래 코드에는 틀린 부분이 없습니다.
            
    max_num = max(clean_num)
    answer = clean_storage[clean_num.index(max_num)]
    return answer
