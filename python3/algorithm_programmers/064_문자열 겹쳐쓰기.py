# 코딩테스트 연습> 코딩 기초 트레이닝> 문자열 겹쳐쓰기
# https://school.programmers.co.kr/learn/courses/30/lessons/181943
#   문자열 my_string, overwrite_string과 정수 s가 주어집니다. 
#   문자열 my_string의 인덱스 s부터 overwrite_string의 길이만큼을 문자열 overwrite_string으로 바꾼 문자열을 return 하는 solution 함수를 작성해 주세요.
# 제한사항
#   my_string와 overwrite_string은 숫자와 알파벳으로 이루어져 있습니다.
#   1 ≤ overwrite_string의 길이 ≤ my_string의 길이 ≤ 1,000
#   0 ≤ s ≤ my_string의 길이 - overwrite_string의 길이


# 24.07.20: 바꿀 것 앞 + (바꾼 것) + 바꿀 것 뒤
def solution(my_string, overwrite_string, s):
    c =  my_string[:s] + overwrite_string[:len(my_string)-s] + my_string[s+len(overwrite_string):]
    return c



### 오답노트 ###
# 24.02.23: replace로 직접 대체하는 방식. 6번 케이스에서 오답으로 뜨는데 왜 오답으로 뜨는지 모르겠다...
def solution(my_string, overwrite_string, s):
    answer = my_string.replace(my_string[s:s+len(overwrite_string)], overwrite_string)
    return answer

# 24.07.20: test6에서만 실패가 뜨는데, 아마 둘의 길이가 같거나 하는, 많이 없는 경우에 있는 건 아닐까 생각했다.
    # 그래서 대체가 아니라 해당 부분을 잘라낸 뒤 붙이는 방식으로 
def solution(my_string, overwrite_string, s):
    c =  my_string[:s] + overwrite_string + my_string[s+len(overwrite_string):]
    return c
    # 입력값 〉	"12345678", "ab", 7
    # 기댓값 〉	"1234567a" 
    # 실행 결과 〉	실행한 결괏값 "1234567ab"이 기댓값 "1234567a"과 다릅니다. -- 같은 문제가 생겼다.

# 24.07.20: 직접 대체하는 방식을 만들었던 것에서 착안하여, 대체되는 것의 길이를 my_string에서 s를 뺀만큼으로, 직접 정해주도록 고쳤다.
# 그러나 테스트 케이스 6번에서 여전히 막혔다. 어떤 케이스를 내가 생각하지 못한 것일까?
def solution(my_string, overwrite_string, s):
    answer = my_string.replace(my_string[s:s+len(overwrite_string)], overwrite_string[:len(my_string)-s])
    return answer

# 24.07.20: 
    # 테스트 케이스를 질문하기에서 가져왔다. replace는 해당 문자 자체를 다 바꿔버리는 식이라,
    # 만약 같은 문자가 나오게되면 그것을 전부 바꿔버리게 된다는 단점이 있다. 
    # 따라서 replace의 인수로 1을 추가하여 첫번째 발견되는 곳에 대해 대체하라고 쓸 수도 있다.
    # 그러나 그게 앞에도 반복되는데 원래 바꾸어야 할 해당 위치가 뒤일 수도 있다.
    # 따라서 replace보다는 명확히 위치를 정해주어 더하는 방식이 나을 수 있을 것 같다. -> 정답으로!
def solution(my_string, overwrite_string, s):
    answer = my_string.replace(my_string[s:s+len(overwrite_string)], overwrite_string[:len(my_string)-s], 1)
    return answer
