"""

https://www.hackerrank.com/challenges/one-week-preparation-kit-zig-zag-sequence/problem

In this challenge, the task is to debug the existing code to successfully execute all provided test files.

Given an array of 'n' distinct integers, transform the array into a zig zag sequence by permuting the array elements. 
A sequence will be called a zig zag sequence if the first 'k' elements in the sequence are in increasing order 
  and the last 'k' elements are in decreasing order, where 'k=(1+n)/2'. 
You need to find the lexicographically smallest zig zag sequence of the given array.

이 과제에서 과제는 제공된 모든 테스트 파일을 성공적으로 실행하기 위해 기존 코드를 디버깅하는 것입니다.

'n'개의 다른 정수 배열을 지정하면 배열 요소를 순열화하여 배열을 지그재그 시퀀스로 변환합니다. 
수열의 첫 번째 'k' 원소가 증가 순서이고 마지막 'k' 원소가 감소 순서인 경우 수열을 지그재그 수열이라고 합니다. 
여기서 'k=(1+n)/2'입니다. 주어진 배열에서 사전학적으로 가장 작은 지그재그 시퀀스를 찾아야 합니다.

"""

def findZigZagSequence(a, n):
    a.sort()
    mid = int((n + 1)/2)
    a[mid], a[n-1] = a[n-1], a[mid]

    st = mid + 1
    ed = n - 1
    
    while(st <= ed):
        a[st], a[ed] = a[ed], a[st]
        st = st + 1
        ed = ed + 1

    for i in range (n):
        if i == n-1:
            print(a[i])
        else:
            print(a[i], end = ' ')
    return

test_cases = int(input())
for cs in range (test_cases):
    n = int(input())
    a = list(map(int, input().split()))
    findZigZagSequence(a, n)
