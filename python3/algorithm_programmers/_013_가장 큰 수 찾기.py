"""
코딩테스트 연습> 코딩테스트 입문> 가장 큰 수 찾기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120899
문제 설명
  정수 배열 array가 매개변수로 주어질 때, 가장 큰 수와 그 수의 인덱스를 담은 배열을 return 하도록 solution 함수를 완성해보세요.
제한사항
  1 ≤ array의 길이 ≤ 100
  0 ≤ array 원소 ≤ 1,000
  array에 중복된 숫자는 없습니다.
"""


# 23.04.18
# max값을 따로 구하고 answer를 구성하는게 나은지, answer안에 다 넣어버리는게 나은지 아직 잘 모르는 알린이. 무조건 line이나 변수 개수가 적은게 좋은걸까 하는 의문.
def solution(array):
    # m = max(array)
    # answer = [m, array.index(m)]
    answer = [max(array), array.index(max(array))]
    return answer
