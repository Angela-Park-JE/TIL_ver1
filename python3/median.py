"""
중앙값: 홀수의 경우 정 중앙번 째 값, 짝수의 경우 중앙에 위치한 두 값의 평균
코드 출처: https://codingdojang.com/scode/611?langby=python 
(김영성 님: https://codingdojang.com/profile/answer/7003)
"""
# n은 list, print로 출력하는 것을 return으로 반환하도록 수정
def median(n):
    n.sort()
    return(n[int(len(n)/2)] if len(n) %2 == 1 else (n[int(len(n)/2)] + n[int(len(n)/2)-1])/2)
