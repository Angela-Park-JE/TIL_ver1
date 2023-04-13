"""
코딩테스트 연습> 코딩테스트 입문> 각도기
https://school.programmers.co.kr/learn/courses/30/lessons/120829
문제 설명
  각에서 0도 초과 90도 미만은 예각, 90도는 직각, 90도 초과 180도 미만은 둔각 180도는 평각으로 분류합니다. 
  각 angle이 매개변수로 주어질 때 예각일 때 1, 직각일 때 2, 둔각일 때 3, 평각일 때 4를 return하도록 solution 함수를 완성해주세요.
    예각 : 0 < angle < 90
    직각 : angle = 90
    둔각 : 90 < angle < 180
    평각 : angle = 180
제한사항
  0 < angle ≤ 180
  angle은 정수입니다.
"""


# 23.04.13
# 더 좋은 방법이 있을 것 같은데 생각이 나지 않는다.
# 원래는 나눈 몫과 나머지로 하려고 했으나 그게 더 복잡해지는 건 아닐까 싶어서 가장 직관적인 방법으로 하긴 했다.
def solution(angle):
    if angle == 180:
        answer = 4
    elif (90<angle) and (angle<180):
        answer = 3
    elif angle == 90:
        answer = 2
    else:
        answer = 1
    return answer
