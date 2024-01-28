"""
코딩테스트 연습> 코딩테스트 입문> 삼각형의 완성조건 (2)
https://school.programmers.co.kr/learn/courses/30/lessons/120868
문제 설명
  선분 세 개로 삼각형을 만들기 위해서는 다음과 같은 조건을 만족해야 합니다.
  가장 긴 변의 길이는 다른 두 변의 길이의 합보다 작아야 합니다.
  삼각형의 두 변의 길이가 담긴 배열 sides이 매개변수로 주어집니다. 나머지 한 변이 될 수 있는 정수의 개수를 return하도록 solution 함수를 완성해주세요.

제한사항
  sides의 원소는 자연수입니다.
  sides의 길이는 2입니다.
  1 ≤ sides의 원소 ≤ 1,000
"""

# 24.01.28: 
def solution(sides):
    # 정수의 최소와 최대 범위를 구하여 그 사이 정수 개수를 센다
    mx, mn = sum(sides), max(sides) - min(sides)
    answer = [i for i in range(mn+1, mx)]
    return len(answer)

"""다른 풀이"""
# 결국 정리하면 같은 이야기가 된다. 근데 이렇게 할 생각은 못했다.
# 김종도 , 신동건 , 원 , AllyHyeseongKim 외 68 명
def solution(sides):
    return sum(sides) - max(sides) + min(sides) - 1
# 이런 방법도 있다. 위의 수식을 정리하면 아래처럼 된다.
# 설명: 강민구: sum - max + min - 1인데, 배열의 원소는 2개 이고 사실상 합에서 최댓값을 뺀 값이 최솟값이므로 최솟값의 2배 - 1도 가능한겁니다.
# randomwons , 이윤건 , jh , 탈퇴한 사용자 외 288 명
def solution(sides):
    return 2 * min(sides) - 1
