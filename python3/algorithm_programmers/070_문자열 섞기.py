# 코딩테스트 연습> 코딩 기초 트레이닝> 문자열 섞기
# https://school.programmers.co.kr/learn/courses/30/lessons/181942#
# 길이가 같은 두 문자열 str1과 str2가 주어집니다.
# 두 문자열의 각 문자가 앞에서부터 서로 번갈아가면서 한 번씩 등장하는 문자열을 만들어 return 하는 solution 함수를 완성해 주세요.


# 240720: 
def solution(str1, str2):
    # (1) 원래라면 했을 방식
    # s = ""
    # for i in range(len(str1)):
    #     s = s+str1[i]+str2[i]
    
    # (2) 한 줄 방식
    s = "".join(str1[i]+str2[i]for i in range(len(str1)))
    return s
