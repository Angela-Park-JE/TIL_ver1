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



## PCCE 7번: 빈칸
#  https://school.programmers.co.kr/learn/courses/30/lessons/340201
#  function 네 가지를 주고 어떤 것을 어떻게 넣을지 적으라고 한다. 순간 맨 아래만 엥? 아! 싶은 문제였다. 
def func1(num):
    if 0 > num:
        return 0
    else:
        return num

def func2(num):
    if num > 0:
        return 0
    else:
        return num

def func3(station):
    num = 0
    for people in station:
        if people == "Off":
            num += 1
    return num

def func4(station):
    num = 0
    for people in station:
        if people == "On":
            num += 1
    return num


def solution(seat, passengers):
    num_passenger = 0
    for station in passengers:
        num_passenger += func4(station) # 탄 사람~

        num_passenger -= func3(station) # 내린 사람~

    answer = func1(seat-num_passenger) # 그래서 좌석-승객이 양수니?

    return answer
