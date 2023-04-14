"""
코딩테스트 연습> 코딩테스트 입문> 최빈값 구하기 (lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120812
문제 설명
  최빈값은 주어진 값 중에서 가장 자주 나오는 값을 의미합니다. 정수 배열 array가 매개변수로 주어질 때, 최빈값을 return 하도록 solution 함수를 완성해보세요. 최빈값이 여러 개면 -1을 return 합니다.
제한사항
  0 < array의 길이 < 100
  0 ≤ array의 원소 < 1000
"""



""""오답노트"""

# 23.04.14
# 1. 딕셔너리로 만들고 각 값마다 카운트를 한 뒤, 해당 카운트 리스트를 정렬한 뒤 인덱스로 가장 뒤 값을 가져오는데, 
# array length가 1인 경우는 그냥 count그대로 가져오도록 하고,
# 만약 뒤에서 첫번째와 뒤에서 두번째 값이 같으면(max가 같으면) -1을 반환하도록 한다.
def solution(array):
    answer = 0
    dic_cnts = {}
    for i in array:
        dic_cnts[i] = array.count(i)
    cnts = list(dic_cnts.values())
    cnts.sort()
    if len(cnts) == 1:
        answer = cnts[0]
    elif cnts[-1] == cnts[-2]:
        answer = -1
    else:
        answer = cnts[-1]
    return answer

# 2. 마찬가지 방법인데 정렬과 인덱싱을 사용하지 않고, 맥스를 카운트해서 1보다 크면 -1이 적히도록 직접 적었다.
# 하지만 1번과 마찬가지로 테스트 케이스에선 잘 돌아가지만 실제에서 잘 되지 않는다.
def solution(array):
    answer = 0
    dic_cnts = {}
    for i in array:
        dic_cnts[i] = array.count(i)
    cnts = list(dic_cnts.values())
    cnts.sort()
    if len(cnts) == 1:
        answer = max(cnts)
    elif cnts.count(max(cnts)) > 1:
        answer = -1
    else:
        answer = max(cnts)
    return answer
