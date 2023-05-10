"""
코딩테스트 연습> 코딩테스트 입문> 합성수 찾기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120846
문제 설명
  약수의 개수가 세 개 이상인 수를 합성수라고 합니다. 자연수 n이 매개변수로 주어질 때 n이하의 합성수의 개수를 return하도록 solution 함수를 완성해주세요.

제한사항
  1 ≤ n ≤ 100
"""


# 23.05.02
# 1부터 n까지의 숫자들을 놓고 (i), i보다 작은 수들을 가지고 나눠보는데, 1이 아닌 것으로 나눴을때 나머지가 0이되면 무조건 합성수이기 때문에 (합성수<->소수) 
# 나머지가 0이 되는 경우 i를 모두 넣어버리고 (i의 약수가 1과 자기자신이 아닌 경우 들어가므로 1과 자신을 제외한 약수의 개수만큼 여러번 들어가게됨)
# set으로 중복을 제거하고 len으로 개수를 데려온다.
def solution(n):
    mults = []
    for i in range(1, n+1):
        for j in range(1, i):
            if (j!= 1)&(i%j == 0):
                mults.append(i)
    answer = len(set(mults))
    return answer



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120846/solution_groups?language=python3&type=all

# Sehyeon Jeong , 우기 , Qree_Dev , gyfla1512@g.skku.edu 외 3 명
# 내가 하고싶었던 형태이다. 우선 약수를 구하고, 해당 약수가 3개 이상되는 수 뽑는것. 함수를 만들어 쓰면 되는데 앞으로도 자주 이렇게 해보자.
def get_divisors(n):
    return list(filter(lambda v: n % v ==0, range(1, n+1)))

def solution(n):
    return len(list(filter(lambda v: len(get_divisors(v)) >= 3, range(1, n+1))))

# DalHyun , 강예빈 , Ayaan , 손소영 외 32 명
# 많은 사람이 이렇게 풀었다고 한다. 나도 4부터 할까 했는데 히히 
# 4부터 하고, 그 다음 j에서는 약수가 자신의 제곱근 이하 안에서 대칭을 이루는 점을 이용하여 int(i**0.5) + 1를 이용한 것이라고 한다.
# 그리고 한번 더하고 나면 break를 이용해서 나간다.
def solution(n):
    output = 0
    for i in range(4, n + 1):
        for j in range(2, int(i ** 0.5) + 1):
            if i % j == 0:
                output += 1
                break
    return output

# 인영교
# 아직 완벽히 이해하지 못한 코드
def solution(n):
    return len([i for i in range(2, n + 1) if not all(i % j for j in range(2, i))])
