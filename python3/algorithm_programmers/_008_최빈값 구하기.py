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
# 1
# 딕셔너리로 만들고 각 값마다 카운트를 한 뒤, 해당 카운트 리스트를 정렬한 뒤 인덱스로 가장 뒤 값을 가져오는데, 
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

# 2
# 마찬가지 방법인데 정렬과 인덱싱을 사용하지 않고, 맥스를 카운트해서 1보다 크면 -1이 적히도록 직접 적었다.
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

# 3  
# 이번엔 array에서 하나씩 count를 기존것과 비교하도록 했다. 하지만 마찬가지로 되지 않았다. 
def solution(array):
    answer = 0
    max_count = 0
    for i in array:
        if max_count == array.count(i):
            answer = -1
        elif max_count < array.count(i):
            max_count = array.count(i)
            answer = max_count
    return answer

# 4
# 이건 다르게, tmp의 맥스값을 미리 뽑아놓고 이걸 count리스트에서 셌을 때 1보다 크면 answer = -1, 아니면 maxs.
# 하지만 -1이 제대로 동작하지 않았음.
def solution(array):
    answer = 0
    tmp = {}
    for i in array:
        tmp[i] = array.count(i)
    maxs = max(list(tmp.values()))
    if list(tmp.values()).count(maxs) > 1:
        answer = -1
    else:
        answer = maxs
    return maxs

# 5 
# 같은데 딕셔너리 대신 리스트에 넣어서 세는 식인데... 여전히 중복일때가 제대로 동작하지 않는다.
def solution(array):
    answer = 0
    # tmp = {}
    tmp = []
    for i in array:
        tmp.append(array.count(i))
    maxs = max(tmp)
    if tmp.count(maxs) > 1:
        answer = -1
    else:
        answer = maxs
    return tmp

# 6
# set으로 만들어두고 각 요소별로 카운트를 counts에 넣어둔다. 
# 그리고 array 길이가 1이면 답은 1이고, 맥스를 counts에서 찾았을 때 개수가 1개를 넘으면 답은 -1이 된다. 
# 그외에는 counts의 맥스가 된다.
def solution(array):
    answer = 0
    counts = []
    for i in list(set(array)):
        counts.append(array.count(i))
    if counts.count(max(counts)) > 1:
        answer = -1
    else:
        answer = max(counts)
    return answer
    return answer

# 7
# 이젠 그만하고 다른 문제부터 하자.
def solution(array):
    answer = 0
    counts = []
    for i in list(set(array)):
        counts.append(array.count(i))
    max_count = max(counts)
    if counts.count(max_count) == 1:
        answer = max(counts)
    else:
        answer = -1
    return answer

