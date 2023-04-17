"""
코딩테스트 연습> 코딩테스트 입문> 배열 뒤집기(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120821
문제 설명
  정수가 들어 있는 배열 num_list가 매개변수로 주어집니다. num_list의 원소의 순서를 거꾸로 뒤집은 배열을 return하도록 solution 함수를 완성해주세요.
제한사항
  1 ≤ num_list의 길이 ≤ 1,000
  0 ≤ num_list의 원소 ≤ 1,000
"""



# 23.04.17
# 2분만에 쓰면서 풀긴 했는데 생각을 바로 할 수 있었던 이유는 
# 임백준-<누워서 읽는 알고리즘> 책을 마침 빌려와서 앞 부분을 읽는데, 미국에 있을 때 대학원 졸업하고 회사 면접보는데 이런 테스트를 겪었다고 예시로 나와서 잠시 생각했었기 떄문이다.
# index_list 만들지 않고 num_list에 직접 음수 인덱스로 거꾸로 출력하는 방법도 있긴 할 것이다. (음수 인덱스가 안되는 언어에선 이렇게 해야하려나?)
# 인덱스 받아서 리스크로 만들어놓고, 해당 리스트를 거꾸로 정렬(정수인덱스의 크기 내림차순)해둔다. 해당 인덱스리스트로 간단히, num_list에서 호출해온다.
# 길어도 안정적이지 않을까 하는 생각...
def solution(num_list):
    index_list = [x for x in range(len(num_list))]
    index_list.sort(reverse = True)
    
    answer = []
    for i in index_list:
        answer.append(num_list[i])
    
    return answer
