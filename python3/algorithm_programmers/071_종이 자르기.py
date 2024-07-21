# 코딩테스트 연습> 코딩테스트 입문> 종이 자르기
# https://school.programmers.co.kr/learn/courses/30/lessons/120922
#   정수 M, N이 매개변수로 주어질 때, M x N 크기의 종이를 최소로 가위질 해야하는 횟수를 return 하도록 solution 함수를 완성해보세요. (종이를 겹쳐서 자를 수 없습니다.)


# 24.07.21: 겹쳐서 자를 수 없다는 것이 핵심...
def solution(M, N):
    n = M*N -1
    return n
