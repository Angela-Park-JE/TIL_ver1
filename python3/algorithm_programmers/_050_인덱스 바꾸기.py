"""
코딩테스트 연습> 코딩테스트 입문> 인덱스 바꾸기
https://school.programmers.co.kr/learn/courses/30/lessons/120895
문제 설명
  문자열 my_string과 정수 num1, num2가 매개변수로 주어질 때, my_string에서 인덱스 num1과 인덱스 num2에 해당하는 문자를 바꾼 문자열을 return 하도록 solution 함수를 완성해보세요.
제한사항
  1 < my_string의 길이 < 100
  0 ≤ num1, num2 < my_string의 길이
  my_string은 소문자로 이루어져 있습니다.
  num1 ≠ num2
"""



# 23.12.29:
def solution(my_string, num1, num2):
    # 문자열 치환으로는 자리를 바꾸는 것이아니라 해당 요소를 바꿔버리기 때문에 정답이 될 수 없음  
    # answer = my_string
    # answer = answer.replace(answer[num1], my_string[num2])
    # answer = answer.replace(answer[num2], my_string[num1])
    
    
    # 따라서 리스트로 만든 다음 해당 위치만 바꾸도록
    answer = list(my_string)
    answer[num1], answer[num2] = my_string[num2], my_string[num1]
    s = ''
    for i in answer:
        s = s+i
    return s

# 다른 풀이를 참조한다고 하면 s = '' 이 부분부터 return s 까지를
# return ''.join(s) <- 이 한 줄로 끝낼 수 있다. join이 생각이 나지 않았다...
