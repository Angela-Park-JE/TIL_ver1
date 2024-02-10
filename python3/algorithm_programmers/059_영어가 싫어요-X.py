"""
코딩테스트 연습> 코딩테스트 입문> 영어가 싫어요
https://school.programmers.co.kr/learn/courses/30/lessons/120894
문제 설명
  영어가 싫은 머쓱이는 영어로 표기되어있는 숫자를 수로 바꾸려고 합니다. 문자열 numbers가 매개변수로 주어질 때, numbers를 정수로 바꿔 return 하도록 solution 함수를 완성해 주세요.
제한사항
  numbers는 소문자로만 구성되어 있습니다.
  numbers는 "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" 들이 공백 없이 조합되어 있습니다.
  1 ≤ numbers의 길이 ≤ 50
  "zero"는 numbers의 맨 앞에 올 수 없습니다.
"""



# 방법 1
def solution(numbers):
    num_dic = dict(zip(["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" ], 
                   [str(i) for i in range(0, 10)]))
    for n in list(num_dic.keys()):
        numbers = numbers.replace(n, num_dic[n])
    return int(numbers)

# 방법 2 24.02.10: import re 로 활용하여 변경 (사실 그게 그거)
def solution(numbers):
    num_dic = dict(zip(["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"], 
                   [str(i) for i in range(0, 10)]))
    import re
    for n in list(num_dic.keys()):
        numbers = re.sub(n, num_dic[n], numbers)
    return int(numbers)



"""다른 풀이"""
# 깔끔하다. enumerate함수를 쓰면 되는 것이었는데 오답노트 두번째 것이 그런걸 만들고 싶었던 것이었다. 
# 김현우 , honeyhyuni , kimdoyoeung , 이찬우 외 49 명
def solution(numbers):
    for num, eng in enumerate(["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]):
        numbers = numbers.replace(eng, str(num))
    return int(numbers)
# 인덱스를 활용하고 싶었다면 역으로 인덱스로 list에서 가져와서 replace에 넣고, 숫자는 직접 쓰면 되는 것이었다...
# 봉글봉글 , 이영우 , 김윤동 , HwangHunJo 외 26 명
def solution(numbers):
    alpha = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    for i in range(10) :
        numbers = numbers.replace(alpha[i],str(i))
    return int(numbers)

# 딕셔너리 안쓰고 해결한 방법. 와 이것 좋다!
# 김재희 , songbyungsub , - , blueberry 외 1 명
def solution(numbers):
    dic = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    i=0
    for word in dic:
        numbers = numbers.replace(word, str(i))
        i+=1
    return int(numbers)

# 이건 어떻게 푼거라고 할 수 있는지 이해하지 못했다.
# zfra
def solution(numbers):

    nums = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    res = 0
    while numbers != "":
        r= [n for n in nums if numbers.startswith(n)]
        numbers = numbers[len(r[0]):]
        res = res*10 + nums.index(r[0])

    return res



"""오답노트"""
# 맨 처음 했던 것. 미해결 문제를 데려왔는데 바보같이 answer에 새로 적용을 하고 있었다. ㅎ ㅏ...
def solution(numbers):
    num_dic = dict(zip(["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" ], 
                   [str(i) for i in range(0, 10)]))
    for n in list(num_dic.keys()):
        answer = numbers.replace(n, num_dic[n])
    return answer

# 안된 것... 인덱스를 바로 가져오고 싶었는데 에러가 난다.
# 24.02.10 2번째 방법 여기서 한단계 더, int range를 따로 만들지 않고 해보기 
def solution(numbers):
    nums = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" ]
    import re
    # s = [re.sub(n, nums.index(n), numbers) for n in nums] <- 이게 안돼서 for문을 만듬
    # for n in nums: # 이것도 안됨.
    #     numbers = re.sub(n, nums.index(n), numbers) 
    # TypeError: decoding to str: need a bytes-like object, int found 오류 
    return numbers
