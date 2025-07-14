"""
코딩테스트 연습>코딩 기초 트레이닝>수 조작하기 1
https://school.programmers.co.kr/learn/courses/30/lessons/181926
문제 설명
  정수 n과 문자열 control이 주어집니다. control은 "w", "a", "s", "d"의 4개의 문자로 이루어져 있으며, control의 앞에서부터 순서대로 문자에 따라 n의 값을 바꿉니다.
  "w" : n이 1 커집니다.
  "s" : n이 1 작아집니다.
  "d" : n이 10 커집니다.
  "a" : n이 10 작아집니다.
  위 규칙에 따라 n을 바꿨을 때 가장 마지막에 나오는 n의 값을 return 하는 solution 함수를 완성해 주세요.
제한사항
  -100,000 ≤ n ≤ 100,000
  1 ≤ control의 길이 ≤ 100,000
  control은 알파벳 소문자 "w", "a", "s", "d"로 이루어진 문자열입니다.
"""


# 250714: while 문으로 한 자리씩 앞에서 빼내어가면서 글자를 다 소진하면 stop된다.
def solution(n, control):
    while len(control) != 0:
        direction = control[0]
        if direction == 'w':
            n += 1
        elif direction == 's':
            n -= 1
        elif direction == 'd':
            n += 10
        else:
            n -= 10
        control = control[1:]

    return n
