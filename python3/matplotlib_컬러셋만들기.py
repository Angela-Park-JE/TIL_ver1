"""시퀀셜 컬러맵에서 컬러 가져와서 리스트 만들기"""
# 원하는 방식으로 가져와서 쓸 수 있다
colors = plt.get_cmap('Set3')(np.linspace(0, 1, int(df['class'].nunique())))
colors = plt.cm.Set3(np.linspace(0, 1, int(df['class'].nunique())))

# pie 차트 내장 컬러셋이 별로라서 만들게 되었다.
plt.pie(Har_top30['Harbinger'], labels=Har_top30['class'], autopct='%.2f%%', startangle=90, 
        counterclock=False, wedgeprops=wedgeprops, pctdistance=0.9, 
        colors=colors)



"""특정 팔레트의 특정 색상을 가져오기"""
### matplotlib에서
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
# 팔레트를 가져와서
rocket_palette = plt.cm.Set3.colors
# 만약 두 번째 색상을 가져온다면
second_color = rocket_palette[1]
# 예를 든다면 합쳐서, 컬러가 들어갈 부분에 바로 넣으면 가능하다.
plt.gca().get_xticklabels()[highlight_index].set_color(plt.cm.Set3.colors[1]) 

### Seaborn에서 color_palette()를 사용하면 된다.
import seaborn as sns
# 기본 색상 팔레트 가져오기
palette = sns.color_palette(palette = 'rocket')
# 두 번째 색상 출력
print(palette[1])
