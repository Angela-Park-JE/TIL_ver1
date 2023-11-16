"""
프로그래밍 강의> 알고리즘 문제 해설> 순열 검사
https://school.programmers.co.kr/learn/courses/18/lessons/1877

문제 설명
  길이가 n인 배열에 1부터 n까지 숫자가 중복 없이 한 번씩 들어 있는지를 확인하려고 합니다.
  1부터 n까지 숫자가 중복 없이 한 번씩 들어 있는 경우 true를, 아닌 경우 false를 반환하도록 함수 solution을 완성해주세요.

제한사항
  배열의 길이는 10만 이하입니다.
  배열의 원소는 0 이상 10만 이하인 정수입니다.
"""



# 23.11.16: 전혀 어려움 없었는데, 궁금한 건 if문의 결과(T/F) 자체를 그대로 return 하도록 만들 수는 없을까?
def solution(arr):
    arr = sorted(arr)
    compare = [i for i in range(1, arr[-1]+1)]
    if arr == compare:
        answer = True
    else:
        answer = False
    return answer
