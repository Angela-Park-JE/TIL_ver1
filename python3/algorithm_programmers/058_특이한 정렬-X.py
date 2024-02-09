"""
코딩테스트 연습> 코딩테스트 입문> 특이한 정렬
https://school.programmers.co.kr/learn/courses/30/lessons/120880
문제 설명
  정수 n을 기준으로 n과 가까운 수부터 정렬하려고 합니다. 이때 n으로부터의 거리가 같다면 더 큰 수를 앞에 오도록 배치합니다. 
  정수가 담긴 배열 numlist와 정수 n이 주어질 때 numlist의 원소를 n으로부터 가까운 순서대로 정렬한 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ n ≤ 10,000
  1 ≤ numlist의 원소 ≤ 10,000
  1 ≤ numlist의 길이 ≤ 100
  numlist는 중복된 원소를 갖지 않습니다.
"""



# 24.02.09: for문 시퀀스를 set으로 바꾼다면!? -> 성공!
def solution(numlist, n):
    numkey = dict(zip(numlist, [abs(n-i) for i in numlist]))
    s = []
    for d in sorted(set([abs(n-i) for i in numlist])):
        k = [k for k, v in numkey.items() if v == d]
        if len(k)>1:
            k.sort(reverse = True)
        else:
            pass
        s = s + k
    return s



"""다른 풀이"""
# pgstter , 우예빈 , da , Zestina Oh 외 99 명: 
# key가 튜플형태인데 key기준으로 sorted을 하는 방식 
def solution(numlist, n):
    answer = sorted(numlist,key = lambda x : (abs(x-n), n-x))
    return answer

# 김시은 , 박민주
# 이해를 못한 방법... 나중에 다시 이해해보도록 하자.
def solution(numlist, n):
    # num -> (abs(n-num), -num)
    numlist = [(abs(n-num), -num) for num in numlist]
    # 첫 번째 요소를 기준으로 오름차순 정렬 and 두 번째 요소를 기준으로 내림차순 정렬
    numlist.sort()
    # 두 번쨰 요소만 반환
    return [-num for _, num in numlist]



"""오답노트"""
# 24.02.08: 절댓값이 같은 것이 두번 들어가는 문제가 생기는데 어떻게 순번을 넘길 수 있을 까
def solution(numlist, n):
    numkey = dict(zip(numlist, [abs(n-i) for i in numlist]))
    s = []
    for d in sorted([abs(n-i) for i in numlist]):
        k = [k for k, v in numkey.items() if v == d]
        if len(k)>1:
            if k[0] in s: # 이 부분 의미없음... 애초에 중복이 해결이 안 됐음
                pass
            sorted(k, reverse = True)
        else:
            pass
        s = s + k
    return s
