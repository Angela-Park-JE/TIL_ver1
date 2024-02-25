"""
코딩테스트 연습> 코딩테스트 입문> 세균 증식
https://school.programmers.co.kr/learn/courses/30/lessons/120910
문제 설명
  어떤 세균은 1시간에 두배만큼 증식한다고 합니다. 처음 세균의 마리수 n과 경과한 시간 t가 매개변수로 주어질 때 t시간 후 세균의 수를 return하도록 solution 함수를 완성해주세요.

제한사항
  1 ≤ n ≤ 10
  1 ≤ t ≤ 15
"""



# 24.02.26
def solution(n, t):
    return (2**t)*n


"""다른 풀이"""
# 비트 연산이라고 한다. 처음 보는 연산자...! t만큼 2의 제곱을 한다.
# 김현우 , 이찬우 , bse0789@gmail.com , 민영기 외 117 명
def solution(n, t):
    return n << t
