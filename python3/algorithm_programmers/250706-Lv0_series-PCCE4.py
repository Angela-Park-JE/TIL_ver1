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



## PCCE5 : 
