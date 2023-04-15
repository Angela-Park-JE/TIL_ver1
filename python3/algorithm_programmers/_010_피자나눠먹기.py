"""
코딩테스트 연습> 코딩테스트 입문> 피자 나눠 먹기 (1)(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120814
문제 설명
  머쓱이네 피자가게는 피자를 일곱 조각으로 잘라 줍니다. 
  피자를 나눠먹을 사람의 수 n이 주어질 때, 모든 사람이 피자를 한 조각 이상 먹기 위해 필요한 피자의 수를 return 하는 solution 함수를 완성해보세요.
제한사항
  1 ≤ n ≤ 100
"""



# 23.04.15
# 먼저 7명 이하는 무조건 1판
# 만약 7로 나눴을 때 나머지가 0이면 정확히 한 조각씩 먹도록
# 그외 7로 나눴을 때 나머지가 0이 되지 않는 7명 초과는 n을 7로 나눈 몫 + 1판
def solution(n):
    if n//7 < 0:
        answer = 1
    elif n%7 == 0:
        answer = n//7
    else:
        answer = n//7 + 1
    
    return answer
