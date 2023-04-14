"""
코딩테스트 연습> 코딩테스트 입문> 짝수는 싫어요
https://school.programmers.co.kr/learn/courses/30/lessons/120813
문제 설명
  정수 n이 매개변수로 주어질 때, n 이하의 홀수가 오름차순으로 담긴 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ n ≤ 100
"""


# 23.04.14 
# 더 좋은 방법이 있을 것 같은데...
def solution(n):
    answer = [1]
    i = 1
    while True:
        i += 2
        if i <= n:
            answer.append(i)
        else:
            break
    return answer
