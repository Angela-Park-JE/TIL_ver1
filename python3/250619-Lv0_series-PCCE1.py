# PCCE 1번 문자 출력: 출력문에 빈칸 채우기
# escape '\'과 '\n'으로 줄바꿈을 할 수 있는지 묻는 문제

message = "Let's go!"

print("3\n2\n1")
print(message)


# ---
# PCCE 2번 각도 합치기: sum_angle에 디버깅
# 사칙연산을 할 줄 아는지의 문제. 

angle1 = int(input())
angle2 = int(input())

sum_angle = (angle1 + angle2)%360
print(sum_angle)



# ---
# PCCE 3번 수 나누기: range(1)에 디버깅
# https://school.programmers.co.kr/learn/courses/30/lessons/340205
# 주어진 것
number = int(input())

answer = 0

for i in range(1):
    answer += number % 100
    number //= 100

print(answer)
# 고친 것: 자리를 계속 잘라가며 해야한다.
# 근데 앞에서부터인지 뒤에서부터인지 다를텐데 그냥 뒤에서 부터로 자연스레 통일인가봄(?)
for i in range(len(str(number))+1):
# 틀린 점: 두 자리씩 끊기 때문에 끝나고서도 0을 더하는 일이 발생.
# 다음을 하거나
for i in range(len(str(number))//2):
# 다음을 하는게 더 맞음
while number > 0:

# //= 는 나누고 소수점은 버리고 저장.
