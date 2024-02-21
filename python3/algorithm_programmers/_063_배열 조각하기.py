"""
코딩테스트 연습> 코딩 기초 트레이닝> 배열 조각하기
https://school.programmers.co.kr/learn/courses/30/lessons/181893
문제 설명
  정수 배열 arr와 query가 주어집니다. query를 순회하면서 다음 작업을 반복합니다.
  짝수 인덱스에서는 arr에서 query[i]번 인덱스를 제외하고 배열의 query[i]번 인덱스 뒷부분을 잘라서 버립니다.
  홀수 인덱스에서는 arr에서 query[i]번 인덱스는 제외하고 배열의 query[i]번 인덱스 앞부분을 잘라서 버립니다.
  위 작업을 마친 후 남은 arr의 부분 배열을 return 하는 solution 함수를 완성해 주세요.

제한사항
  5 ≤ arr의 길이 ≤ 100,000
  0 ≤ arr의 원소 ≤ 100
  1 ≤ query의 길이 < min(50, arr의 길이 / 2)
  query의 각 원소는 0보다 크거나 같고 남아있는 arr의 길이 보다 작습니다.
"""



# 24.02.21 : 어려운 문제가 아닌데 query의 인덱스(query에서 주어진 값이 아니라) 짝수 홀수 여부에 따라 정해야한다는 점! 때문에 예전에 풀다 말았나보다.
# 내일 예쁘게 정리해야지
def solution(arr, query):
    for i in range(len(query)):
        if i%2==0:
            arr = arr[:query[i]+1]
        elif i%2!=0:
            arr = arr[query[i]:]

    answer = arr
    return answer
