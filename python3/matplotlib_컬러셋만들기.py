# 원하는 방식으로 가져와서 쓸 수 있다
colors = plt.get_cmap('Set3')(np.linspace(0, 1, int(df['class'].nunique())))
colors = plt.cm.Set3(np.linspace(0, 1, int(df['class'].nunique())))

# pie 차트 내장 컬러셋이 별로라서 만들게 되었다.
plt.pie(Har_top30['Harbinger'], labels=Har_top30['class'], autopct='%.2f%%', startangle=90, 
        counterclock=False, wedgeprops=wedgeprops, pctdistance=0.9, 
        colors=colors)
