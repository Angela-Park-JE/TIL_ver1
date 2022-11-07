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


def 
