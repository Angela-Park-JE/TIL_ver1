"""
코딩테스트 연습> 코딩 기초 트레이닝> 배열 조각하기
https://school.programmers.co.kr/learn/courses/30/lessons/181893

문제 설명
정수 배열 arr와 query가 주어집니다.
query를 순회하면서 다음 작업을 반복합니다.
  짝수 인덱스에서는 arr에서 query[i]번 인덱스를 제외하고 배열의 query[i]번 인덱스 뒷부분을 잘라서 버립니다.
  홀수 인덱스에서는 arr에서 query[i]번 인덱스는 제외하고 배열의 query[i]번 인덱스 앞부분을 잘라서 버립니다.
위 작업을 마친 후 남은 arr의 부분 배열을 return 하는 solution 함수를 완성해 주세요.

제한사항
  5 ≤ arr의 길이 ≤ 100,000
  0 ≤ arr의 원소 ≤ 100
  1 ≤ query의 길이 < min(50, arr의 길이 / 2)
  query의 각 원소는 0보다 크거나 같고 남아있는 arr의 길이 보다 작습니다.
"""


# 23.12.09: 테스트는 통과를 하는데 모든 테스트 케이스 실패가 뜬다
# 문제를 제대로 이해를 못한 부분이 있는 것 같다.
def solution(arr, query):
    for i in range(len(query)):
        if i%2==0:
            arr = arr[:-1]
        elif i%2!=0:
            arr = arr[1:]

    answer = arr
    return answer
