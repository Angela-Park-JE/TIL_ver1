"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 3> Caesar Cipher
https://www.hackerrank.com/challenges/one-week-preparation-kit-caesar-cipher-1/problem
Julius Caesar protected his confidential information by encrypting it using a cipher. 
Caesar's cipher shifts each letter by a number of letters. 
If the shift takes you past the end of the alphabet, just rotate back to the front of the alphabet. 
In the case of a rotation by 3, w, x, y and z would map to z, a, b and c.

* Function Description
  Complete the caesarCipher function in the editor below.
  caesarCipher has the following parameter(s):
  string s: cleartext
  int k: the alphabet rotation factor
* Returns
  string: the encrypted string
* Input Format
  The first line contains the integer, `n`, the length of the unencrypted string.
  The second line contains the unencrypted string, `s`.
  The third line contains `k`, the number of letters to rotate the alphabet by.
"""

""" 과정: 
    1. 암호화하는 딕셔너리를 만든다. 대문자 소문자를 모두 포함하는 딕셔너리를 만드는 것이 낫다고 생각했다.
    2. 특수문자오류. 특수문자는 딕셔너리에 있는지 여부로 판별하여 그대로 출력하도록 바꾼다.
    3. 만약 k가 알파벳 개수를 넘어가게 되면 오류가 났다. 이는 k를 알파벳 개수로 나누어 나머지만큼 돌도록 한다. 
    주피터노트북 켜두고 실험하는게 훨씬 빠르고 편했다...
"""

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'caesarCipher' function below.
#
# The function is expected to return a STRING.
# The function accepts following parameters:
#  1. STRING s
#  2. INTEGER k


def caesarCipher(s, k):
    # making alphabet list 
    from string import ascii_lowercase, ascii_uppercase
    a_list = list(ascii_lowercase)
    A_list = list(ascii_uppercase)
    # case when k >= alphabet list length
    if k< len(a_list):
        k = k
    elif k>= len(a_list):
        k = k%len(a_list)
    # cut and extend each list
    popped = a_list[:k]
    cut = a_list[k:]
    Popped = A_list[:k]
    Cut = A_list[k:]
    added = cut + popped
    Added = Cut + Popped
    #make cipher dictionary
    cipher1 = { x:y for x, y in zip(a_list, added) }
    cipher2 = { x:y for x, y in zip(A_list, Added) }
    cipher1.update(cipher2)
    # generate the `s` with single alphabet 
    for i in range(len(s)):
        if s[i] in cipher1:
            if i == 0:
                a = s[i]
                b = cipher1.get(a)
                c = b
            elif i != 0:
                a = s[i]
                b = cipher1.get(a)
                c = c + b
        elif s[i] not in cipher1:
            if i == 0:
                a = s[i]
                c = a
            elif i != 0:
                a = s[i]
                c = c + a
            
    return c
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = input()

    k = int(input().strip())

    result = caesarCipher(s, k)

    # fptr.write(result + '\n')
    fptr.write(result)
    fptr.close()
