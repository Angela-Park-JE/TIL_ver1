"""
코딩테스트 연습> 코딩테스트 입문> 배열 회전시키기

문제 설명
정수가 담긴 배열 numbers와 문자열 direction가 매개변수로 주어집니다. 배열 numbers의 원소를 direction방향으로 한 칸씩 회전시킨 배열을 return하도록 solution 함수를 완성해주세요.

제한사항
3 ≤ numbers의 길이 ≤ 20
direction은 "left" 와 "right" 둘 중 하나입니다.
"""


# 23.05.02
# 왼쪽이면 하나씩 땡겨 첫 번째것을 뒤에 더하고 오른쪽이면 맨 뒤를 가져와 앞에 붙인다.
def solution(numbers, direction):
    if direction == 'left':
        answer = numbers[1:]+[numbers[0]]
    else:
        answer = [numbers[-1]]+numbers[:-1]
    return answer



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120844/solution_groups?language=python3

# DalHyun , ethan528 , 강영균 , imLim 외 55 명
# 한 줄에 내가 한 것을 넣어버린 ...코드
def solution(numbers, direction):
    return [numbers[-1]] + numbers[:-1] if direction == 'right' else numbers[1:] + [numbers[0]]


# 김종도 , 김겸호 , kti0940 , 강예빈 외 35 명
# deque 라는 함수를 사용한 방법
from collections import deque

def solution(numbers, direction):
    numbers = deque(numbers)
    if direction == 'right':
        numbers.rotate(1)
    else:
        numbers.rotate(-1)
    return list(numbers)
