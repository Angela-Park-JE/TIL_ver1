"""
프로그래밍 강의> 알고리즘 문제 해설> 자릿수 더하기
https://school.programmers.co.kr/learn/courses/18/lessons/1876

문제 설명
  자연수 N이 주어지면, N의 각 자릿수의 합을 구해서 return 하는 solution 함수를 만들어 주세요.
  예를들어 N = 123이면 1 + 2 + 3 = 6을 return 하면 됩니다.

제한사항
  N의 범위 : 100,000,000 이하의 자연수
"""



# 23.11.16
def solution(n):
    N = [int(i) for i in str(n)]
    answer = sum(N)

    return answer
