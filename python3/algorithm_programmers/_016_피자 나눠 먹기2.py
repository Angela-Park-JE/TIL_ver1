"""
코딩테스트 연습> 코딩테스트 입문> 피자 나눠 먹기 (2) (lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120815#
문제 설명
  머쓱이네 피자가게는 피자를 여섯 조각으로 잘라 줍니다. 피자를 나눠먹을 사람의 수 n이 매개변수로 주어질 때, 
  n명이 주문한 피자를 남기지 않고 모두 같은 수의 피자 조각을 먹어야 한다면 최소 몇 판을 시켜야 하는지를 return 하도록 solution 함수를 완성해보세요.
제한사항
  1 ≤ n ≤ 100
"""



# 23.04.19
# 무서운 피자가게임 강제로 n과 6의 최소공배수 만큼의 조각을 소비해야함
# 며칠전에 해놓고도 좀 헷갈려서 이전 로직을 쓰기로 했다. while n3 != 0: 으로 하려했는데 ㅠㅠ
def solution(n):

    if n%6 == 0:
        return n//6
    
    # lowest common multiple
    if n<6:
        n1, n2 = 6, n
    else:
        n1, n2 = n, 6
    
    while 1==1:
        n3 = n1 % n2
        if n3 == 0:
            break
        else:
            n1, n2 = n2, n3
    # lcm = n*6/n2
    
    return n/n2
