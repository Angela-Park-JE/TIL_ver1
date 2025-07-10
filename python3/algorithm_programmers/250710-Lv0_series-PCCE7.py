## PCCE7 가습기 모드 : 빈칸 채우기
# https://school.programmers.co.kr/learn/courses/30/lessons/250127
# 쓰여진 함수를 이해할 수 있는가 정도아닐까... 주어진 문제를 읽고 그 프로그래밍이 함수에 잘 들어가있나 확인 후 적절한 함수 배치.
# '#' 달아둔 부분이 빈칸이 있던 곳

def func1(humidity, val_set):
    if humidity < val_set:
        return 3  #  
    return 1

def func2(humidity):
    if humidity >= 50:
        return 0
    elif humidity >= 40:
        return 1
    elif humidity >= 30:
        return 2
    elif humidity >= 20:
        return 3
    elif humidity >= 10:
        return 4
    else:  #
        return 5  #

def func3(humidity, val_set):
    if humidity < val_set:
        return 1
    return 0


def solution(mode_type, humidity, val_set):
    answer = 0
    if mode_type == "auto":
        answer = func2(humidity)  #

    elif mode_type == "target":
        answer = func1(humidity, val_set)  #

    elif mode_type == "minimum":
        answer = func3(humidity, val_set)  #

    return answer
