
"""
코딩테스트 연습> 코딩테스트 입문> 가위 바위 보(lv0)
https://school.programmers.co.kr/learn/courses/30/lessons/120839
문제 설명
  가위는 2 바위는 0 보는 5로 표현합니다. 가위 바위 보를 내는 순서대로 나타낸 문자열 rsp가 매개변수로 주어질 때, 
  rsp에 저장된 가위 바위 보를 모두 이기는 경우를 순서대로 나타낸 문자열을 return하도록 solution 함수를 완성해보세요.
제한사항
  0 < rsp의 길이 ≤ 100
  rsp와 길이가 같은 문자열을 return 합니다.
  rsp는 숫자 0, 2, 5로 이루어져 있습니다.
"""



# 23.04.28
# 딕셔너리를 만들어두는게 가장 빠를 것이라 생각되었다.
def solution(rsp):
    dicrsp = {'2':'0', '0':'5', '5':'2'}
    rsp = list(rsp)
    answer = ''
    
    for i in rsp:
        answer += dicrsp[i]
    
    return answer
