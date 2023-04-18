"""
코딩테스트 연습> 코딩테스트 입문> 최빈값 구하기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120812#
문제 설명
  최빈값은 주어진 값 중에서 가장 자주 나오는 값을 의미합니다. 정수 배열 array가 매개변수로 주어질 때, 최빈값을 return 하도록 solution 함수를 완성해보세요. 최빈값이 여러 개면 -1을 return 합니다.
제한사항
  0 < array의 길이 < 100
  0 ≤ array의 원소 < 1000
"""



# 23.04.18
# '최빈값'을 구하라니까, '최빈값'의 빈도수를 뱉고있었다. (max(cnts)) 바보였다. (처음 문제 접했을 떄 썼던 코드는 오답노트로 올릴 필요도 없다.)
# 웃긴건 그렇게 구해놨는데 테스트 케이스가 다 통과가 되었었음... 3이 3개있고 그랬다고 함... 일부러 테스트 케이스 그렇게 둔게 아닐까 합리적 의심이 들정도로!

# 1. array를 list(set()) 해서 unique 값들로 만들어둔다. (물론 dictionary를 이용하는 방법도 있을 것이라 생각이 드는데, 나중에 심심할 때 바꿔봐야 겠다.)
# 2. 각 unique 값들이 알아서 정렬되어 있으므로, 각각의 빈도수가 리스트로 만들어지도록 list comprehension을 사용.
# 3-1. 만약 카운트들(cnts) 중 가장 큰 값을 카운트들에서 셌을 때 1이 아니면 -1을 반환 (빈도수 자체만 비교하면 되니 최빈도수가 1이 아니면으로 간단히 세버렸음) -1을 반환
# 3-2. 만약 최빈도수가 1개로 유일하면 최빈도수로 cnts에서 인덱스를 찾은 값을 tmp 인덱스로 넣어서 찾아버림.
def solution(array):
    answer = 0
    tmp = list(set(array))
    cnts = [array.count(i) for i in tmp]
    
    if cnts.count(max(cnts)) != 1:
        answer = -1
    else:
        answer = tmp[cnts.index(max(cnts))]
    
    return answer

# 살짝 있어보이게 바꾼 것 (아래 글들 보고 리턴 방식만 바꿈)
# 이번만 올리고 올리지 말든가 해야지 sql과 다르게 다른 사람 풀이 코드 다 볼 수 있네... https://school.programmers.co.kr/questions/47630
def solution(array):
    
    tmp = list(set(array))
    cnts = [array.count(i) for i in tmp]
    
    answer = -1
    if cnts.count(max(cnts)) == 1:
        answer = tmp[cnts.index(max(cnts))]   
    
    return answer
# 물론 여기에 answer 아예 안쓰고 return 박아두고 if 절 나가서 return 에 -1 해도 된다!
    if cnts.count(max(cnts)) == 1:
        return tmp[cnts.index(max(cnts))]   
    
    return -1



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120812/solution_groups?language=python3&type=all

# 1순위
# enumerate()는 배열을 인덱스와 원소로 이루어진 튜플을 만들어주는 함수이다. 이때 i는 인덱스가 되겠고, a는 array의 중복되지 않은 고유한 원소들이다.
# 1. array 배열을 돌면서 set에서 주어진 a(각 요소)를 한 번씩 지워나간다. array가 0개로 비기 전까지만 실행된다. 
# 2. 만약 가장 많은 빈도수를 기록한 수는 주어졌던 array에 마지막으로 혼자 남게 될 것이다(len(array)==1). 마지막으로 만들어졌던 i는 0일 것이다. (i, a)는 (0, 최빈값)으로 엔딩.
# 따라서 그런 경우 return 으로 a를 바로 반환.
# 3. 만약 최빈값이 두 개라면 i는 1로 마무리가 될 것이다. (i, a)는 (0, mode1) (1, mode2) 로 i는 0이 아닌 1 혹은 2, 3 등 최빈값 개수에 따라 0이 아닌 상태로 끝난다.
# 그런데 최빈값들을 다 지워버렸으니 array 길이는 0이 되면서 while이 종료되고 return -1 을 실행하게 된다.
# 정말 파이토닉한 코드이다. 샘난다 그분들처럼 되고싶다!
def solution(array):
    while len(array) != 0:
        for i, a in enumerate(set(array)):
            array.remove(a)
        if i == 0: return a
    return -1

# winteri님
# 상당히 투박한 방식인데 이렇게도 해결가능하구나! 싶고 또 카운트에 인덱스를 부여하는 점은 닮았다.
# 1. array에 주어질 수 있는 수가 0부터 1000까지임을 이용하여 1001개의 0개로 이루어진 리스트를 만들어 두고,
# 2. array를 돌며 해당 값을 인덱스로 사용하여 idx 리스트에 카운트를 먹인다.
# 3. 만약 idx에서 맥스값을 셌을 때 idx에서 최빈도수가 1개 초과라면 -1을 반환하고, 아니면 바로 return 으로 넘어가서 해당 맥스값의 인덱스를 바로 가져온다.
# 마지막에 array를 안거치는게 조큼 인상적이다.
def solution(array):
    answer = 0
    idx = [0] * 1001
    for i in array:
        idx[i] +=1
    if idx.count(max(idx)) >1:
        return -1
    return idx.index(max(idx))
