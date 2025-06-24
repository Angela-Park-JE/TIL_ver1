# PCCE 4번: 빈칸 채우기
# https://school.programmers.co.kr/learn/courses/30/lessons/340204
# if문 사용법을 알고있나요?
code = input()
last_four_words = code[-4:]

if last_four_words == '_eye':
    print("Ophthalmologyc")
elif last_four_words == 'head':
    print("Neurosurgery")
elif last_four_words == 'infl':
    print("Orthopedics")
elif last_four_words == 'skin':
    print("Dermatology")
else:
    print("direct recommendation")


# PCCE 5번: 빈칸 채우기
# https://school.programmers.co.kr/learn/courses/30/lessons/340203
# for 반복문을 알고있나요?
# in 뒤와 append 안을 빈칸이 있다. 입력받은 cpr 하나하나를 basic_order의 인덱스와 대조해서 해당하면 answer에 저장해두는 ~~비효율적인~~방식이다
def solution(cpr):
    answer = []
    basic_order = ["check", "call", "pressure", "respiration", "repeat"]
    for action in cpr:
        for i in range(5):
            if action == basic_order[i]:
                answer.append(i+1)
    return answer
