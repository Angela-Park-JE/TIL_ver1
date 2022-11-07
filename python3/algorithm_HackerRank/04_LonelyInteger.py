"""
Prepare> Interview Preparation Kits> 1 Week Preparation Kit> Day 2> Lonely Integer
https://www.hackerrank.com/challenges/one-week-preparation-kit-lonely-integer/problem
"""

""" what I thought first, but it return `None` """

def lonelyinteger(a):
    ar = list(a)
    dic = dict.fromkeys(ar)
    for k in dic.keys():
        dic[k] = int(0)
    for i in ar:
        dic[i] = dic[i] + 1
    for k, v in dic.items():
        if v < 2:
            print(k)

""" other ways, but it return `None` too.. """
def lonelyinteger(a):
    ar = list(a)
    zeros = [0] * n
    dic = dict(zip(ar, zeros)) 
    for i in ar:
        dic[i] = dic[i] + 1
    for k, v in dic.items():
        if v < 2:
            print(k) 
