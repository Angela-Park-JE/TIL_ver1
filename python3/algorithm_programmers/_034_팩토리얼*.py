"""
"""





"""오답노트"""

# 23.05.07
# 바보였다. 나는 해당 정수 미만의 정수들을 곱하는데, 그 곱의 결과가 해당 정수(n) 이하인 값을 찾는 일이라고 착각을 해버렸다. 그래서 해당정수 넣고 인덱스 돌려버렸음.
# 팩토리얼을 했을 때 해당 정수 이하의 값이 나오는 수를 찾는 일인데 말이다.
def solution(n):
    nlist = [j*j for j in [i for i in range(1,n+1)]]
    nlist.append(n)
    nlist.sort()
    
    return nlist[nlist.index(n)-1]
