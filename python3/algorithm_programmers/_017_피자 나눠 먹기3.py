"""
코딩테스트 연습> 코딩테스트 입문> 피자 나눠 먹기 (3)
https://school.programmers.co.kr/learn/courses/30/lessons/120816
문제 설명
  머쓱이네 피자가게는 피자를 두 조각에서 열 조각까지 원하는 조각 수로 잘라줍니다. 피자 조각 수 slice와 피자를 먹는 사람의 수 n이 매개변수로 주어질 때, n명의 사람이 최소 한 조각 이상 피자를 먹으려면 최소 몇 판의 피자를 시켜야 하는지를 return 하도록 solution 함수를 완성해보세요.
제한사항
  2 ≤ slice ≤ 10
  1 ≤ n ≤ 100
"""



# 23.04.19
# 변수명 이상하게 적어뒀던 첫 정답이 모두에게 공개되는 일만 없었으면 좋곘다 나는 피자를 좋아할 뿐이야...
def solution(slice, n):
    if n%slice == 0:
        return n//slice
    else:
        return n//slice+1
