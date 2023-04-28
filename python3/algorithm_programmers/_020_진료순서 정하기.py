"""
코딩테스트 연습> 코딩테스트 입문> 진료순서 정하기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120835
문제 설명
  외과의사 머쓱이는 응급실에 온 환자의 응급도를 기준으로 진료 순서를 정하려고 합니다. 
  정수 배열 emergency가 매개변수로 주어질 때 응급도가 높은 순서대로 진료 순서를 정한 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  중복된 원소는 없습니다.
  1 ≤ emergency의 길이 ≤ 10
  1 ≤ emergency의 원소 ≤ 100
"""


# 23.04.22
# 더 간단하게 하는 방법이 궁금하다. 딕셔너리로 하면 훨씬 좋을 것 같다는 생각이드는데 말이다. 각 emergency 별로 그들의 순서에 떄라 value를 매겨준다거나...
def solution(emergency):
    seq = emergency.copy()
    seq.sort(reverse = True)
    answer = []
    for i in emergency:
        answer.append(seq.index(i)+1)
    return answer



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120835/solution_groups?language=python3

# Sehyeon Jeong , 전주현 , KJstudio1171 , ethan528 외 80 명
# 시간 복잡도가 최적은 아닌 코드라고 하지만 이렇게 줄일 수 있는 것도 참 대단하다. 결국 같은 형식인데.
def solution(emergency):
    return [sorted(emergency, reverse=True).index(e) + 1 for e in emergency]

# 노력형범재 , 손광호 , 김서정 , 2jun0 외 110 명
# 위와 비슷하지만 e를 명시를 해주는 것으로 조금 다르다. 
# 인덱스를 쓰면 복잡도가 n**2 로 늘어난다는 댓글이 있다. 
def solution(emergency):
    e = sorted(emergency,reverse=True)
    return [e.index(i)+1 for i in emergency]

# 김종도 , SEO2317
# 딕셔너리를 쓴 코드. 이건 좀 보고 배워야 겠다.
# 딕셔너리를 emergency를 정렬한 것에서 enumerate는 값과 인덱스를 배출하게되는데 인덱스 + 1을 값으로, e를 key로 하여 딕셔너리를 만들어놓고 딕셔너리의 밸류를 e 차례로 넣었다.
def solution(emergency):
    answer = []
    emer_ls = {e: i + 1 for i, e in enumerate(sorted(emergency)[::-1])}
    for e in emergency:
        answer.append(emer_ls[e])
    return answer
