'''
working time 
h, m, s의 경우 튜플로 한 줄에 넣을 경우 차례로 되지 않는지 오류가 생기므로 예쁘게 출력하려면 어쩔 수 없이 길어진다.

h = int(wt//3600)
m = int((wt%3600)//60)
s = round(wt%60, 1)
와
h = int(wt//3600)
m = int((wt - h*3600)//60)
s = int(round(wt - h*3600 - m*60, 0))
은 의미상 같다.
'''

# 1. Simple one : if want to know as a float
import time
start = time.time()
# working code --
end = time.time()
print("Working Time: %.4f"%(end-start))


# 2. H, M, S(.1)
import time
start = time.time()
# ~~ working code ~~
wt = time.time() - start  # working time
h = int(wt//3600)
m = int((wt%3600)//60)
s = round(wt%60, 1)
print("Working Time: {}Hours {}Min {}Sec".format(h, m, s))


# 3. HH:MM:SS
import time
start = time.time()
# ~~ working code ~~
wt = time.time() - start  # working time
h = int(wt//3600)
m = int((wt - h*3600)//60)
s = int(round(wt - h*3600 - m*60, 0))
print("Working Time: {}:{}:{}".format(h, m, s))
