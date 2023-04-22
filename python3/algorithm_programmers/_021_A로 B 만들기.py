"""
코딩테스트 연습> 코딩테스트 입문> A로 B 만들기
https://school.programmers.co.kr/learn/courses/30/lessons/120886
문제 설명
  문자열 before와 after가 매개변수로 주어질 때, before의 순서를 바꾸어 after를 만들 수 있으면 1을, 만들 수 없으면 0을 return 하도록 solution 함수를 완성해보세요.
제한사항
  0 < before의 길이 == after의 길이 < 1,000
  before와 after는 모두 소문자로 이루어져 있습니다.
"""



# 23.04.22
# 오답노트 1번을 작성후, before 한 쪽만 dictionary로 만들기로 했다.
def solution(before, after):
    dicts = dict(zip(set(list(before)), [before.count(i) for i in set(list(before))]))
    for l in list(dicts.keys()):
        if dicts[l] == after.count(l):
            pass
        else:
            return 0
    return 1

# 이또한 가능하다. 이쪽이 훨씬 빨랐다.
def solution(before, after):
    for l in list(set(list(before))):
        if before.count(l) == after.count(l):
            pass
        else:
            return 0
    return 1


"""오답노트"""
# 1
# 문제를 잘못 이해하였음. 순서를 바꾼다는 말을 뒤집었을 때로 이해를 하고 문제를 풀었더니 계속 안되더라... 
# 그때의 코드
def solution(before, after):
    l = list(before[-1::-1])
    for i in range(len(l)):
        if l[i] == after[i]:
            pass
        else:
            return 0
    return 1



# 2
# 로직은 맞지만 런타임 에러남
def solution(before, after):
    # sets = set(list(before))
    # cnt = [before.count(i) for i in set(list(before))]
    dicts1 = dict(zip(set(list(before)), [before.count(i) for i in set(list(before))]))
    dicts2 = dict(zip(set(list(after)), [after.count(i) for i in set(list(after))]))
    for l in list(dicts1.keys()):
        if dicts1[l] == dicts2[l]:
            pass
        else:
            return 0
    return 1
