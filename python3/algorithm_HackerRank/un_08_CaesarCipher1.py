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
    # Write your code here
    # making alphabet list 
    from string import ascii_lowercase
    alphabet_list = list(ascii_lowercase)
    print(alphabet_list)
    
    
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = input()

    k = int(input().strip())

    result = caesarCipher(s, k)

    fptr.write(result + '\n')

    fptr.close()
