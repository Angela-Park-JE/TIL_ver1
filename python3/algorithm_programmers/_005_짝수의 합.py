"""
코딩테스트 연습> 코딩테스트 입문> 짝수의 합 (lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120831?language=python3
문제 설명
  정수 n이 주어질 때, n이하의 짝수를 모두 더한 값을 return 하도록 solution 함수를 작성해주세요.
제한사항
  0 < n ≤ 1000
"""



# 23.04.13
# n이 홀수이면 1을 뺀 다음, n이 짝수이면 그대로, n이 0이 될때까지 2씩 빼면서 더한다.
def solution(n):
    answer = 0
    if n%2 == 1:
        n = n-1
    else:
        n = n
    while n != 0:
        answer += n
        n -= 2
    return answer
