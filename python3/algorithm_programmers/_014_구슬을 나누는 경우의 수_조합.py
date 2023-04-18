"""
코딩테스트 연습> 코딩테스트 입문> 구슬을 나누는 경우의 수(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120840
문제 설명
  머쓱이는 구슬을 친구들에게 나누어주려고 합니다. 구슬은 모두 다르게 생겼습니다. 
  머쓱이가 갖고 있는 구슬의 개수 balls와 친구들에게 나누어 줄 구슬 개수 share이 매개변수로 주어질 때, 
  balls개의 구슬 중 share개의 구슬을 고르는 가능한 모든 경우의 수를 return 하는 solution 함수를 완성해주세요.
제한사항
  1 ≤ balls ≤ 30
  1 ≤ share ≤ 30
  구슬을 고르는 순서는 고려하지 않습니다.
  share ≤ balls
"""



# 23.04.18
# 완전히 '조합' 문제
# 먼저 썼던것
def solution(balls, share):
    k = 1
    # n combination m
    for i in range(share, balls+1):
        k *= i
    for j in range(1, share+1):
        k /= j
    
    answer = k
    return answer

# 위를 zip()을 사용해 보완한 것
def solution(balls, share):
    k = 1
    # n combination m
    for n, m in zip(range(share, balls+1), range(1, share+1)):
        k *= n
        k /= m
    
    answer = k
    return answer
