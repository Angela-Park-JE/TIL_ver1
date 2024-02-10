"""
코딩테스트 연습> 코딩테스트 입문> 등수 매기기
https://school.programmers.co.kr/learn/courses/30/lessons/120882
문제 설명
  영어 점수와 수학 점수의 평균 점수를 기준으로 학생들의 등수를 매기려고 합니다. 
  영어 점수와 수학 점수를 담은 2차원 정수 배열 score가 주어질 때, 영어 점수와 수학 점수의 평균을 기준으로 매긴 등수를 담은 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  0 ≤ score[0], score[1] ≤ 100
  1 ≤ score의 길이 ≤ 10
  score의 원소 길이는 2입니다.
  score는 중복된 원소를 갖지 않습니다.
"""



# 24.02.11: 이전에 풀다 만건 means라는 리스트를 만들고 어떻게하지?! 생각하던 단계였었던 것 같다.
def solution(score):
    means = [sum(i)/2 for i in score]   # 평균 리스트
    dic = {}                            # {등수: 평균} 
    ranks = []
    for m, n in enumerate(sorted(means, reverse = True), start = 1):
        dic[m] = n
    for i in means:
        k = [k for k, v in dic.items() if v == i] # 평균점수가 연결고리가 되어 해당 등수를 각각 가져옴
        # 이때 enumerate로 했기 때문에 같은 점수 명수만큼 수 key가 여러 개 존재할 것임
        ranks.append(k[0]) # append(k)면 "rank ==> [[4,5],[4,5],[6],[2,3],[2,3],[1],[7]]"
    return ranks



"""다른 풀이"""
# 헉 이렇게 풀다니... 하고있었다. 일단 어차피 평균이니 sum() 두 점수의 합만 가지고 비교를 해도 된다. 그러니 합한 걸 내림차순 한다음 score에서 합 값으로 index 가져와서 +i 한다.
# 굳이 같은 점수 신경 안써도 되는게 index 검색하면 처음으로 검색되는 값 한 개만 나올 것이기 때문. 
# 조창범 , 나정탁 , 포메 , 조현준 외 55 명
def solution(score):
    a = sorted([sum(i) for i in score], reverse = True)
    return [a.index(sum(i))+1 for i in score]

# 내가 한 것과 그나마 비슷한 식. 여기선 enumerate가 0부터 시작되고, {순위:평균} 을 만들고 하나씩 값 평균 별로 순위를 매겨준다. 
# (그렇게 인덱스+1로 한다음) score에서 평균 값으로 해당 밸류(등수)를 찾아온다. 
# dictionary를 이용한 것과 같은 등수 이후의 것들은 어차피 인덱스가 밀리기 때문에 신경쓰지 않아도 되게되는 것도 같다.
# DalHyun , JKIM734 , 김수지 , 폴키미 외 2 명
def solution(score):
    rank = sorted([sum(s) / 2 for s in score], reverse=True)
    rankDict = {}
    for i, r in enumerate(rank):
        if r not in rankDict.keys():
            rankDict[r] = i + 1
    return [rankDict[sum(s) / 2] for s in score]

# 또 이분! 누군가 "배열 내에서 나보다 더 작은 값을 찾으면 1을 더하는 방법이군요" 라고 했다.
# zfra
def solution(score):
    av = [sum(s) for s in score]
    return [sum([1 if v > mys else 0 for v in av])+1 for mys in av]
# 이해를 제대로 하기 위해 풀어서 해보았다. 와! 진짜 대단한분!
def solution(score):
    av = [sum(s) for s in score]
    ranks = []
    for mys in av:
        r = 1
        for v in av:
            if v > mys:
                r += 1
            else:
                r += 0
        ranks.append(r)
    return ranks
