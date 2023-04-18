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
# 이건 전부 통과가 된다.
def solution(balls, share):
    k = 1
    # n combination m
    for n, m in zip(range(balls-share+1, balls+1), range(1, share+1)):
        k = k*n/m
    
    answer = k
    return answer



"""오답노트"""

# 처음에 썼었고, 테스트 케이스에서 잘 돌아갔다. 그래서 줄이고자 zip()을 사용하여 보완하였다.
# 정확히 한 문제에서 제대로 돌아가질 않는다. (34번 케이스) 결국 같은 식인데, 문제가 무엇인지 모르겠다. 그래서 질문을 올려두었다.
# https://school.programmers.co.kr/questions/47618
def solution(balls, share):
    k = 1
    # n combination m
    for n in range(balls-share+1, balls+1):
        k *= n
    for m in range(1, share+1):
        k /= m
    
    answer = k
    return answer
