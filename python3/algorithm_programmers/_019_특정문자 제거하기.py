"""
코딩테스트 연습> 코딩테스트 입문> 특정 문자 제거하기
https://school.programmers.co.kr/learn/courses/30/lessons/120826
문제 설명
  문자열 my_string과 문자 letter이 매개변수로 주어집니다. my_string에서 letter를 제거한 문자열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ my_string의 길이 ≤ 100
  letter은 길이가 1인 영문자입니다.
  my_string과 letter은 알파벳 대소문자로 이루어져 있습니다.
  대문자와 소문자를 구분합니다.
"""


# 23.04.22
# llst를 따로 만들지 않아도 되긴 하지만 계속 사용되는 것에 대해서는 하나로 만들어두는게 마음이 편한 느낌이 든다.
# 그래봤자 my_string을 도는 동안이긴 하지만 말이다.
def solution(my_string, letter):
    llist = list(letter)
    for l in my_string:
        if l in llist:
            my_string = my_string.replace(l, '')
    return my_string
