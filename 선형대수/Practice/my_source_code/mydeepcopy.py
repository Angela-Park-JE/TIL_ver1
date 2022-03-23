def zero_mat(n, p):
    """
    영 행렬 생성
    입력값: 생성하고자 하는 영 행렬의 크기 (n행, p열)
    출력값: (n x p) 영 행렬 Z
    """
    Z = []
    for i in range(0,n):
        row = []
        for j in range(0,p):
            row.append(0)
        Z.append(row)
    return Z

def deepcopy(A):
    """
    깊은 복사 (deepcopy) 함수 구현
    입력값: 깊은 복사를 하고자 하는 행렬 리스트 A
    출력값: 깊은 복사된 결과 행렬 리스트 res
    """
    
    if type(A[0]) == list:
        n = len(A)
        p = len(A[0])
        res = zero_mat(n,p)
        for i in range(0, n):
            for j in range(0, p):
                res[i][j] = A[i][j]
        return res
    else:
        n = len(A)
        res = []
        for i in range(0,n):
            res.append(A[i])
        return res
