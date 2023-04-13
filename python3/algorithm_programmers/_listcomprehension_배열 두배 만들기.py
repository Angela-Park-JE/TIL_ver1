"""
코딩테스트 연습> 코딩테스트 입문> 배열 두 배 만들기
https://school.programmers.co.kr/learn/courses/30/lessons/120809
문제 설명
  정수 배열 numbers가 매개변수로 주어집니다. numbers의 각 원소에 두배한 원소를 가진 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  -10,000 ≤ numbers의 원소 ≤ 10,000
  1 ≤ numbers의 길이 ≤ 1,000
"""


# 23.04.14
# 머리보다 몸이 기억하는 list comprehension 
# 혼자 쓰면서 오모오모... 하고 제출 누른 나 조금 잘했어
def solution(numbers):
    answer = [x*2 for x in numbers]
    return answer
