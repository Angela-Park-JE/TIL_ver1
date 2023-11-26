"""
코딩테스트 연습> 코딩테스트 입문> 컨트롤 제트(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120853
문제 설명
  숫자와 "Z"가 공백으로 구분되어 담긴 문자열이 주어집니다. 문자열에 있는 숫자를 차례대로 더하려고 합니다. 
  이 때 "Z"가 나오면 바로 전에 더했던 숫자를 뺀다는 뜻입니다. 숫자와 "Z"로 이루어진 문자열 s가 주어질 때, 머쓱이가 구한 값을 return 하도록 solution 함수를 완성해보세요.

제한사항
  1 ≤ s의 길이 ≤ 200
  -1,000 < s의 원소 중 숫자 < 1,000
  s는 숫자, "Z", 공백으로 이루어져 있습니다.
  s에 있는 숫자와 "Z"는 서로 공백으로 구분됩니다.
  연속된 공백은 주어지지 않습니다.
  0을 제외하고는 0으로 시작하는 숫자는 없습니다.
  s는 "Z"로 시작하지 않습니다.
  s의 시작과 끝에는 공백이 없습니다.
  "Z"가 연속해서 나오는 경우는 없습니다.
"""



# 23.11.26



"""오답노트"""

# 23.05.08
# 분명 로직은 맞는 것 같은데 테스트 5에서 되질 않는다. -3이 나와야 하는데 3이 나온다. 왜 3이 나오는지 이해가 안가는 중.
# 테스트 5
# 입력값 〉	"-1 -2 -3 Z"
def solution(s):
    letters = s.split(' ')
    a = 0
    for i in range(len(letters)):
        if letters[i].isdigit():
            a += int(letters[i])
        elif letters[i] == 'Z':
            a -= int(letters[i-1])
    
    return a




"""다른 풀이"""
# 언제 풀었는지 모르겠으나 내가 한 것 같지 않은 것이 내 답에 있어 여기에 넣어둠.
def solution(s):
    slist = s.split(' ')
    nums = [int(slist[i-1])*(-1) if slist[i] == 'Z' else int(slist[i]) for i in range(len(slist)) ]
    return sum(nums)
