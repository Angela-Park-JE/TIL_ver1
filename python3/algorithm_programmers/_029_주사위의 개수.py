"""
문제 설명
머쓱이는 직육면체 모양의 상자를 하나 가지고 있는데 이 상자에 정육면체 모양의 주사위를 최대한 많이 채우고 싶습니다. 상자의 가로, 세로, 높이가 저장되어있는 배열 box와 주사위 모서리의 길이 정수 n이 매개변수로 주어졌을 때, 상자에 들어갈 수 있는 주사위의 최대 개수를 return 하도록 solution 함수를 완성해주세요.

제한사항
box의 길이는 3입니다.
box[0] = 상자의 가로 길이
box[1] = 상자의 세로 길이
box[2] = 상자의 높이 길이
1 ≤ box의 원소 ≤ 100
1 ≤ n ≤ 50
n ≤ box의 원소
주사위는 상자와 평행하게 넣습니다.
"""


# 23.04.30
# 사실 혼자힘으로 푼 것은 아니다. 내가 내 한계를 알았기 때문에 `[box[i]//n for i in range(3)]` 만 구해두고, 
# 리스트 형태의 정수 배열을 모두 곱하는 방식을 어떻게 만들면 좋을까 찾아보았다.
# 솔직히 라이브러리를 쓴다는게 과연 좋은 걸까? 생각을 자주 하긴 하지만, 이 방법은 알아두는 게 좋을 것 같다.
def solution(box, n):
    from functools import reduce
    return reduce(lambda x, y: x * y, [box[i]//n for i in range(3)])

# 그냥 했으면 이 모양이 났을 것이다. 물론 나쁘다는게 아니라... 아는 내에서만 하는 것이기 때문에 발전이 없다는 말이다. 나는 이 방법도 좋다.
def solution(box, n):
    k = 1
    for i in [box[i]//n for i in range(len(box)]:
        k *= i
    return k



"""다른 풀이"""
# https://school.programmers.co.kr/learn/courses/30/lessons/120845/solution_groups?language=python3

# le2dy , mainfn , uturtle , 남희수 외 6 명
# 그렇다. 어렵게 생각할 필요도 없는 것이다. 차피 배열은 3개니까. 난 그래도 범용성에서 우위인 코드가 훨씬 좋은 걸.
def solution(box, n):
    x, y, z = box
    return (x // n) * (y // n) * (z // n )

# 김종도 , dwkim.research@gmail.com , dosilt , 김정훈 외 50 명
# 굳이 몫 리스트를 구할 필요가 없긴 해요... 맞아 이건 인정.
def solution(box, n):
    answer = 1
    for b in box:
        answer *= b // n
    return answer

# Sehyeon Jeong , jamesome , 변민서 , 승뭉이 외 8 명
# import math 라이브러리를 활용한 방법. prod 함수를 쓰면 간단하다! 외부 라이브러리를 쓴 것이긴 하지만 좋다고 생각이 든다.
import math

def solution(box, n):
    return math.prod(map(lambda v: v//n, box))
