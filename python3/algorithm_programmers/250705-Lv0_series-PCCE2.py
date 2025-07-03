## PCCE2 디버깅 
# https://school.programmers.co.kr/learn/courses/30/lessons/250132
# 직각삼각형에서 빗변과 한 변이 주어졌을 때 다른 한 변의 제곱

a = int(input())
c = int(input())

b_square = (c**2 - a**2)  # c - a 로 되어있었음
print(b_square)



## PCCE3 빈칸 채우기 
# https://school.programmers.co.kr/learn/courses/30/lessons/250131
# 문제 읽고 그저 빈칸을... 왜 이런문제가 나오지 : 연나이와 만나이
year = int(input())
age_type = input()

if age_type == "Korea":
    answer = 2030-year+1
elif age_type == "Year":
    answer = 2030-year

print(answer)
