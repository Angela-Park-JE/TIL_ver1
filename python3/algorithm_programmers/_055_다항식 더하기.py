"""
코딩테스트 연습> 코딩테스트 입문> 다항식 더하기
https://school.programmers.co.kr/learn/courses/30/lessons/120863
문제 설명
한 개 이상의 항의 합으로 이루어진 식을 다항식이라고 합니다. 다항식을 계산할 때는 동류항끼리 계산해 정리합니다. 
덧셈으로 이루어진 다항식 polynomial이 매개변수로 주어질 때, 동류항끼리 더한 결괏값을 문자열로 return 하도록 solution 함수를 완성해보세요. 
같은 식이라면 가장 짧은 수식을 return 합니다.

제한사항
    0 < polynomial에 있는 수 < 100
    polynomial에 변수는 'x'만 존재합니다.
    polynomial은 양의 정수, 공백, ‘x’, ‘+'로 이루어져 있습니다.
    항과 연산기호 사이에는 항상 공백이 존재합니다.
    공백은 연속되지 않으며 시작이나 끝에는 공백이 없습니다.
    하나의 항에서 변수가 숫자 앞에 오는 경우는 없습니다.
    " + 3xx + + x7 + "와 같은 잘못된 입력은 주어지지 않습니다.
    0으로 시작하는 수는 없습니다.
    문자와 숫자 사이의 곱하기는 생략합니다.
    polynomial에는 일차 항과 상수항만 존재합니다.
    계수 1은 생략합니다.
    결괏값에 상수항은 마지막에 둡니다.
    0 < polynomial의 길이 < 50
"""



# 24.02.24: 풀긴 풀었는데, 코드 자체가 길어진 것과는 별개로 검사하는 과정 자체를 줄이는 방법을 고민 중이다.
# 오답노트에서 마지막으로 풀었던 것의 문제점은 바로, x가 하나밖에 존재하지 않을 때에는 coefficient = 1인데 해당 1이 들어가서 '1x + 3' 식으로 된 것이다.
def solution(polynomial):
    constant, coefficient = 0, 0
    composed = polynomial.split(' + ')      # 먼저 나눈다음
    
    for i in composed:
        if i.isdecimal():                   # 숫자인지부터 본다: len(i)으로 하면 상수항도 걸림
            constant += int(i)
        elif i == 'x':                      # 변수항인가
            coefficient += 1
        elif (i[-1] == 'x')&(i[:-1].isdecimal()):   # 맨 나중에 계수가 1인 x를 거르도록
            coefficient += int(i[:-1])

    if coefficient >1:   # 계수가 1 초과
        if constant != 0:
            return f'{coefficient}x + {constant}'
        else:
            return f'{coefficient}x'
    elif coefficient ==1: # 계수가 1 일때 (생략해야함)
        if constant != 0:
            return f'x + {constant}'
        else:
            return 'x'
    elif coefficient ==0:
        return f'{constant}'



"""다른 풀이"""
# 결국 하나씩 해결하는 것외에 다른 방식이 있을까 해서 다른 문제 해결방식을을 보았다.
# 이 풀이 말고 다른 풀이에서 x계수가 0인 경우 coefficient == ''로 만든 것을 보았는데 이 방법도 좋은 것 같다.
# 다른점(1) polynomial.split(' + ') 을 for문에 바로 넣은 점 (2) for문 안 else에서 내가 elif두번으로 나눈 것을 바로 해결
# (3) if문에서 양의 정수만 있끼 떄문에 계수가 0인 경우 바로 상수만 출력 (4) 1인 경우와 1초과일 경우 상수항 유무에 따라 가른 것을 한 문장에 해결
# 노력형범재 , eridanus93@gmail.com , gsosun@hanyang.ac.kr , 정우진 외 110 명
def solution(polynomial):
    xnum = 0
    const = 0
    for c in polynomial.split(' + '):
        if c.isdigit():
            const+=int(c)
        else:
            xnum = xnum+1 if c=='x' else xnum+int(c[:-1])
    if xnum == 0:
        return str(const)
    elif xnum==1:
        return 'x + '+str(const) if const!=0 else 'x'
    else:
        return f'{xnum}x + {const}' if const!=0 else f'{xnum}x'



