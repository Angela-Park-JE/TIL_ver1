## PCCE 6번: 디버깅
#  https://school.programmers.co.kr/learn/courses/30/lessons/340202
#  usage는 매달 바뀌어야 하므로 처음부터 0나오게 하는 부분인건 바로 눈치채야 한다.
def solution(storage, usage, change):
    total_usage = 0
    for i in range(len(change)):
      # usage = total_usage * change[i]/100 # 원래 문제
        usage = usage * (1+change[i]/100)
        total_usage += usage
        if total_usage > storage:
            return i
    
    return -1
