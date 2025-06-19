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
