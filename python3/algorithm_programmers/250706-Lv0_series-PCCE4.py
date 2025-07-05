## PCCE4 : 빈칸 채우기
# https://school.programmers.co.kr/learn/courses/30/lessons/250130
# 저축관련. 변수를 어떻게 넣는가 정도.

start = int(input())
before = int(input())
after = int(input())

money = start
month = 1
while money < 70:
    money += before  # before 자리
    month += 1
while money < 100:  # money 자
    money += after  # 이 줄
    month += 1
print(month)



## ---
# 250707
## PCCE5 : 빈칸채우기
# https://school.programmers.co.kr/learn/courses/30/lessons/250129

def solution(route):
    east = 0
    north = 0
    for i in route:
        if i == "N":
            north += 1
        elif i == "S" :
            north -= 1
        elif i == "E" :
            east += 1
        elif i == 'W' :
            east -= 1

    return [east, north]
