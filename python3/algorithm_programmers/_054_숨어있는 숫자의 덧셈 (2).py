"""
코딩테스트 연습> 코딩테스트 입문> 숨어있는 숫자의 덧셈 (2)
문제 설명
  문자열 my_string이 매개변수로 주어집니다. my_string은 소문자, 대문자, 자연수로만 구성되어있습니다. my_string안의 자연수들의 합을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ my_string의 길이 ≤ 1,000
  1 ≤ my_string 안의 자연수 ≤ 1000
  연속된 수는 하나의 숫자로 간주합니다.
  000123과 같이 0이 선행하는 경우는 없습니다.
  문자열에 자연수가 없는 경우 0을 return 해주세요.
"""

# 24.01.25: 잠시 헤맸었는데 replace가 훨씬 편하겠다 생각들고 바로 바꾸었다.
def solution(my_string):
    # 검사해서 공백으로 바꾸고 공백을 기준으로 잘라 숫자를 추출, 정수화 한다음 더한다
    for i in range(len(my_string)):
        if my_string[i].isdecimal():
            pass
        else:
            my_string = my_string.replace(my_string[i], ' ')
    nums = [int(n) for n in my_string.split()]
    return sum(nums)



"""다른 풀이"""
# 노력형범재 , 강예빈 , RYEZYI , 최준우 외 67 명
# 숫자는 바로 추가, 문자형이 아닐 경우 ' '로 추가한 문자열 하나를 만들어서 그 문자열을 바로 int화 시켜서 sum 안에 넣어버렸다.
# 비슷한듯 하면서 다른 답이지만 짧고 간단하게 만든 좋은 답 같다.
def solution(my_string):
    s = ''.join(i if i.isdigit() else ' ' for i in my_string)
    return sum(int(i) for i in s.split())

"""오답노트"""
def solution(my_string):
    # 숫자형이 나오지 않으면 잘라내고 숫자형이 나올 때까지 지나가고 nums에 숫자형까지를 넣는 그런 로직을 짜고 싶었다
    nums = []
    for i in len(my_string):
        if my_sting[i].isnumeric():
            pass
        else:
            my_string = my_string[i:]
    answer = 0
    return my_string[:1]