"""오답노트"""

# 1
# 24.01.26: 마지막 답을 두번째 if문을 안쓰고 answer = [str(coefficient), 'x', ' + ', str(constant)] 했을 때 테스트에서는 다 통과였지만 이상함을 느끼긴 했었는데, 
# 각 결과에 따라 나누어서 답이 나오도록 했더니 'x + x + x'가 0이 나와버리는 대참사가 일어남 웃긴건 계수가 제대로 세졌다는 점이다. 
def solution(polynomial):
    answer = []
    constant, coefficient = 0, 0
    composed = polynomial.split(' + ')      # 먼저 나눈다음
    
    for i in composed:
        if i.isdecimal():                   # 숫자인지부터 본다: len먼저 하면 숫자부터 걸림
            constant += int(i)
        elif len(i)>1:                      # x가 포함되어있는지 아닌지 여부로 거르게되면 길이 검사를 한번더 하게 될 듯
            coefficient += int(i[:-1])
        elif i == 'x':                      # 맨 나중에 계수가 1인 x를 거르도록
            coefficient += 1

    if constant+coefficient == 0:        # 계수 상수 모두 0일 때
        answer = ['0']
    elif (constant == 0)&(coefficient != 0):     # 계수가 0이고 상수가 0이 아닐 때
        answer = [str(constant)]
    elif (constant != 0)&(coefficient == 0):     # 계수가 0이 아니고 상수가 0일 때
        answer = [str(coefficient), 'x']
    else:
        answer = [str(coefficient), 'x', ' + ', str(constant)]
    return ''.join(answer)

# 2
# 뒷부분을 간단하게 바꾸어놨는데 이번엔 다 통과하나 싶더니 8, 10, 12 세 케이스에서 막혔다. 
# 양의 정수만 있다고 했으니 상수항이 있던 변수항이 있던 둘 중 하나는 있을 것인데 ....
def solution(polynomial):
    # answer = []
    constant, coefficient = 0, 0
    composed = polynomial.split(' + ')      # 먼저 나눈다음
    
    for i in composed:
        if i.isdecimal():                   # 숫자인지부터 본다: len먼저 하면 숫자부터 걸림
            constant += int(i)
        elif len(i)>1:                      # x가 포함되어있는지 아닌지 여부로 거르게되면 길이 검사를 한번더 하게 될 듯
            coefficient += int(i[:-1])
        elif i == 'x':                      # 맨 나중에 계수가 1인 x를 거르도록
            coefficient += 1
    
    if coefficient != 0:
        if constant != 0:
            answer = f'{coefficient}x + {constant}'
        else:
            answer = f'{coefficient}x'
    else:
        if constant != 0:
            answer = f'{constant}'
        else:
            answer = '0'
            
    return answer

# 3
# 마지막 else에서의 else를 지우고 진행했더니 answer가 미리 참조한다는 오류가 떴다.
# 그래서 아예 return을 바로 하도록 결과에 넣어두었는데 여러 테스트 케이스를 넣어도 여전히 안된다. 
# 없으면 없었지 0은 나올 수가 없기 때문에 꾸렸는데... 같은 케이스가 통과가 안되는데 어떤 케이스인지 이해할 수 없다.

def solution(polynomial):
    constant, coefficient = 0, 0
    composed = polynomial.split(' + ')      # 먼저 나눈다음
    
    for i in composed:
        if i.isdecimal():                   # 숫자인지부터 본다: len(i)으로 하면 상수항도 걸림
            constant += int(i)
        elif i == 'x':                      # 변수항인가
            coefficient += 1
        elif i[-1] == 'x':                  # 맨 나중에 계수가 1인 x를 거르도록
            coefficient += int(i[:-1])
    
    if coefficient != 0:
        if constant != 0:
            return f'{coefficient}x + {constant}'
        else:
            return f'{coefficient}x'
    else:
        if constant != 0:
            return f'{constant}'
