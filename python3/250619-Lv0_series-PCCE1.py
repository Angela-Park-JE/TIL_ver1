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
