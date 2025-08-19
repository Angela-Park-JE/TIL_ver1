"""
코딩테스트 연습> 코딩 기초 트레이닝> 수 조작하기 2
https://school.programmers.co.kr/learn/courses/30/lessons/181925?language=python3
수가 변하는 것을 보고 입력을 알아내는 것
"""


# 250815: 처음엔 각 수에 대해 묻는 줄 알았지만 변하는 값에 따라 어떤 입력이 있었는지 알아내는 것이었음.
def solution(numLog):
    answer = ''
    idx = range(len(numLog)-1)  # 인덱스로 사용할 int로, for문에서 +1을 사용하여 검사하므로 -1을 해야 range를 넘지 않음
    
    for i in idx:
        s = numLog[i+1] - numLog[i]  # 두 수 차이 검사
        
        if s == 0:  # 조작할 때마다 수가 바뀌므로 사실 0인 경우는 지워도 되긴 함...
            pass
        elif s == 1:
            answer += 'w'
        elif s == -1:
            answer += 's'
        elif s == 10:
            answer += 'd'
        else:
            answer += 'a'
    
    return answer



"""다른풀이"""
# https://school.programmers.co.kr/questions/88683
# 한줄이 가능한 것이었다... ㅎㅎ...
solution = lambda l:''.join({'1':'w','-1':'s','10':'d','-10':'a'}[str(l[i]-l[i-1])]for i in range(1,len(l)))
# range를 활용하여 인덱스를 만들고, 하나씩 뺀 인덱스를 기준으로 계산 후 차이를 딕셔너리로 맵핑한다
