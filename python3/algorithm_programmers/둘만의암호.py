"""
둘만의 암호
https://school.programmers.co.kr/learn/courses/30/lessons/155652
두 문자열 s와 skip, 그리고 자연수 index가 주어질 때, 다음 규칙에 따라 문자열을 만들려 합니다. 암호의 규칙은 다음과 같습니다.
  - 문자열 s의 각 알파벳을 index만큼 뒤의 알파벳으로 바꿔줍니다.
  - index만큼의 뒤의 알파벳이 z를 넘어갈 경우 다시 a로 돌아갑니다.
  - skip에 있는 알파벳은 제외하고 건너뜁니다.
예를 들어 s = "aukks", skip = "wbqd", index = 5일 때, a에서 5만큼 뒤에 있는 알파벳은 f지만 [b, c, d, e, f]에서 'b'와 'd'는 skip에 포함되므로 세지 않습니다. 
따라서 'b', 'd'를 제외하고 'a'에서 5만큼 뒤에 있는 알파벳은 [c, e, f, g, h] 순서에 의해 'h'가 됩니다. 나머지 "ukks" 또한 위 규칙대로 바꾸면 "appy"가 되며 결과는 "happy"가 됩니다.
두 문자열 s와 skip, 그리고 자연수 index가 매개변수로 주어질 때 위 규칙대로 s를 변환한 결과를 return하도록 solution 함수를 완성해주세요.
"""

# 흐접한 나의 답안
# 1레벨 문제를 거의 4-50분을 걸려 풀었다는 것에 대해 내 실력에 X를 표합니다
# 처음에는 인덱스 + skip 을 할 생각을 안하고 `alphlist = alphlist[index:] + alphlist[:index]` 이런식으로 색인할 리스트를 수정하려고만 했는데 뒤에서 스스로 헷갈림

# 두번째 파트 부분은 이렇게 바꿀 수 있음
    # output = []
    # for k in list(s):
    #     temp = alphlist[alphlist.index(k)+index]
    #     output.append(temp)
    # answer = ''.join(output)

def solution(s, skip, index):
    alphlist = [chr(i) for i in range(ord('a'), ord('z')+1)]
    for j in list(skip):
        alphlist.remove(j)
    alphlist = alphlist*3 # 충분히 길게 해줄 필요가 있음 skip이 최대 10이라고 했기 때문에

    real_s = ''
    for k in list(s):
        temp = alphlist[alphlist.index(k)+index]
        real_s = real_s + temp
    answer = real_s
    return answer


  
  """다른 풀이"""
  
# https://school.programmers.co.kr/learn/courses/30/lessons/155652/solution_groups?language=python3# 
# 여기서 가장 
from string import ascii_lowercase

def solution(s, skip, index):
    result = ''

    a_to_z = set(ascii_lowercase)
    a_to_z -= set(skip)
    a_to_z = sorted(a_to_z)
    l = len(a_to_z)

    dic_alpha = {alpha:idx for idx, alpha in enumerate(a_to_z)}

    for i in s:
        result += a_to_z[(dic_alpha[i] + index) % l]

    return result
